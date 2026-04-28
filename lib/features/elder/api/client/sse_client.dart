import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/end_points_constants.dart';
import '../models/request/ai_chat/run_sse_request.dart';

@lazySingleton
class SseClient {
  late final Dio _dio;

  SseClient() {
    _dio =
        Dio(
            BaseOptions(
              baseUrl: EndPointsConstants.aiBaseUrl,
              headers: {'ngrok-skip-browser-warning': 'true'},
            ),
          )
          ..interceptors.add(
            PrettyDioLogger(
              requestHeader: true,
              requestBody: true,
              responseBody: false,
              responseHeader: false,
            ),
          );
  }

  Stream<String> stream({
    required String userId,
    required String sessionId,
    required String message,
    String? imageBase64,
    String? imageMimeType,
    String? imageDisplayName,
  }) async* {
    debugPrint(
      '🚀 [SSE] Starting stream | userId=$userId | sessionId=$sessionId | message=$message',
    );
    final parts = <SseMessagePart>[
      SseMessagePart.text(message),
      if (imageBase64 != null && imageMimeType != null)
        SseMessagePart.image(
          base64Data: imageBase64,
          mimeType: imageMimeType,
          displayName: imageDisplayName,
        ),
    ];

    final requestBody = RunSseRequest(
      appName: Constants.appName,
      userId: userId,
      sessionId: sessionId,
      newMessage: SseMessage(parts: parts),
    );

    final response = await _dio.post<ResponseBody>(
      EndPointsConstants.runSse,
      data: jsonEncode(requestBody.toJson()),
      options: Options(
        responseType: ResponseType.stream,
        validateStatus: (_) => true,
        headers: {'Content-Type': 'application/json'},
      ),
    );

    debugPrint('📡 [SSE] Response status: ${response.statusCode}');

    if (response.statusCode != 200) {
      final bytes = await (response.data as ResponseBody).stream
          .cast<List<int>>()
          .expand((x) => x)
          .toList();
      final errorBody = utf8.decode(bytes);
      throw Exception('Server error ${response.statusCode}: $errorBody');
    }

    final responseBody = response.data;
    if (responseBody == null) {
      return;
    }

    debugPrint('✅ [SSE] Stream started, waiting for chunks...');

    final buffer = StringBuffer();
    int yieldCount = 0;

    await for (final chunk in responseBody.stream.cast<List<int>>().transform(
      utf8.decoder,
    )) {

      buffer.write(chunk);

      final current = buffer.toString();
      final lines = current.split('\n');

      buffer.clear();

      if (!current.endsWith('\n')) {
        final incomplete = lines.removeLast();
        buffer.write(incomplete);
      } else {
        lines.removeLast();
      }

      for (final line in lines) {
        final trimmed = line.trim();

        if (!trimmed.startsWith('data:')) {
          continue;
        }

        final data = trimmed.substring(5).trim();

        if (data.isEmpty) {
          continue;
        }
        if (data == '[DONE]') {
          continue;
        }

        final extracted = _extractText(data);

        if (extracted.isNotEmpty) {
          yieldCount++;
          debugPrint('➡️  [SSE] Yielding chunk #$yieldCount: "$extracted"');
          yield extracted;
        } else {
          debugPrint('⚠️  [SSE] Extracted text is empty — skipping yield');
        }
      }
    }

  }

  String _extractText(String data) {
    try {
      final json = jsonDecode(data) as Map<String, dynamic>;

      // ✅ Skip the final summary event — it duplicates the full response
      if (json.containsKey('finishReason') || json.containsKey('usageMetadata')) {
        debugPrint('⏭️  [SSE] Skipping final summary event (finishReason present)');
        return '';
      }

      // Shape 1
      final content = json['content'];
      if (content is Map) {
        final parts = content['parts'];
        if (parts is List && parts.isNotEmpty) {
          final text = (parts.first as Map)['text']?.toString() ?? '';
          debugPrint('🧩 [SSE] Shape 1 matched — text: "$text"');
          return text;
        }
      }

      // Shape 2
      final text = json['text'];
      if (text != null) {
        debugPrint('🧩 [SSE] Shape 2 matched — text: "$text"');
        return text.toString();
      }

      // Shape 3
      final resp = json['response'];
      if (resp is String) {
        debugPrint('🧩 [SSE] Shape 3 matched — response: "$resp"');
        return resp;
      }

      debugPrint('⚠️  [SSE] No matching shape — full JSON: $json');
      return '';
    } catch (e) {
      debugPrint('❌ [SSE] JSON parse error: $e | raw data: "$data"');
      return '';
    }
  }
}
