import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/service/di.dart';
import 'package:roboti_app/theme/text_styling.dart';

class VersionWidget extends StatelessWidget {
  final EdgeInsets padding;
  const VersionWidget({
    super.key,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            lc(context).robotiAppVersion,
            style: myTextStyle.font_16wRegular,
          ),
          Text(
            getIt<PackageInfo>().version, //"V 1.2.8",
            style: myTextStyle.font_16wRegular,
          ),
        ],
      ),
    );
  }
}
