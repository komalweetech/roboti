import 'package:roboti_app/presentation/news/model/news_model.dart';
import 'package:roboti_app/presentation/news/view_model/repo/request_parser.dart';
import 'package:roboti_app/service/remote/api_urls.dart';
import 'package:roboti_app/service/remote/network_api_services.dart';

class NewsRepo {
  final NetworkApiService _apiService = NetworkApiService();
  final NewsRequestParser _requestParser = NewsRequestParser();

  Future<List<NewsModel>?> getAllGlobalNews(int limit) async {
    Map<String, dynamic> data = await _apiService.getPostApiResponse(
      ApiUrls.globalNews,
      _requestParser.globalNewsRequest(limit: limit),
    );

    // if (!data.containsKey("data") ||
    //     data['data'] == null ||
    //     data['data']['response'] == null) {
    if (data['data']?['response'] == null) {
      return null;
    } else {
      List<NewsModel> newsData = [];
      for (Map<String, dynamic> news in data['data']['response']) {
        newsData.add(NewsModel.fromGlobalNews(news));
      }
      return newsData;
    }
  }

  Future<List<NewsModel>?> getAllRobotiNews() async {
    Map<String, dynamic> data = await _apiService.getPostApiResponse(
      ApiUrls.robotiNews,
      _requestParser.robotiNewsRequest(),
    );

    // if (!data.containsKey("data") ||
    //     data['data'] == null ||
    //     data['data']['response'] == null) {
    if (data['data']?['response'] == null) {
      return null;
    } else {
      List<NewsModel> newsData = [];
      for (Map<String, dynamic> news in data['data']['response']) {
        newsData.add(NewsModel.fromRobotiNews(news));
      }
      return newsData;
    }
  }
}
