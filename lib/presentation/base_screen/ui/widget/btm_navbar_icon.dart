import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';
import 'package:roboti_app/utils/extensions/padding.dart';

class BtmNavbarIcon extends StatelessWidget {
  final String path;
  const BtmNavbarIcon({
    super.key,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 6.paddingBottom(context).copyWith(top: 12.pxV(context)),
      child: SvgPicture.asset(path),
    );
  }
}
