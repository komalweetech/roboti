import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
// import 'package:roboti_app/common/error_messages/error_messages.dart';
// import 'package:roboti_app/common/widget/snack_bar/my_snackbar.dart';
import 'package:roboti_app/presentation/home/model/prompt_model.dart';
import 'package:roboti_app/presentation/home/view_model/repo/home_request_parser.dart';
import 'package:roboti_app/service/di.dart';
import 'package:roboti_app/service/remote/api_urls.dart';
import 'package:roboti_app/service/remote/network_api_services.dart';
import 'package:roboti_app/service/version_service.dart';
import 'package:roboti_app/utils/shared_pref_manager/pref_keys.dart';
import 'package:roboti_app/utils/shared_pref_manager/shared_pref.dart';

class HomeRepo {
  NetworkApiService services = NetworkApiService();
  HomeRequestParser requestParser = HomeRequestParser();

  Future<bool> requireForceUpdate() async {
    try {
      String appStoreVersion = getIt<PackageInfo>().version;
      final response = await services.getGetApiResponse(
        ApiUrls.versionApi,
        addAccessToken: false,
      );

      String serverVersion = response['data']['version'];
      // bool apply = VersionService.checkVersion('10.30.1', '10.3.2');
      bool apply = VersionService.checkVersion(appStoreVersion, serverVersion);
      return apply;
    } catch (e) {
      return false;
    }
  }

// repo
  Future<String?> getFCMToken() async {
    String? token;

    final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

    try {
      token = await firebaseMessaging.getToken();
      if (token != null) {
        // Sending fcm to backend
        await _sendFCMTokenToBackend(token);
      }
    } catch (e) {
      // ErrorMessages.display(e.toString());
      return null;
    }
    return token;
  }

  Future<String?> _sendFCMTokenToBackend(String token) async {
    try {
      String requestBody = requestParser.getSendFCMTokenReqBody(token);
      Map<String, dynamic> responseBody;

      responseBody =
          await services.getPostApiResponse(ApiUrls.sendFCMUrl, requestBody);

      debugPrint(responseBody.toString());
      await getIt<SharedPrefsManager>().saveData(PrefKeys.fcmKey, true);
      // MySnackbar.showSnackbar(responseBody['message']);
    } catch (e) {
      rethrow;
    }

    return null;
  }

  Future<Map<String, dynamic>> getAllCategories() async {
    Map<String, dynamic> responseBody;
    String requestBody = requestParser.getCategoriesReqBody(page: 1, limit: 10);

    try {
      responseBody =
          await services.getPostApiResponse(ApiUrls.categoriesUrl, requestBody);
    } catch (e) {
      responseBody = {"data": null, "message": e.toString()};
    }

    return responseBody;
  }

  Future<Map<String, dynamic>> translateText(
      PromptModel model, bool translateInEng) async {
    Map<String, dynamic> responseBody = {};
    if (model.translatedContent.isEmpty) {
      String url =
          "${ApiUrls.googleTranslationUrl}?key=${ApiKeys.googleApiKey}";
      String requestBody = requestParser.getGoogleTranslationReqBody(
          model.content, translateInEng);
      try {
        responseBody = await services.getPostApiResponse(url, requestBody);
        // await services.getPostApiResponse(ApiUrls.tasksUrl, requestBody);
      } catch (e) {
        responseBody = {
          "error": {"message": e.toString()}
        };
      }
    }
    return responseBody;
  }

  Future<Map<String, dynamic>> getAllTasks(String categoryId) async {
    Map<String, dynamic> responseBody;
    String requestBody = requestParser.getTasksReqBody(
      categoryId: categoryId,
      page: 1,
      limit: 10,
    );

    try {
      responseBody =
          await services.getPostApiResponse(ApiUrls.tasksUrl, requestBody);
    } catch (e) {
      responseBody = {"data": null, "message": e.toString()};
    }

    return responseBody;
  }

  Future<Map<String, dynamic>> getTaskFields(String taskId) async {
    Map<String, dynamic> responseBody;
    String requestBody = requestParser.getFieldsReqBody(taskId: taskId);

    try {
      responseBody =
          await services.getPostApiResponse(ApiUrls.fieldsUrl, requestBody);
    } catch (e) {
      responseBody = {"data": null, "message": e.toString()};
    }

    if (responseBody.containsKey("timeout")) {
      responseBody = {
        "error": {"message": responseBody["message"]},
        "data": null,
      };
    }

    return responseBody;
  }

  Future<Map<String, dynamic>> generateChatCompletion(
    List<Map<String, dynamic>> prompts,
  ) async {
    Map<String, dynamic> responseBody;
    String requestBody = requestParser.getMessageReqBody(prompts: prompts);

    try {
      responseBody = await services.getPostApiResponse(
        ApiUrls.chatCompletionOpenAIUrl,
        requestBody,
        addAccessToken: false,
        contentTypeJson: true,
        token: ApiKeys.openAiKey,
      );
    } catch (e) {
      responseBody = {
        "error": {"message": e.toString()},
        "data": null,
      };
    }

    if (responseBody.containsKey("timeout")) {
      responseBody = {
        "error": {"message": responseBody["message"]},
        "data": null,
      };
    }

    return responseBody;
  }

  Future<Map<String, dynamic>> generateChatVision(
    String imageUrl,
    List<PromptModel> prompts,
  ) async {
    Map<String, dynamic> responseBody;
    String requestBody = requestParser.getMessageVisionReqBody(
      imageUrl: imageUrl,
      prompts: prompts,
    );

    try {
      responseBody = await services.getPostApiResponse(
        ApiUrls.chatCompletionOpenAIUrl,
        requestBody,
        addAccessToken: false,
        contentTypeJson: true,
        token: ApiKeys.openAiKey,
      );
    } catch (e) {
      responseBody = {
        "error": {"message": e.toString()},
        "data": null,
      };
    }

    if (responseBody.containsKey("timeout")) {
      responseBody = {
        "error": {"message": responseBody["message"]},
        "data": null,
      };
    }

    return responseBody;
  }

  Future<Map<String, dynamic>> summarizeChatCompletion(
    Map<String, dynamic> prompt,
  ) async {
    Map<String, dynamic> responseBody;
    String requestBody = requestParser.getMessageReqBody(prompts: [prompt]);

    try {
      responseBody = await services.getPostApiResponse(
        ApiUrls.chatCompletionOpenAIUrl,
        requestBody,
        addAccessToken: false,
        contentTypeJson: true,
        token: ApiKeys.openAiKey,
      );
    } catch (e) {
      responseBody = {
        "error": {"message": e.toString()},
        "data": null,
      };
    }

    if (responseBody.containsKey("timeout")) {
      responseBody = {
        "error": {"message": responseBody["message"]},
        "data": null,
      };
    }

    return responseBody;
  }
}
