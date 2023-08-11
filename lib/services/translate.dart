import 'dart:convert';

import 'package:http/http.dart' as http;

Future<String> translateText({
  required String text,
  required String targetLanguage,
  String? sourceLanguage,
  String format = 'text',
  String? model,
}) async {
  const String apiKey = 'AIzaSyASLTknnqA92wvWjp7UHQplgFaP_9v8NJw';
  const url =
      'https://translation.googleapis.com/language/translate/v2?&key=' + apiKey;
  final Map<String, dynamic> body = {
    'q': text,
    'target': targetLanguage,
    'format': format,
    if (sourceLanguage != null) 'source': sourceLanguage,
    if (model != null) 'model': model,
    'key': apiKey,
  };

  final response = await http.post(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
    body: json.encode(body),
  );

  if (response.statusCode == 200) {
    final responseBody = json.decode(response.body);
    return responseBody['data']['translations'][0]['translatedText'];
  } else {
    throw Exception('Failed to translate text: ${response.body}');
  }
}
