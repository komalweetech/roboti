import 'dart:convert';

class NewsRequestParser {
  String robotiNewsRequest({int page = 1, int limit = 10}) {
    Map<String, dynamic> requestBody = {"page": page, "limit": limit};

    return jsonEncode(requestBody);
  }

  String globalNewsRequest({int page = 1, int limit = 10}) {
    Map<String, dynamic> requestBody = {"page": page, "limit": limit};

    return jsonEncode(requestBody);
  }
}
