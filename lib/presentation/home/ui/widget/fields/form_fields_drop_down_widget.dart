import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:roboti_app/app/app_view.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/presentation/home/model/field_model.dart';
import 'package:roboti_app/presentation/home/model/field_options.dart';
import 'package:roboti_app/presentation/home/ui/widget/fields/form_field_option_widget.dart';
import 'package:roboti_app/presentation/home/ui/widget/fields/required_text_widget.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/base_event.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/base_state.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/home_bloc.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/theme/my_icons.dart';
import 'package:roboti_app/theme/text_styling.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';
import 'package:roboti_app/utils/extensions/padding.dart';
import 'package:roboti_app/utils/extensions/sized_box.dart';
import 'package:roboti_app/utils/extensions/string_extendsions.dart';
import 'package:roboti_app/utils/extensions/text_styles.dart';

class FormFieldDropdownWidget extends StatefulWidget {
  final FieldModel field;
  final int animationDurationMs;
  final Curve curve;
  final double optionsHeight, titleHeight;
  final int count;
  final HomeState state;
  const FormFieldDropdownWidget({
    super.key,
    required this.field,
    required this.count,
    this.animationDurationMs = 200,
    this.titleHeight = 76,
    this.curve = Curves.fastEaseInToSlowEaseOut,
    this.optionsHeight = 54,
    required this.state,
  });

  @override
  State<FormFieldDropdownWidget> createState() =>
      _FormFieldDropdownWidgetState();
}

class _FormFieldDropdownWidgetState extends State<FormFieldDropdownWidget> {
  bool isExpanded = false;
  // bool isTapped = false;

  void expandDropDown() {
    primaryFocus!.unfocus();
    isExpanded = !isExpanded;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if ((!widget.field.optional) &&
            displayBorder) //&& isTapped) || widget.notVolidated)
          const FieldRequiredTextWidget(),
        AnimatedContainer(
          duration: Duration(milliseconds: widget.animationDurationMs),
          curve: widget.curve,
          margin: 20.paddingH(context).copyWith(bottom: 16.pxV(context)),
          height: widget.titleHeight.pxV(context) + additionalHeight,
          width: 100.percentWidth(context),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.pxV(context)),
            color: MyColors.secondaryBlue141F48,
            border: displayBorder
                ? Border.all(color: MyColors.red.withOpacity(0.8))
                : null,
          ),
          child: Column(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(12.pxV(context)),
                onTap: expandDropDown,
                child: Container(
                  height: 76.pxV(context),
                  width: 100.percentWidth(context),
                  alignment: Alignment.centerLeft,
                  padding:
                      20.paddingLeft(context).copyWith(right: 26.pxH(context)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          !homeBloc.selectedOptions!
                                  .containsKey(widget.field.id)
                              ? (placeHolder ?? lc(context).selectAnOption)
                                  .capitalizeFirst()
                              : (isEng
                                  ? homeBloc
                                      .selectedOptions![widget.field.id]!.text
                                  : homeBloc.selectedOptions![widget.field.id]!
                                      .arabicText),
                          style: myTextStyle.font_16wRegular.textColor(
                            !homeBloc.selectedOptions!
                                    .containsKey(widget.field.id)
                                ? MyColors.lightblue6B79AD
                                : MyColors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      8.hSpace(context),
                      AnimatedRotation(
                        turns: isExpanded ? 0.5 : 0,
                        duration:
                            Duration(milliseconds: widget.animationDurationMs),
                        curve: widget.curve,
                        child: SvgPicture.asset(
                          MyIcons.arrowDownIcon,
                          width: 10.81.pxV(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (isExpanded)
                Expanded(
                  child: BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) => ListView.builder(
                      itemCount: widget.count,
                      itemBuilder: (context, index) => OptionsTile(
                        height: widget.optionsHeight,
                        text: getOptionText(widget.field.options[index])
                            .capitalizeFirst(),
                        onTap: () {
                          // widget.field.textController!.text = (isEng
                          //         ? widget.field.options[index].text
                          //         : widget.field.options[index].arabicText)
                          // .capitalizeFirst();
                          homeBloc.selectedOptions![widget.field.id] =
                              widget.field.options[index];
                          homeBloc.add(
                            EditingFormFieldEvent(
                              validationErrorHasOccured:
                                  widget.state is FormFieldValidationErrorState,
                            ),
                          );

                          expandDropDown();
                        },
                      ),
                    ),
                  ),
                ),
            ],
          ),
        )
      ],
    );
  }

  double get additionalHeight => (isExpanded
      ? widget.optionsHeight * (widget.count > 5 ? 5 : widget.count) + 8
      : displayBorder
          ? 2
          : 0);

  bool get displayRequired => widget.state is FormFieldValidationErrorState;

  bool get displayBorder =>
      ((/*isTapped ||*/ widget.state is FormFieldValidationErrorState) &&
          !widget.field.optional &&
          (!homeBloc.selectedOptions!.containsKey(widget.field.id)));

  String getOptionText(FieldOption option) =>
      isEng ? option.text : option.arabicText;

  String? get placeHolder =>
      isEng ? widget.field.placeHolder : widget.field.translatedPlaceHolder;
}
