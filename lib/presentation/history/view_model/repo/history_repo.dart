import 'package:roboti_app/presentation/history/model/history_model.dart';
import 'package:roboti_app/presentation/history/view_model/bloc/history_bloc.dart';
import 'package:roboti_app/presentation/history/view_model/repo/request_parser.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/home_bloc.dart';
import 'package:roboti_app/service/remote/api_urls.dart';
import 'package:roboti_app/service/remote/network_api_services.dart';

class HistoryRepo {
  final NetworkApiService _apiService = NetworkApiService();
  final HistoryRequestParser _requestParser = HistoryRequestParser();

  Future<(List<HistoryModel>?, Map<String, List<HistoryModel>>)> getAllHistory(
      int limit) async {
    List<HistoryModel> history = [];
    Set<String> dates = {};
    Map<String, List<HistoryModel>> data = {};
    Map<String, dynamic> response = await _apiService.getPostApiResponse(
      ApiUrls.getAllHistory,
      _requestParser.getAllHistory(limit: limit),
    );

    try {
      for (Map<String, dynamic> ele in response['data']['response']) {
        HistoryModel record = HistoryModel.fromJson(ele);
        history.add(record);
        dates.add(record.createDate.toString());
      }
    } catch (e) {
      return (null, data);
    }

    return (history, data);
  }

  Future<HistoryModel?> getHistoryById({required String id}) async {
    HistoryModel? history;
    Map<String, dynamic> response =
        await _apiService.getGetApiResponse("${ApiUrls.getHistoryByID}/$id");

    try {
      history = HistoryModel.fromJson(response['data']['response'].last);
    } catch (e) {
      return null;
    }

    return history;
  }

  Future<void> createHistory() async {
    String reqBody = _requestParser.createHistoty(
      category: homeBloc.selectedCategory!,
      task: homeBloc.selectedTask!,
      form: homeBloc.form!,
      length: homeBloc.length,
      tone: homeBloc.tone,
      imageUrl: homeBloc.imageUrl ?? "",
    );
    Map<String, dynamic> data =
        await _apiService.getPostApiResponse(ApiUrls.createHistory, reqBody);

    // Storing id for further processing...
    try {
      historyBloc.historyId = data['data']['response']['_id'];
      historyBloc.selectedHistory =
          HistoryModel.fromJson(data['data']['response']);
    } catch (e) {
      historyBloc.historyId = "";
    }
  }

  Future<void> createChatHistory() async {
    historyBloc.historyId = "";
    String reqBody = _requestParser.createChatHistoty();
    Map<String, dynamic> response =
        await _apiService.getPostApiResponse(ApiUrls.createHistory, reqBody);

    historyBloc.selectedHistory =
        HistoryModel.fromJson(response['data']['response']);

    // Storing id for further processing...
    // try {
    //   historyBloc.historyId = data['data']['response']['_id'];
    // } catch (e) {
    // }
  }

  Future<void> updateHistory() async {
    String reqBody = _requestParser.updateHistory(form: homeBloc.form!);

    String url = "${ApiUrls.updateHistory}/${historyBloc.selectedHistory!.id}";

    Map<String, dynamic> response =
        await _apiService.getPatchApiResponse(url, reqBody);

    historyBloc.selectedHistory =
        HistoryModel.fromJson(response['data']['response']);

    // print(response);
  }

  Future<void> updateChatHistory() async {
    String reqBody = _requestParser.updateChatHistory();

    String url = "${ApiUrls.updateHistory}/${historyBloc.selectedHistory!.id}";

    Map<String, dynamic> response =
        await _apiService.getPatchApiResponse(url, reqBody);

    historyBloc.selectedHistory =
        HistoryModel.fromJson(response['data']['response']);

    // print(response);
  }
}
