import 'package:roboti_app/theme/my_icons.dart';
import 'package:flutter/material.dart';

class MyLogoWidget extends StatelessWidget {
  const MyLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 108,
      child: Image.asset(MyIcons.robotiIconPNG),
    );
  }
}
