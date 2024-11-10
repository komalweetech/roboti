import 'package:flutter/material.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/common/widget/text_view.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/theme/text_styling.dart';
import 'package:roboti_app/utils/extensions/padding.dart';
import 'package:roboti_app/utils/extensions/text_styles.dart';

class FieldRequiredTextWidget extends StatelessWidget {
  const FieldRequiredTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextView(
      lc(context).required,
      style: myTextStyle.font_12w400.textColor(MyColors.red.withOpacity(0.8)),
      padding: 24.paddingH(context),
    );
  }
}
