import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/theme/my_icons.dart';
import 'package:roboti_app/utils/extensions/padding.dart';
import '../../../../common/widget/my_text_field.dart';

class PasswordInputField extends StatelessWidget {
  final bool obscure;
  final Function(bool) onObscureTap;
  final String hintText;
  final TextEditingController? controller;
  final Function(String) onFieldSubmitted;
  const PasswordInputField({
    super.key,
    required this.hintText,
    required this.obscure,
    required this.onObscureTap,
    this.controller,
    required this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return MyTextFormField(
      hintText: hintText,
      prefixIconPath: MyIcons.lockPassword,
      suffixIcon: InkWell(
        onTap: () => onObscureTap(obscure),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SvgPicture.asset(
            MyIcons.obscureEye,
            color: obscure ? MyColors.white : MyColors.black7B8598,
          ),
        ),
      ),
      onFieldSubmitted: onFieldSubmitted,
      margin: 20.paddingH(context),
      obscure: !obscure,
      bottomSpace: 16,
      controller: controller,
    );
  }
}
