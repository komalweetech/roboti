import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roboti_app/app/app_view.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/common/widget/no_data_widget.dart';
import 'package:roboti_app/common/widget/text_view.dart';
import 'package:roboti_app/presentation/home/ui/widget/task/task_tile.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/base_state.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/home_bloc.dart';
import 'package:roboti_app/theme/text_styling.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';
import 'package:roboti_app/utils/extensions/padding.dart';
import 'package:roboti_app/utils/extensions/sized_box.dart';

class CatergoryTaskScreen extends StatelessWidget {
  const CatergoryTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // 2.vSpace(context),
          TextView(
            isEng
                ? homeBloc.selectedCategory!.title
                : homeBloc.selectedCategory!.translatedTitle,
            style: myTextStyle.font_25wRegular,
            padding: 20.paddingH(context),
          ),
          homeBloc.tasks.isEmpty
              ? Expanded(
                  child: NoDataWidget(
                    text: lc(context).noTasks,
                    flex1: 2,
                    flex2: 3,
                    fontSize: 17,
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: homeBloc.tasks.length + 2,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return 36.vSpace(context);
                      } else if (index > homeBloc.tasks.length) {
                        return 10.percentHeight(context).vSpace(context);
                      }
                      return TaskTile(
                        task: homeBloc.tasks[index - 1],
                        fromEng: isEng,
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
