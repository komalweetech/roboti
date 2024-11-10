import 'package:flutter/material.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/presentation/news/ui/screens/global_news_screen.dart';
import 'package:roboti_app/presentation/news/ui/screens/roboti_news_screen.dart';
import 'package:roboti_app/presentation/news/view_model/bloc/news_bloc.dart';
import 'package:roboti_app/presentation/news/view_model/bloc/news_event.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/theme/text_styling.dart';

class NewsBaseScreen extends StatefulWidget {
  static const String route = "news_screen.dart";
  const NewsBaseScreen({super.key});

  @override
  State<NewsBaseScreen> createState() => _NewsBaseScreenState();
}

class _NewsBaseScreenState extends State<NewsBaseScreen>
    with SingleTickerProviderStateMixin {
  TabController? controller;

  @override
  void initState() {
    controller = TabController(length: 2, vsync: this);
    newsBloc.add(ResetNewsDataEvent());
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  // DLRoute? route;

  // void dlRouting() {
  //   DLServices.getDLRoute().then((r) {
  //     if (r != null) {
  //       route = r;
  //       if (r == DLRoute.robotiNews) {
  //         controller!.index = 1;
  //       } else if (r == DLRoute.globalNews) {
  //         controller!.index = 0;
  //       }

  //       // print(controller!.index);
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // dlRouting();
    return Scaffold(
      appBar: TabBar(
        controller: controller!,
        labelStyle: myTextStyle.font_16wRegular,
        unselectedLabelColor: MyColors.whiteFFFFFF,
        labelColor: MyColors.limeGreen67FF66,
        indicatorColor: MyColors.limeGreen67FF66,
        indicatorWeight: 1,
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: MyColors.black0D0D0D,
        tabs: [
          Tab(text: lc(context).globalNews),
          Tab(text: lc(context).robotiNews)
        ],
      ),
      body: TabBarView(
        controller: controller,
        children: const [GlobalNewsScreen(), RobotiNewsScreen()],
      ),
    );
  }
}
