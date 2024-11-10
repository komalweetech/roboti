import 'package:flutter/material.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';

class SocialLoginButton extends StatelessWidget {
  final Function() onTap;
  final Widget icon;
  final double percentWidth;
  const SocialLoginButton({
    super.key,
    required this.onTap,
    required this.icon,
    this.percentWidth = 42.55,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: percentWidth.percentWidth(context),
        padding: const EdgeInsets.all(20),
        height: 8.128.percentHeight(context),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: MyColors.lightBlue0D142F,
        ),
        child: icon,
      ),
    );
  }
}
