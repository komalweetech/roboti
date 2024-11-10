import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/common/widget/my_loader/custom_cupertino_loader.dart';
import 'package:roboti_app/common/widget/no_data_widget.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/base_state.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/home_bloc.dart';
import 'package:roboti_app/presentation/news/ui/screens/news_details_screen.dart';
import 'package:roboti_app/presentation/news/ui/widgets/news_data_widget.dart';
import 'package:roboti_app/presentation/news/view_model/bloc/news_bloc.dart';
import 'package:roboti_app/presentation/news/view_model/bloc/news_event.dart';
import 'package:roboti_app/presentation/news/view_model/bloc/news_state.dart';
import 'package:roboti_app/utils/extensions/route_extension.dart';

class GlobalNewsScreen extends StatefulWidget {
  const GlobalNewsScreen({super.key});

  @override
  State<GlobalNewsScreen> createState() => _GlobalNewsScreenState();
}

class _GlobalNewsScreenState extends State<GlobalNewsScreen> {
  @override
  void initState() {
    newsBloc.add(FetchGlobalNewsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) => BlocBuilder<NewsBloc, NewsState>(
        bloc: newsBloc,
        builder: (context, state) {
          if (newsBloc.globalNewsList.isNotEmpty) {
            return RefreshIndicator(
              onRefresh: () async {
                // print("I am printign");
              },
              displacement: 0.00,
              child: NewsDataWidget(
                news: newsBloc.globalNewsList,
                onTap: (news) => context.pushRoute(
                  NewsDetailsScreen(fromGlobal: true, news: news),
                ),
                fromGlobal: true,
                state: state,
              ),
            );
          } else if (state is GlobalNewsDataLoadedLoadingState) {
            return CustomCupertinoLoader.showLoaderWidget(center: false);
          } else if (state is GlobalNewsDataLoadedSuccessState) {
            if (newsBloc.globalNewsList.isEmpty) {
              return NoDataWidget(text: lc(context).noGlobalNewsFound);
            } else {
              return NewsDataWidget(
                news: newsBloc.globalNewsList,
                onTap: (news) => context.pushRoute(
                  NewsDetailsScreen(fromGlobal: true, news: news),
                ),
                fromGlobal: true,
                state: state,
              );
            }
          } else {
            return NoDataWidget(text: lc(context).noGlobalNewsFound);
          }
        },
      ),
    );
  }
}
