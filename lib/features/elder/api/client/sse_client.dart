import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/end_points_constants.dart';
import '../models/request/ai_chat/run_sse_request.dart';

/// Handles SSE streaming via Dio directly
/// Kept as a separate injectable class because Retrofit cannot generate
/// streaming endpoints (it only supports Future-based responses).

@lazySingleton
class SseClient {
  late final Dio _dio;

  SseClient() {
    _dio = Dio(BaseOptions(baseUrl: EndPointsConstants.aiBaseUrl));
  }

  Stream<String> stream({
    required String userId,
    required String sessionId,
    required String message,
  }) async* {
    try {
      final requestBody = RunSseRequest(
        appName: Constants.appName,
        userId: userId,
        sessionId: sessionId,
        newMessage: SseMessage(parts: [SseMessagePart(text: message)]),
      );

      // ResponseType.stream tells Dio not to buffer the full response —
      // instead it gives us a ResponseBody whose stream we read chunk by chunk.
      final response = await _dio.post<ResponseBody>(
        EndPointsConstants.runSse,
        data: requestBody.toJson(),
        options: Options(
          responseType: ResponseType.stream,
          headers: {'Accept': 'text/event-stream', 'Cache-Control': 'no-cache'},
        ),
      );

      final responseBody = response.data;
      if (responseBody == null) return;

      final buffer = StringBuffer();
      // SSE chunks don't always arrive as complete lines — a single TCP packet
      // may contain half a line, or multiple lines. We accumulate raw bytes
      // here until we have complete '\n'-terminated lines to process.

      await for (final chunk in responseBody.stream.cast<List<int>>().transform(
        utf8.decoder,
      )) {
        // responseBody.stream is a Stream<Uint8List> (raw bytes).
        // utf8.decoder transforms it into a Stream<String>.

        buffer.write(chunk);

        String current = buffer.toString();
        final lines = current.split('\n');

        buffer.clear();
        if (!current.endsWith('\n')) {
          buffer.write(lines.removeLast());
          // Incomplete last line — save it back to combine with next chunk.
        } else {
          lines.removeLast();
          // Trailing empty string from split — remove it.
        }

        for (final line in lines) {
          final trimmed = line.trim();

          if (!trimmed.startsWith('data:')) continue;
          // SSE protocol: only process "data:" lines, ignore "event:", "id:", etc.

          final data = trimmed.substring(5).trim();

          if (data.isEmpty || data == '[DONE]') continue;

          final extracted = _extractText(data);
          if (extracted.isNotEmpty) yield extracted;
        }
      }
    } on DioException catch (e) {
      throw Exception('SSE connection failed: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
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

