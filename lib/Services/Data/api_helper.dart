import 'dart:convert';
import 'package:http/http.dart' as http;

/// Custom exception for REST API errors
class ApiException implements Exception {
  final int statusCode;
  final String message;
  final String? details;

  ApiException(this.statusCode, this.message, [this.details]);

  @override
  String toString() => 'ApiException($statusCode): $message${details != null ? " - $details" : ""}';
}

/// Generic response handler for typed API calls.
// ignore: unintended_html_in_doc_comment
/// Supports both single-object (T) and list (List<T>) responses.
R handleResponse<R, T>(
  http.Response response, {
  T Function(Map<String, dynamic>)? fromJson,
}) {
  if (response.statusCode >= 200 && response.statusCode < 300) {
    if (response.body.isEmpty) {
      throw ApiException(response.statusCode, 'Empty response body');
    }

    final decoded = jsonDecode(response.body);

    // Case 1: returning a list of items
    if (R.toString().startsWith('List<') && decoded is List && fromJson != null) {
      final items = decoded.map((e) => fromJson(Map<String, dynamic>.from(e))).toList();
      return items as R;
    }

    // Case 2: returning a single item
    if (decoded is Map && fromJson != null) {
      return fromJson(Map<String, dynamic>.from(decoded)) as R;
    }

    // Fallback for raw types
    return decoded as R;
  } else {
    throw ApiException(
      response.statusCode,
      'API request failed',
      response.body.isNotEmpty ? response.body : null,
    );
  }
}
