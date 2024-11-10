import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roboti_app/presentation/news/model/news_model.dart';
import 'package:roboti_app/presentation/news/view_model/bloc/news_event.dart';
import 'package:roboti_app/presentation/news/view_model/bloc/news_handler.dart';
import 'package:roboti_app/presentation/news/view_model/bloc/news_state.dart';

NewsBloc newsBloc = NewsBloc(
  globalNewsList: [],
  robotiNewsList: [],
);

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  List<NewsModel> robotiNewsList;
  List<NewsModel> globalNewsList;
  NewsBloc({
    required this.globalNewsList,
    required this.robotiNewsList,
  }) : super(NewsInitialState()) {
    on<NewsEvent>(NewsHanlder().newsHandler);
  }
}
