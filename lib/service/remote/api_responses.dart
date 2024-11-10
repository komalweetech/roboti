import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiResponses {
  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body);
      case 201:
        return jsonDecode(response.body);
      case 409:
        return jsonDecode(response.body);
      case 406:
        return jsonDecode(response.body);
      case 400:
        // throw BadRequestException(response.body.toString());
        return jsonDecode(response.body);
      case 404:
        return jsonDecode(response.body);
      // throw UnauthorisedException(response.body.toString());
      // case 406:
      //   throw UnauthorisedException(response.body.toString());
      case 422:
        return jsonDecode(response.body);
      // throw UnauthorisedException(response.body.toString());

      case 500:
        // throw UnauthorisedException(response.body.toString());
        return jsonDecode(response.body);
      default:
        return jsonDecode(response.body);
      // throw FetchDataException(
      //     "Error occured while communicating with server with status code ${response.statusCode}");
    }
  }
}
