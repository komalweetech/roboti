import 'package:flutter_svg/svg.dart';
import 'package:roboti_app/theme/my_icons.dart';
import 'package:flutter/material.dart';

class MyDrawerIcon extends StatelessWidget {
  final Function() onTap;
  const MyDrawerIcon({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SvgPicture.asset(MyIcons.drawerIcon, width: 38),
    );
  }
}
