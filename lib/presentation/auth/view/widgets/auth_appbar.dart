import 'package:flutter/material.dart';
import 'package:roboti_app/presentation/home/ui/widget/home/localization_button.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/theme/my_icons.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';
import 'package:roboti_app/utils/extensions/padding.dart';
import 'package:roboti_app/utils/extensions/route_extension.dart';

class AuthAppbar extends StatelessWidget {
  const AuthAppbar({super.key, this.isLogin = false});
  final bool? isLogin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 20.paddingH(context).copyWith(
            bottom: 27.pxV(context),
            top: 10,
          ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (!isLogin!)
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                context.pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: MyColors.white,
              ),
            ),
          Image.asset(
            MyIcons.robotiIconPNG,
            width: 108.pxH(context),
          ),
          const LocalizationButton(showName: true, height: 31),
        ],
      ),
    );
  }
}
