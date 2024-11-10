// ignore_for_file: use_build_context_synchronously

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roboti_app/app/app_view.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/common/widget/text_view.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/base_event.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/base_state.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/home_bloc.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/theme/my_icons.dart';
import 'package:flutter/material.dart';
import 'package:roboti_app/utils/extensions/padding.dart';
import 'package:roboti_app/utils/extensions/text_styles.dart';

class LocalizationButton extends StatefulWidget {
  final double borderRadius;
  final bool showName;
  final double? height;
  const LocalizationButton({
    super.key,
    this.borderRadius = 10,
    this.showName = false,
    this.height,
  });

  @override
  State<LocalizationButton> createState() => _LocalizationButtonState();
}

class _LocalizationButtonState extends State<LocalizationButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Container(
          height: widget.height,
          // padding: 16.paddingAll(context),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            color: MyColors.secondaryBlue141F48,
          ),
          child: DropdownButton(
            value: homeBloc.selectedLocale.name,
            items: [
              DropdownMenuItem(
                value: AppLocale.en.name,
                child: SizedBox(
                  height: 35,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        MyIcons.englandFlag,
                        width: widget.showName ? 15 : 23,
                      ),
                      if (widget.showName)
                        TextView(
                          lc(context).english,
                          padding: 7.paddingH(context),
                          style: 12.txt(context).textColor(Colors.white),
                        ),
                    ],
                  ),
                ),
              ),
              DropdownMenuItem(
                value: AppLocale.ar.name,
                child: SizedBox(
                  height: 35,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        MyIcons.uaeFlag,
                        width: widget.showName ? 15 : 20,
                      ),
                      if (widget.showName)
                        TextView(
                          lc(context).arabic,
                          padding: 7.paddingH(context),
                          style: 12.txt(context).textColor(Colors.white),
                        ),
                    ],
                  ),
                ),
              ),
            ],
            dropdownColor: MyColors.secondaryBlue141F48,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            padding: 8.paddingH(context),
            // padding: widget.showName
            //     ? 8.paddingH(context).copyWith(
            //           top: 12.pxV(context),
            //           bottom: 12.pxV(context),
            //         )
            //     : 16.paddingAll(context),
            icon: Padding(
              padding: isEng
                  ? (widget.showName ? 5 : 8.5).paddingLeft(context)
                  : (widget.showName ? 5 : 8.5).paddingRight(context),
              child: SvgPicture.asset(MyIcons.arrowDownIcon),
            ),
            underline: const SizedBox(),
            onChanged: (val) async {
              homeBloc.add(ChangeLanguageEvent(val: val!, context: context));
            },
          ),
        );
      },
    );
  }
}

enum AppLocale { en, ar }
