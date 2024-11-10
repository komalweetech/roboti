import 'package:flutter/material.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/common/widget/text_view.dart';
import 'package:roboti_app/presentation/history/model/history_model.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/theme/text_styling.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';
import 'package:roboti_app/utils/extensions/padding.dart';
import 'package:roboti_app/utils/extensions/sized_box.dart';

class ChatHistoryWidget extends StatelessWidget {
  final HistoryModel history;
  final Function(HistoryModel) onTap;
  final double borderRadius;
  final double topMargin;
  final double bottomMargin;
  const ChatHistoryWidget({
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category and task row
                  tagWidget(context),
                  // Title

                  15.vSpace(context),

                  TextView(
                    title(),
                    width: 67.67.percentWidth(context),
                    maxLine: 2,
                    overflow: TextOverflow.ellipsis,
                    style: myTextStyle.font_16wRegular,
                  ),

                  18.vSpace(context),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: MyColors.whiteFFFFFF,
                size: 16.pxV(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget tagWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 11.pxH(context),
        right: 16.pxH(context),
      ),
      decoration: BoxDecoration(
        color: MyColors.green67FF66,
        borderRadius: BorderRadius.circular(3),
      ),
      child: TextView(
        lc(context).ask,
        style: myTextStyle.font_14w500Black,
      ),
    );
  }

  String title() {
    // String title = "";

    // for (var chat in history.chatHistory!.chatList) {
    // title += "${chat.message} ";
    // }
    // return title.capitalizeFirst();

    return history.chatHistory!.chatList.first.message;
  }
}
