import 'dart:convert';

import 'package:roboti_app/presentation/chat/view_model/bloc/chat_bloc.dart';
import 'package:roboti_app/presentation/chat/view_model/repo/chat_request_parser.dart';
import 'package:roboti_app/service/remote/api_urls.dart';
import 'package:roboti_app/service/remote/network_api_services.dart';

class ChatRepo {
  NetworkApiService services = NetworkApiService();
  ChatRequestParser requestParser = ChatRequestParser();

  Future<Map<String, dynamic>> sendMessage() async {
    Map<String, dynamic> request = requestParser.chatReqBody(
      chatBloc.chat,
      chatBloc.chatModel,
    );
    Map<String, dynamic> response = {};
    try {
      response = await services.getPostApiResponse(
        ApiUrls.chatCompletionOpenAIUrl,
        jsonEncode(request),
        addAccessToken: false,
        token: ApiKeys.openAiKey,
      );
    } catch (e) {
      response = {
        "error": {"message": e.toString()}
      };
    }

    if (response.containsKey("timeout")) {
      response = {
        "error": {"message": response['message']},
      };
    }

    return response;
  }
}
