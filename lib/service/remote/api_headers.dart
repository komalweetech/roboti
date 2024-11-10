class ApiHeaders {
  static String userAccessToken = "";
  Map<String, String>? getHeaders({
    bool addAccessToken = true,
    bool contentTypeJson = true,
  }) {
    Map<String, String> headers = {};
    if (addAccessToken) {
      headers.addEntries(accessTokenHeaders.entries);
    }
    if (contentTypeJson) {
      headers.addEntries(contentTypeJsonHeaders.entries);
    }

    return headers.isEmpty ? null : headers;
  }

  Map<String, String> get accessTokenHeaders => {
        "Authorization": userAccessToken,
        // "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NWNiN2VhMTlkZjI0MDVkZTkwNTU5NjgiLCJzdGF0dXMiOiJVc2VyIExvZ2luIiwiZ2VuZXJhdGVkT24iOjE3MDgzNTU3Njc0NjMsImlhdCI6MTcwODM1NTc2N30.m86jb_aQ82V3FCh1wBpXGvYTiWk8Uwsyt591YQhynLk",
        // "LCJzdGF0dXMiOiJVc2VyIExvZ2luIiwiZ2VuZXJhdGVkT24iOjE3MDc3NjM3OTUxMDYsImlhdCI6MTcwNzc2Mzc5NX0.kNas42Uzr-Em8lfM0PLowLb9OcvTxfMgZxhPJnfkoPk",
      };
  Map<String, String> get contentTypeJsonHeaders => {
        "Content-Type": "application/json",
      };
}
