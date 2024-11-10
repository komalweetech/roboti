import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/common/widget/my_loader/custom_cupertino_loader.dart';
import 'package:roboti_app/common/widget/no_data_widget.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/base_state.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/home_bloc.dart';
import 'package:roboti_app/presentation/news/ui/screens/news_details_screen.dart';
import 'package:roboti_app/presentation/news/ui/widgets/new_tile.dart';
import 'package:roboti_app/presentation/news/ui/widgets/news_data_widget.dart';
import 'package:roboti_app/presentation/news/view_model/bloc/news_bloc.dart';
import 'package:roboti_app/presentation/news/view_model/bloc/news_event.dart';
import 'package:roboti_app/presentation/news/view_model/bloc/news_state.dart';
import 'package:roboti_app/utils/extensions/route_extension.dart';

class RobotiNewsScreen extends StatefulWidget {
  const RobotiNewsScreen({super.key});

  @override
  State<RobotiNewsScreen> createState() => _RobotiNewsScreenState();
}

class _RobotiNewsScreenState extends State<RobotiNewsScreen> {
  @override
  void initState() {
    newsBloc.add(FetchRobotiNewsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, homeState) => BlocBuilder<NewsBloc, NewsState>(
        bloc: newsBloc,
        builder: (context, state) {
          // if (state is! GlobalNewsState) {
          if (newsBloc.robotiNewsList.isNotEmpty) {
            return NewsDataWidget(
              news: newsBloc.robotiNewsList,
              onTap: (news) => context.pushRoute(
                NewsDetailsScreen(fromGlobal: false, news: news),
              ),
              fromGlobal: false,
              state: state,
            );
          } else if (state is RobotiNewsDataLoadedSuccessState) {
            if (newsBloc.robotiNewsList.isEmpty) {
              return NoDataWidget(text: lc(context).noRobotiNewsFound);
            }
            return RefreshIndicator(
              onRefresh: () async {
                // print("I am printing");
                // Add your refresh logic here
              },
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: true,
                    child: ListView.builder(
                      itemCount: 0, // newsBloc.robotiNewsList.length,
                      physics:
                          const NeverScrollableScrollPhysics(), // Disable ListView scrolling
                      padding: const EdgeInsets.only(
                          top: 9), // Adjust padding as needed
                      itemBuilder: (context, index) => NewsTile(
                        news: newsBloc.robotiNewsList[index],
                        onTap: () => context.pushRoute(
                          NewsDetailsScreen(
                            fromGlobal: false,
                            news: newsBloc.robotiNewsList[index],
                          ),
                        ),
                        fromGlobal: false,
                      ),
                    ),
                  ),
                ],
              ),
            );

            // return RefreshIndicator(
            //   onRefresh: () async {
            //     print("I am printign");
            //   },
            //   child: ConstrainedBox(
            //     constraints: BoxConstraints(
            //       minHeight: MediaQuery.of(context).size.height,
            //     ),
            //     child: SingleChildScrollView(
            //       physics: const AlwaysScrollableScrollPhysics(),
            //       child: ListView.builder(
            //         itemCount: newsBloc.robotiNewsList.length,
            //         physics: const BouncingScrollPhysics(),
            //         padding: 9.paddingTop(context),
            //         itemBuilder: (context, index) => NewsTile(
            //           news: newsBloc.robotiNewsList[index],
            //           onTap: () => context.pushRoute(
            //             NewsDetailsScreen(
            //                 fromGlobal: false,
            //                 news: newsBloc.robotiNewsList[index]),
            //           ),
            //           fromGlobal: false,
            //         ),
            //       ),

            //       //  NewsDataWidget(
            //       //   news: newsBloc.robotiNewsList,
            //       //   onTap: (news) => context.pushRoute(
            //       //     NewsDetailsScreen(fromGlobal: false, news: news),
            //       //   ),
            //       //   fromGlobal: false,
            //       // ),
            //     ),
            //   ),
            // );
          } else if (state is RobotiNewsDataLoadedLoadingState) {
            return CustomCupertinoLoader.showLoaderWidget();
            // } else if (newsBloc.robotiNewsList.isEmpty) {
          } else {
            return NoDataWidget(text: lc(context).noRobotiNewsFound);
          }
          // }
        },
      ),
    );
  }
}
