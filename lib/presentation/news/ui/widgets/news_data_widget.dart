import 'package:flutter/material.dart';
import 'package:roboti_app/common/widget/my_loader/custom_cupertino_loader.dart';
import 'package:roboti_app/presentation/news/model/news_model.dart';
import 'package:roboti_app/presentation/news/ui/widgets/new_tile.dart';
import 'package:roboti_app/presentation/news/view_model/bloc/news_bloc.dart';
import 'package:roboti_app/presentation/news/view_model/bloc/news_event.dart';
import 'package:roboti_app/presentation/news/view_model/bloc/news_state.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';
import 'package:roboti_app/utils/extensions/padding.dart';

class NewsDataWidget extends StatefulWidget {
  final List<NewsModel> news;
  final Function(NewsModel) onTap;
  final bool fromGlobal;
  final NewsState state;
  const NewsDataWidget({
    super.key,
    required this.news,
    required this.onTap,
    required this.fromGlobal,
    required this.state,
  });

  @override
  State<NewsDataWidget> createState() => _NewsDataWidgetState();
}

class _NewsDataWidgetState extends State<NewsDataWidget> {
  ScrollController scrollController = ScrollController();

  void _onScroll() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      newsBloc.add(GetPaginatedGlobalNewsEvent());
      // scrollController.jumpTo(scrollController.position.maxScrollExtent + 64);
    }
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.news.length + 1,
      controller: scrollController,
      physics: const BouncingScrollPhysics(),
      padding: 9.paddingTop(context),
      itemBuilder: (context, index) {
        if (index == widget.news.length) {
          return SizedBox(
            height: 10.percentHeight(context),
            child: pagination ? CustomCupertinoLoader.showLoaderWidget() : null,
          );
        }
        return NewsTile(
          news: widget.news[index],
          onTap: () => widget.onTap(widget.news[index]),
          fromGlobal: widget.fromGlobal,
        );
      },
    );
  }

  bool get pagination => (widget.state is GetAllGNewsPaginationLoadingState);
}
