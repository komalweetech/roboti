import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:roboti_app/common/widget/text_view.dart';
import 'package:roboti_app/presentation/chat/model/chat_model.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/theme/text_styling.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';
import 'package:roboti_app/utils/extensions/padding.dart';
import 'package:roboti_app/utils/extensions/sized_box.dart';

class ImageMsgWidget extends StatelessWidget {
  final ChatModel chat;
  final bool fromHistory;
  const ImageMsgWidget({
    super.key,
    required this.chat,
    required this.fromHistory,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 100.percentWidth(context),
          padding: 10.paddingH(context),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.pxV(context)),
            child: chat.imageUrl == null || !fromHistory
                ? Image.file(File(chat.message))
                : CachedNetworkImage(
                    imageUrl: chat.imageUrl!,
                    placeholder: (context, string) => Container(
                      height: 200,
                      color: MyColors.black0D0D0D,
                      child: const Center(
                        child: CupertinoActivityIndicator(
                          color: MyColors.black7B8598,
                        ),
                      ),
                    ),
                  ),
          ),
        ),
        12.vSpace(context),
        TextView(
          chat.animatedMessages,
          style: myTextStyle.font_16wRegular,
          padding: 15.paddingH(context),
        )
      ],
    );
  }
}
