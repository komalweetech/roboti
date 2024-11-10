import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roboti_app/presentation/news/model/news_model.dart';
import 'package:roboti_app/presentation/news/view_model/bloc/news_bloc.dart';
import 'package:roboti_app/presentation/news/view_model/bloc/news_event.dart';
import 'package:roboti_app/presentation/news/view_model/bloc/news_state.dart';
import 'package:roboti_app/presentation/news/view_model/repo/news_repo.dart';

class NewsHanlder {
  final NewsRepo _repo = NewsRepo();
  FutureOr<void> newsHandler(
    NewsEvent event,
    Emitter<NewsState> emit,
  ) async {
    if (event is FetchRobotiNewsEvent) {
      await _fetchRobotiNewsEvent(event, emit);
    } else if (event is FetchGlobalNewsEvent) {
      await _fetchGlobalNewsEvent(event, emit);
    } else if (event is ResetNewsDataEvent) {
      newsBloc.globalNewsList.clear();
      newsBloc.robotiNewsList.clear();
    } else if (event is GetPaginatedGlobalNewsEvent) {
      await _fetchPaginatedGlobalNewsEvent(event, emit);
    }
  }

  Future<void> _fetchRobotiNewsEvent(
    FetchRobotiNewsEvent event,
    Emitter<NewsState> emit,
  ) async {
    if (newsBloc.robotiNewsList.isEmpty) {
      newsBloc.robotiNewsList.clear();
      emit(RobotiNewsDataLoadedLoadingState());

      List<NewsModel>? response = await _repo.getAllRobotiNews();
      if (response == null) {
        return emit(RobotiNewsDataLoadedErrorState());
      }

      newsBloc.robotiNewsList = response;
      emit(RobotiNewsDataLoadedSuccessState());
    }
  }

  Future<void> _fetchGlobalNewsEvent(
    FetchGlobalNewsEvent event,
    Emitter<NewsState> emit,
  ) async {
    if (newsBloc.globalNewsList.isEmpty) {
      newsBloc.globalNewsList.clear();
      emit(GlobalNewsDataLoadedLoadingState());

      List<NewsModel>? response = await _repo.getAllGlobalNews(10);
      if (response == null) {
        return emit(GlobalNewsDataLoadedErrorState());
      }

      newsBloc.globalNewsList = response;

      emit(GlobalNewsDataLoadedSuccessState());
    }
  }

  Future<void> _fetchPaginatedGlobalNewsEvent(
    GetPaginatedGlobalNewsEvent event,
    Emitter<NewsState> emit,
  ) async {
    int limit = newsBloc.globalNewsList.length + 10;

    // Pagination Implemented

    emit(GetAllGNewsPaginationLoadingState());

    List<NewsModel>? response = await _repo.getAllGlobalNews(limit);
    if (response == null) {
      return emit(GlobalNewsDataLoadedErrorState());
    }

    newsBloc.globalNewsList = response;

    emit(GlobalNewsDataLoadedSuccessState());
  }
}
