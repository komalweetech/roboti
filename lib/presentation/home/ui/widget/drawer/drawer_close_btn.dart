// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';

class DrawerCloseButton extends StatelessWidget {
  final Function() onTap;
  final Color? iconColor;
  final double size;
  final double? iconSize;
  const DrawerCloseButton({
    super.key,
    required this.onTap,
    this.iconColor,
    this.size = 32,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.pxH(context),
        height: size.pxV(context),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: MyColors.gradient4B3EE1To2575FCTopToBottom,
        ),
        child: Icon(
          Icons.clear,
          color: iconColor,
          size: iconSize,
        ),
      ),
    );
  }
}
