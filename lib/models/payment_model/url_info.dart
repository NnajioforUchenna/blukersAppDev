import 'dart:core';

class UrlInfo {
  final bool isSuccess;
  final String? sessionId;

  UrlInfo({required this.isSuccess, this.sessionId});

  UrlInfo.empty()
      : isSuccess = false,
        sessionId = null;

  static UrlInfo parseUrl(String url) {
    try {
      // Check if the URL contains the success path
      bool isSuccess = url.contains("/paymentSuccess/success");

      // Extract session_id from the URL if it's there
      final uri = Uri.parse(url);
      final sessionId = uri.queryParameters['session_id'];

      // If neither a success nor failure path is present, or if there's no session_id, return an empty instance
      if (sessionId == null) {
        return UrlInfo(isSuccess: false, sessionId: null);
      }

      return UrlInfo(isSuccess: isSuccess, sessionId: sessionId);
    } catch (e) {
      print('Error parsing URL: $e');
      return UrlInfo(isSuccess: false, sessionId: null);
    }
  }

  @override
  String toString() {
    return 'UrlInfo{isSuccess: $isSuccess, sessionId: $sessionId}';
  }
}
