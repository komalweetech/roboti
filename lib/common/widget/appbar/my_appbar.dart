import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roboti_app/app/app_view.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/base_state.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/home_bloc.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';
import 'package:roboti_app/utils/extensions/padding.dart';
import 'package:roboti_app/utils/extensions/sized_box.dart';

class MyAppBar extends StatelessWidget implements PreferredSize {
  final Color bgColor;
  final Widget title;
  final Widget? leadingWidget;
  final double leadingWidth;
  final double leadingWidgetLeftMargin, actionsRightMargin;
  final List<Widget>? actionWidgets;
  final double height;
  const MyAppBar({
    super.key,
    this.bgColor = MyColors.primaryDarkBlue060A19,
    required this.title,
    this.leadingWidget,
    this.leadingWidgetLeftMargin = 16,
    this.actionsRightMargin = 16,
    this.leadingWidth = 42,
    this.actionWidgets,
    this.height = 42,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) => AppBar(
        title: title,
        centerTitle: true,
        backgroundColor: bgColor,
        shadowColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        flexibleSpace: Container(color: bgColor),
        elevation: 0,
        automaticallyImplyLeading: false,
        leadingWidth: (leadingWidth + leadingWidgetLeftMargin).pxH(context),
        toolbarHeight: height.pxH(context),
        leading: Padding(
          padding: isEng
              ? leadingWidgetLeftMargin.paddingLeft(context)
              : leadingWidgetLeftMargin.paddingRight(context),
          child: leadingWidget,
        ),
        actions: actionWidgets == null
            ? null
            : [...actionWidgets!, actionsRightMargin.hSpace(context)],
      ),
    );
  }

  @override
  Widget get child => const SizedBox();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
