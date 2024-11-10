import 'package:flutter/material.dart';
import 'package:roboti_app/app/app_view.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/common/widget/my_text_field.dart';
import 'package:roboti_app/presentation/home/model/field_model.dart';
import 'package:roboti_app/presentation/home/ui/widget/fields/required_text_widget.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/base_event.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/base_state.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/home_bloc.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';
import 'package:roboti_app/utils/extensions/padding.dart';
import 'package:roboti_app/utils/extensions/string_extendsions.dart';

class FormMultilinerInputField extends StatefulWidget {
  final FieldModel field;
  final HomeState state;
  const FormMultilinerInputField({
    super.key,
    required this.field,
    required this.state,
  });

  @override
  State<FormMultilinerInputField> createState() =>
      _FormMultilinerInputFieldState();
}

class _FormMultilinerInputFieldState extends State<FormMultilinerInputField> {
  // bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if ((!widget.field.optional) &&
            showBorder) //&& isTapped) || widget.notVolidated)
          const FieldRequiredTextWidget(),
        Container(
          margin: 20.paddingH(context).copyWith(bottom: 16.pxV(context)),
          decoration: BoxDecoration(
            border: showBorder
                ? Border.all(color: MyColors.red.withOpacity(0.8))
                : null,
            borderRadius: BorderRadius.circular(10),
          ),
          child: MyTextFormField(
            // margin: 20.paddingH(context),

            hintText: (placeHolder ?? lc(context).enterValue).capitalizeFirst(),
            textInputFormater: [],
            prefixIconPath: "",
            maxLines: 5,

            // bottomSpace: 16,
            // onTap: () {
            //   if (!isTapped) setState(() => isTapped = true);
            // },
            onChanged: (val) {
              setState(() {});
              homeBloc.add(EditingFormFieldEvent(
                validationErrorHasOccured:
                    widget.state is FormFieldValidationErrorState,
              ));
            },
            keyboardType: TextInputType.multiline,
            textCapitalization: TextCapitalization.sentences,
            onFieldSubmitted: (val) {},
            controller: widget.field.textController,
            textInputAction: null,
          ),
        ),
      ],
    );
  }

  bool get displayRequired => widget.state is FormFieldValidationErrorState;

  bool get showBorder =>
      ((/*isTapped ||*/ widget.state is FormFieldValidationErrorState) &&
          !widget.field.optional &&
          widget.field.textController!.text.isEmpty);

  String? get placeHolder =>
      isEng ? widget.field.placeHolder : widget.field.translatedPlaceHolder;
}
