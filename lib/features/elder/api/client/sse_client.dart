import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/end_points_constants.dart';
import '../models/request/ai_chat/run_sse_request.dart';

@lazySingleton
class SseClient {
  late final Dio _dio;

  SseClient() {
    _dio = Dio(
        BaseOptions(
          baseUrl: EndPointsConstants.aiBaseUrl,
          headers: {
            'ngrok-skip-browser-warning': 'true',
          },
        ))..interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
    )
    );
  }

  Stream<String> stream({
    required String userId,
    required String sessionId,
    required String message,
  }) async* {
    try {
      print('🔵 SSE: starting request for user=$userId session=$sessionId');

      final requestBody = RunSseRequest(
        appName: Constants.appName,
        userId: userId,
        sessionId: sessionId,
        newMessage: SseMessage(parts: [SseMessagePart(text: message)]),
      );
      print('🔵 SSE JSON: ${jsonEncode(requestBody.toJson())}');

      print('🔵 SSE: request body=${requestBody.toJson()}');

      final response = await _dio.post<ResponseBody>(
        EndPointsConstants.runSse,
        data: jsonEncode(requestBody.toJson()),
        options: Options(
          responseType: ResponseType.stream,
          validateStatus: (status) => true,
          headers: {
            'Content-Type': 'application/json',
            // 'Accept': 'text/event-stream',
            // 'Cache-Control': 'no-cache',
            // 'Connection': 'keep-alive',
            // 'ngrok-skip-browser-warning': 'true',
          },
        ),
      );
      if (response.statusCode != 200) {
        final bytes = await (response.data as ResponseBody)
            .stream
            .cast<List<int>>()
            .expand((x) => x)
            .toList();
        final errorBody = utf8.decode(bytes);
        print('🔴 Server error ${response.statusCode}: $errorBody');
        throw Exception('Server error: $errorBody');
      }

      print('🟢 SSE: connected, status=${response.statusCode}');

      final responseBody = response.data;
      if (responseBody == null) {
        print('🔴 SSE: response body is null');
        return;
      }

      final buffer = StringBuffer();

      await for (final chunk in responseBody.stream
          .cast<List<int>>()
          .transform(utf8.decoder)) {
        print('📦 SSE raw chunk: $chunk');

        buffer.write(chunk);

        String current = buffer.toString();
        final lines = current.split('\n');

        buffer.clear();
        if (!current.endsWith('\n')) {
          buffer.write(lines.removeLast());
        } else {
          lines.removeLast();
        }

        for (final line in lines) {
          final trimmed = line.trim();

          if (!trimmed.startsWith('data:')) continue;

          final data = trimmed.substring(5).trim();

          print('📨 SSE data line: $data');

          if (data.isEmpty || data == '[DONE]') continue;

          final extracted = _extractText(data);
          print('✅ SSE extracted text: $extracted');

          if (extracted.isNotEmpty) yield extracted;
        }
      }

      print('🏁 SSE: stream done');
    } on DioException catch (e) {
      // Read the error body from the stream
      String errorBody = '';
      try {
        if (e.response?.data is ResponseBody) {
          final bytes = await (e.response!.data as ResponseBody)
              .stream
              .cast<List<int>>()
              .expand((x) => x)
              .toList();
          errorBody = utf8.decode(bytes);
        } else {
          errorBody = e.response?.data?.toString() ?? '';
        }
      } catch (_) {}

      print('🔴 SSE DioError: ${e.type} | ${e.message}');
      print('🔴 SSE Error body: $errorBody');
      throw Exception('SSE connection failed: $errorBody');
    }
  }

  String _extractText(String data) {
    try {
      final json = jsonDecode(data) as Map<String, dynamic>;

      // Shape 1 — ADK standard: { "content": { "parts": [ { "text": "..." } ] } }
      final content = json['content'];
      if (content is Map) {
        final parts = content['parts'];
        if (parts is List && parts.isNotEmpty) {
          return (parts.first as Map)['text']?.toString() ?? '';
        }
      }

      // Shape 2 — Flat: { "text": "..." }
      final text = json['text'];
      if (text != null) return text.toString();

      // Shape 3 — Wrapper: { "response": "..." }
      final resp = json['response'];
      if (resp is String) return resp;

      return '';
    } catch (_) {
      return data;
    }
  }
}