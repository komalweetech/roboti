import 'package:flutter/material.dart';
import 'package:roboti_app/theme/my_icons.dart';

class NoChatWidget extends StatelessWidget {
  const NoChatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // return  Expanded(
    //   // height: 100.percentHeight(context),
    //   // width: 100.percentWidth(context),
    //   child: Column(
    //     children: [
    //       const Spacer(),
    return Expanded(
      child: Center(child: Image.asset(MyIcons.circledLogoIcon, width: 58)),
    );
    // const Spacer(flex: 2),
    //     ],
    //   ),
    // );
  }
}
