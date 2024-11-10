import 'package:flutter/material.dart';
import 'package:roboti_app/common/widget/appbar/my_appbar.dart';
import 'package:roboti_app/presentation/home/ui/widget/home/localization_button.dart';
import 'package:roboti_app/presentation/home/ui/widget/home/my_logo_widget.dart';
import 'package:roboti_app/presentation/home/ui/widget/task/back_button.dart';

class RobotiLogoAppbar extends StatelessWidget implements PreferredSize {
  const RobotiLogoAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return const MyAppBar(
      leadingWidget: MyBackButton(),
      title: MyLogoWidget(),
      actionWidgets: [LocalizationButton()],
    );
  }

  @override
  Widget get child => const SizedBox();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
