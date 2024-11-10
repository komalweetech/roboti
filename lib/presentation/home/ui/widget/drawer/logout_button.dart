import 'package:flutter/material.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/theme/text_styling.dart';
import 'package:roboti_app/utils/extensions/sized_box.dart';

class LogoutButton extends StatelessWidget {
  final EdgeInsets padding;
  const LogoutButton({
    super.key,
    required this.color,
    required this.leading,
    required this.text,
    required this.onTap,
    required this.padding,
  });

  final Widget leading;
  final String text;
  final Color color;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        padding: MaterialStatePropertyAll(padding),
        backgroundColor:
            const MaterialStatePropertyAll(MyColors.primaryDarkBlue060A19),
      ),
      onPressed: onTap,
      child: Row(
        children: [
          leading,
          8.hSpace(context),
          Text(
            text,
            style: myTextStyle.font_16wRegular.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
