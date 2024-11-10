import 'package:flutter/material.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';

extension Space on num {
  SizedBox vSpace(BuildContext context) {
    return SizedBox(
      height: pxV(context),
    );
  }

  SizedBox hSpace(BuildContext context) {
    return SizedBox(
      width: pxH(context),
    );
  }
}
