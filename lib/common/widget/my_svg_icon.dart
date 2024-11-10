import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgIconCustom extends StatelessWidget {
  final String? svgIcon;
  final Color? iconColor;
  final double? iconSize;
  final String? tooltipHint;
  final BoxFit svgBoxFit;
  final bool isNetwork;

  const SvgIconCustom({
    Key? key,
    this.svgIcon,
    this.iconColor,
    this.iconSize,
    this.tooltipHint,
    this.svgBoxFit = BoxFit.contain,
    this.isNetwork = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isNetwork
        ? SvgPicture.network(
            svgIcon ?? '',
            color: iconColor,
            fit: svgBoxFit,
            width: iconSize,
            height: iconSize,
          )
        : SvgPicture.asset(
            svgIcon ?? '',
            color: iconColor,
            width: iconSize,
            height: iconSize,
            fit: svgBoxFit,
          );
  }
}
