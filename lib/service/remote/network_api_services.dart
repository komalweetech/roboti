import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/service/remote/api_headers.dart';
import 'package:roboti_app/service/remote/api_responses.dart';
import 'package:roboti_app/utils/extensions/response_extension.dart';
import 'package:roboti_app/service/remote/api_urls.dart';
import 'package:http/http.dart' as http;
import 'package:roboti_app/utils/logs/log_manager.dart';

class NetworkApiService {
  ApiResponses responseClass = ApiResponses();
  Duration timeOutDuration = const Duration(seconds: 30);
  Duration multiparttimeOutDuration = const Duration(seconds: 60);
  ApiHeaders apiHeaders = ApiHeaders();

  Future getGetApiResponse(
    String url, {
    bool addAccessToken = true,
    bool contentTypeJson = true,
  }) async {
    Map<String, dynamic> responseJson = {};
    Response response;
    try {
      var headers = apiHeaders.getHeaders(
        addAccessToken: addAccessToken,
        contentTypeJson: contentTypeJson,
      );
      LogManager.log(head: 'HEADERS', msg: headers.toString());
      response = await http
          .get(
            Uri.parse(url),
            headers: headers,
          )
          .timeout(timeOutDuration, onTimeout: errorResponse);
      responseJson = responseClass.returnResponse(response);
    } on SocketException {
      response = await errorResponse();
    } catch (e) {
      response = await serverErrorResponse();
    }

    if (responseJson.hasInvalidToken()) {
      responseJson.onInvalidToken();
    }
    return responseJson;
  }

  Future<Map<String, dynamic>> getPostApiResponse(
    String url,
    dynamic data, {
    bool addAccessToken = true,
    bool contentTypeJson = true,
    final String? token,
  }) async {
    Map<String, dynamic> responseJson = {};
    Response response;
    try {
      Map<String, String>? headers = apiHeaders.getHeaders(
        addAccessToken: token == null ? addAccessToken : false,
        contentTypeJson: contentTypeJson,
      );

      if (token != null) {
        Map<String, String> authHeader = {"Authorization": "Bearer $token"};
        if (headers == null) {
          headers = authHeader;
        } else {
          headers.addEntries(authHeader.entries);
        }
      }
      LogManager.log(head: 'CHAT IMAGE', msg: headers.toString());
      response = await http
          .post(Uri.parse(url), body: data, headers: headers)
          .timeout(timeOutDuration, onTimeout: errorResponse);
      responseJson = responseClass.returnResponse(response);
    } on SocketException {
      response = await errorResponse();
      return jsonDecode(response.body);
      // rethrow;
    } catch (exp2) {
      response = await serverErrorResponse();
      return jsonDecode(response.body);
    }
    if (responseJson.hasInvalidToken()) {
      responseJson.onInvalidToken();
    }
    return responseJson;
  }

  Future getPutApiResponse(
    String url,
    dynamic data, {
    bool addAccessToken = true,
    bool contentTypeJson = true,
  }) async {
    dynamic responseJson;
    Response response;
    try {
      response = await http
          .put(
            Uri.parse(url),
            body: data,
            headers: apiHeaders.getHeaders(
              addAccessToken: addAccessToken,
              contentTypeJson: contentTypeJson,
            ),
          )
          .timeout(timeOutDuration, onTimeout: errorResponse);
    } on SocketException {
      response = await errorResponse();
    } catch (e) {
      response = await serverErrorResponse();
    }
    responseJson = responseClass.returnResponse(response);
    return responseJson;
  }

  Future getPatchApiResponse(
    String url,
    dynamic data, {
    bool addAccessToken = true,
    bool contentTypeJson = true,
  }) async {
    dynamic responseJson;
    Response response;
    try {
      response = await http
          .patch(
            Uri.parse(url),
            body: data,
            headers: apiHeaders.getHeaders(
              addAccessToken: addAccessToken,
              contentTypeJson: contentTypeJson,
            ),
          )
          .timeout(timeOutDuration, onTimeout: errorResponse);
      responseJson = responseClass.returnResponse(response);
    } on SocketException {
      response = await errorResponse();
    } catch (e) {
      response = await serverErrorResponse();
    }
    return responseJson;
  }

  Future<Response> errorResponse() async {
    String errorJson = jsonEncode({
      "error": {
        "message": lcGlobal.internetConnectionBreakdownDuringCommunication,
      },
      "message": lcGlobal.internetConnectionBreakdownDuringCommunication,
      "internet": true,
      "server": false,
      "timeout": true,
      "data": null,
    });
    return Response(errorJson, 500);
  }

  Future<Response> serverErrorResponse() async {
    String errorJson = jsonEncode({
      "error": {
        "message": lcGlobal.serverIsNotResponding,
      },
      "message": lcGlobal.serverIsNotResponding,
      "internet": false,
      "server": true,
      "timeout": true,
      "data": null,
    });
    return Response(errorJson, 500);
  }

  Future<Map<String, dynamic>> multipartApiCall(File file) async {
    var request = http.MultipartRequest("POST", Uri.parse(ApiUrls.uploadImage));

    // final token = getIt<SharedPrefsManager>().getData("token");
    Map<String, String> headers = apiHeaders.getHeaders(
      addAccessToken: true,
      contentTypeJson: false,
    )!;
    request.headers.addAll(headers);

    // File file = homeBloc.file!;

    request.files.add(
      http.MultipartFile(
        'image',
        file.readAsBytes().asStream(),
        file.lengthSync(),
        filename: file.path,
      ),
    );

    Map<String, dynamic> responseJson = {};

    try {
      http.StreamedResponse resStream = await request.send().timeout(
        multiparttimeOutDuration,
        onTimeout: () async {
          Response res = await errorResponse();
          responseJson = jsonDecode(res.body);
          return StreamedResponse(const Stream.empty(), 500);
        },
      );

      await resStream.stream.transform(utf8.decoder).forEach((value) {
        responseJson.addEntries({
          "image_url": jsonDecode(value)["data"],
        }.entries);
      });
    } on SocketException {
      Response response = await errorResponse();
      responseJson = jsonDecode(response.body);
    } catch (e) {
      Response response = await serverErrorResponse();
      responseJson = jsonDecode(response.body);
    }

    return responseJson;
  }

  dynamic executeWithErrorHandling(Function() function) async {
    Map<String, dynamic> responseJson = {};
    try {
      await function();
    } on SocketException {
      Response response = await errorResponse();
      responseJson = jsonDecode(response.body);
    } catch (e) {
      Response response = await serverErrorResponse();
      responseJson = jsonDecode(response.body);
    }

    return responseJson;
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
