import 'package:flutter/material.dart';
import 'package:roboti_app/app/app_view.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/common/widget/text_view.dart';
import 'package:roboti_app/presentation/history/model/history_model.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/theme/text_styling.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';
import 'package:roboti_app/utils/extensions/padding.dart';
import 'package:roboti_app/utils/extensions/sized_box.dart';
import 'package:roboti_app/utils/extensions/string_extendsions.dart';
import 'package:roboti_app/utils/extensions/text_styles.dart';

class HistoryWidget extends StatelessWidget {
  final HistoryModel history;
  final Function(HistoryModel) onTap;
  final double borderRadius;
  final double topMargin;
  final double bottomMargin;
  const HistoryWidget({
    super.key,
    required this.history,
    required this.onTap,
    required this.topMargin,
    required this.bottomMargin,
    this.borderRadius = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 20.paddingH(context).copyWith(
            bottom: bottomMargin.pxV(context),
            top: topMargin.pxV(context),
          ),
      // padding: ,
      child: InkWell(
        onTap: () => onTap(history),
        borderRadius: BorderRadius.circular(borderRadius.pxH(context)),
        child: Container(
          padding: 10.paddingAll(context).copyWith(right: 15.pxH(context)),
          width: 100.percentWidth(context),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius.pxH(context)),
            color: MyColors.secondaryBlue141F48,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              categoryAndTaskRow(context),
              15.vSpace(context),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextView(
                    title().capitalizeFirst(),
                    width: 70.percentWidth(context),
                    maxLine: 2,
                    overflow: TextOverflow.ellipsis,
                    style: myTextStyle.font_16wRegular,
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: MyColors.whiteFFFFFF,
                    size: 16.pxV(context),
                  ),
                ],
              ),
              18.vSpace(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget categoryAndTaskRow(BuildContext context) => SizedBox(
        width: 100.percentWidth(context),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.only(
                left: 11.pxH(context),
                right: 16.pxH(context),
              ),
              decoration: BoxDecoration(
                color: MyColors.softPinkFD6AF5,
                borderRadius: BorderRadius.circular(3),
              ),
              child: TextView(
                (isEng
                    ? history.completionHistory!.catName
                    : history.completionHistory!.catTranslatedName),
                style: myTextStyle.font_14w500,
              ),
            ),
            16.hSpace(context),
            TextView(
              "${lc(context).task}: ", // "Task: ",
              style: myTextStyle.font_12w500.textColor(MyColors.softPinkFD6AF5),
            ),
            Expanded(
              child: TextView(
                (isEng
                    ? history.completionHistory!.taskName
                    : history.completionHistory!.taskTranslatedName),
                style: myTextStyle.font_12w500,
                maxLine: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
  String title() => history.completionHistory!.firstGPTResponseModel.isEng
      ? history.completionHistory!.firstGPTResponseModel.content
      : history.completionHistory!.firstGPTResponseModel.translation;
  // String title() => isEng
  //     ? history.completionHistory!.firstGPTResponseModel.content
  //     : history.completionHistory!.firstGPTResponseModel.translation.isEmpty
  //         ? history.completionHistory!.firstGPTResponseModel.content
  //         : history.completionHistory!.firstGPTResponseModel.translation;
  // String title() {
  //   final response = history.completionHistory!.firstGPTResponseModel;
  //   // if (isEng) {
  //   // English
  //   return response.content;
  // } else {
  // Arabic
  // if (widget.prompt.isTranslated) {
  //   if (widget.prompt.translatedContent.isNotEmpty) {
  //     return widget.prompt.translatedContent;
  //   }
  //   return widget.prompt.content;
  // } else {
  //   if (widget.prompt.content.isEmpty) {
  //     return widget.prompt.translatedContent;
  //   }
  //   return widget.prompt.content;
  // }
  // }
  // }
}
