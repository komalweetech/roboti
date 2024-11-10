import 'package:flutter/material.dart';
import 'package:roboti_app/common/widget/text_view.dart';
import 'package:roboti_app/presentation/home/model/task_model.dart';
import 'package:roboti_app/presentation/home/ui/widget/home/category_image_widget.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/base_event.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/home_bloc.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/theme/text_styling.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';
import 'package:roboti_app/utils/extensions/padding.dart';
import 'package:roboti_app/utils/extensions/sized_box.dart';

class TaskTile extends StatelessWidget {
  final TaskModel task;
  final bool fromEng;
  const TaskTile({
    super.key,
    required this.task,
    required this.fromEng,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.percentWidth(context),
      margin: 20.paddingH(context).copyWith(bottom: 8.pxV(context)),
      decoration: BoxDecoration(
        color: MyColors.secondaryBlue141F48,
        borderRadius: BorderRadius.circular(16.pxH(context)),
      ),
      child: InkWell(
        onTap: () =>
            homeBloc.add(SelectTaskEvent(context: context, task: task)),
        borderRadius: BorderRadius.circular(16.pxH(context)),
        child: Padding(
          padding: 35.1.paddingH(context).copyWith(top: 18, bottom: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 33.47.pxH(context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CategoryImageWidget(
                      url: homeBloc.selectedCategory!.imageUrl,
                      name: homeBloc.selectedCategory!.title.isNotEmpty
                          ? homeBloc.selectedCategory!.title[0]
                          : "",
                    ),
                    // Container(
                    //   height: 33.47.pxH(context),
                    //   width: 33.47.pxH(context),
                    //   color: MyColors.lightblue6B79AD,
                    // ),
                  ],
                ),
              ),
              17.4.hSpace(context),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                      fromEng ? task.title : task.translatedTitle,
                      style: myTextStyle.font_20wMedium.copyWith(height: 1),
                    ),
                    3.vSpace(context),
                    Text(
                      fromEng ? task.description : task.translatedDescription,
                      style: myTextStyle.font_14w400.copyWith(
                        color: MyColors.lightblue6B79AD,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
