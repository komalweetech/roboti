import 'package:roboti_app/utils/shared_pref_manager/shared_pref.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final SharedPrefsManager _sharedPrefsManager;

  ApiService(this._sharedPrefsManager);

  Map<String, String> _getAuthorizedHeaders() {
    final token = _sharedPrefsManager.getData("token");
    final headers = <String, String>{};

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    return headers;
  }

  Future<http.Response> getData(Uri uri) async {
    final headers = _getAuthorizedHeaders();
    return await http.get(uri, headers: headers);
  }

  Future<http.Response> postData(Uri uri) async {
    return await http.post(uri);
  }
}
