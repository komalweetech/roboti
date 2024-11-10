import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roboti_app/app/app_view.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/base_state.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/home_bloc.dart';
import 'package:roboti_app/theme/my_icons.dart';
import 'package:roboti_app/utils/extensions/route_extension.dart';

class MyBackButton extends StatelessWidget {
  final Function()? onTap;
  const MyBackButton({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) => InkWell(
        onTap: () => onTap == null ? context.pop() : onTap!(),
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        child: Transform.rotate(
          angle: isEng ? 0 : pi,
          child: SvgPicture.asset(MyIcons.bacKArrowIcon),
        ),
      ),
    );
  }
}
