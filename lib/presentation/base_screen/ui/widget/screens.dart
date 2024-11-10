import 'package:flutter/material.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/common/widget/text_view.dart';
import 'package:roboti_app/presentation/history/ui/screen/history_screen.dart';
import 'package:roboti_app/presentation/home/ui/screen/home_categpry_screen.dart';
import 'package:roboti_app/presentation/news/ui/screens/news_base_screen.dart';
import 'package:roboti_app/utils/app_constants/app_context.dart';
import 'package:roboti_app/utils/extensions/text_styles.dart';

class Screens {
  static List<Widget> getScreens(BuildContext context) => [
        const HomeCategoryScreen(),
        // Center(
        //   child: TextView(lc(context).tools,
        //       style: 24.txt(context).textColor(Colors.white)),
        // ),
        Center(
          child: TextView(lc(context).ask,
              style: 24.txt(context).textColor(Colors.white)),
        ),
        const HistoryScreen(),
        const NewsBaseScreen(),
        // Center(
        //   child: TextView(lc(context).news,
        //       style: 24.txt(context).textColor(Colors.white)),
        // ),
      ];

  static Widget getCurrentScreen(int index) =>
      getScreens(GlobalContext.currentContext!)[index];
}
