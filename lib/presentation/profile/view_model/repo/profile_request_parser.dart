import 'dart:convert';

class ProfileRequestParser {
  String updateProfileRequest({
    required String name,
    required String? imageUrl,
    required String country,
  }) {
    Map<String, dynamic> requestObj = {
      "firstName": name,
      "countryCode": country,
    };
    if (imageUrl != null) {
      requestObj.addEntries({
        "profilePicture": imageUrl,
      }.entries);
    }

    return jsonEncode(requestObj);
  }
}
