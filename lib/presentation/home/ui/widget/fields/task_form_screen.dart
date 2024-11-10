import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/common/widget/my_buttons/my_loader_elevated_button.dart';
import 'package:roboti_app/common/widget/text_view.dart';
import 'package:roboti_app/presentation/history/view_model/bloc/history_bloc.dart';
import 'package:roboti_app/presentation/home/model/field_model.dart';
import 'package:roboti_app/presentation/home/ui/widget/fields/form_fields_drop_down_widget.dart';
import 'package:roboti_app/presentation/home/ui/widget/fields/form_multiliner_input_field.dart';
import 'package:roboti_app/presentation/home/ui/widget/fields/form_single_input_field.dart';
import 'package:roboti_app/presentation/home/ui/widget/fields/image_picker_widget.dart';
import 'package:roboti_app/presentation/home/ui/widget/fields/scrollable_option_widget.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/base_event.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/base_state.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/home_bloc.dart';
import 'package:roboti_app/presentation/home/view_model/common/fields_enum.dart';
import 'package:roboti_app/presentation/subscription/views/widgets/membership_pop_up.dart';
import 'package:roboti_app/theme/my_colors.dart';
import 'package:roboti_app/theme/text_styling.dart';
import 'package:roboti_app/utils/app_constants/app_context.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';
import 'package:roboti_app/utils/extensions/padding.dart';
import 'package:roboti_app/utils/extensions/sized_box.dart';

class TaskFormScreen extends StatefulWidget {
  final bool fromHistory;
  const TaskFormScreen({
    super.key,
    required this.fromEng,
    required this.fromHistory,
  });

  final bool fromEng;

  @override
  State<TaskFormScreen> createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  @override
  void initState() {
    setDefaultToneAndLength();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) => ListView(
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
          // 2.vSpace(context),
          TextView(
            title,
            style: myTextStyle.font_25wRegular.copyWith(height: 1),
            padding: 20.paddingH(context),
            width: 100.percentWidth(context),
            overflow: TextOverflow.ellipsis,
          ),
          TextView(
            widget.fromEng
                ? homeBloc.selectedTask!.title
                : homeBloc.selectedTask!.translatedTitle,
            style: myTextStyle.font_25wRegular.copyWith(
              fontSize: 20.pxV(context),
              color: MyColors.indigo3958ED,
            ),
            padding: 20.paddingH(context),
            width: 100.percentWidth(context),
            overflow: TextOverflow.ellipsis,
          ),
          20.vSpace(context),

          if (homeBloc.form?.isImage ?? false) const ImagePickerWidget(),
          ...(homeBloc.form?.fields ?? [])
              .map((field) => _buildFormField(field, state)),
          if ((homeBloc.form?.isTone ?? false) ||
              (homeBloc.form?.isLength ?? false))
            67.vSpace(context),
          if (homeBloc.form?.isTone ?? false)
            HorizontalScrollableOptionsWIdget(
              title: lc(context).selectToneOfVoice,
              selectedValue: homeBloc.getSelectedTone(context),
              badgePadding: EdgeInsets.only(
                top: 8.pxV(context),
                left: 16.pxH(context),
                bottom: 9.pxV(context),
                right: 16.pxH(context),
              ),
              leftWidth: 20,
              children: [
                {'img': "🙂", "text": lc(context).normal},
                {'img': "😍", "text": lc(context).friendly},
                {'img': "❤️", "text": lc(context).lovely},
                {'img': "😞", "text": lc(context).sad},
                {'img': "👨", "text": lc(context).formal},
                {'img': "😡", "text": lc(context).angry},
                {'img': "😊", "text": lc(context).happy},
              ],
              onTap: (val) => setState(() => homeBloc.tone = val),
              key1: "img",
              key2: "text",
              // showRequired: state is FormFieldValidationErrorState,
              showRequired: false,
            ),

          if (homeBloc.form?.isLength ?? false) ...[
            if (homeBloc.form!.isTone) ...[
              17.5.vSpace(context),
              Container(
                height: 1,
                width: 100.percentWidth(context),
                color: MyColors.blue2575FC,
                margin: 20.paddingH(context),
              ),
              17.5.vSpace(context),
            ],
            HorizontalScrollableOptionsWIdget(
              selectedValue: homeBloc.getSelectedLength(context),
              title: "${lc(context).lengthOf} $title",
              badgePadding: EdgeInsets.only(
                top: 8.pxV(context),
                // left: 19.pxH(context),
                bottom: 9.pxV(context),
                // right: 36.pxH(context),
              ),
              badgeWidth: 100.percentWidth(context) / 3 - 14,
              children: [
                {'img': "📧", "text": lc(context).short},
                {'img': "📧", "text": lc(context).medium},
                {'img': "📧", "text": lc(context).long},
              ],
              onTap: (val) => setState(
                () {
                  homeBloc.length = val;
                  homeBloc.lengthInLines = homeBloc.getLength(val, context);
                },
              ),
              key1: "img",
              key2: "text",
              leftWidth: 20.pxH(context),
              // padding: 20.paddingH(context),
              titlePadding: 20.paddingH(context),
              // showRequired: state is FormFieldValidationErrorState,
              showRequired: false,
            ),
          ],
          if ((homeBloc.form?.isLength ?? false) ||
              (homeBloc.form?.isTone ?? false))
            29.vSpace(context),
          MyLoaderElvButton(
            state: state,
            text: lc(context).generate,
            onPressed: _onGenerateTap,
            padding: 16.paddingH(context),
            textStyle: myTextStyle.font_20wMedium,
          ),
          10.percentHeight(context).vSpace(context),
        ],
      ),
    );
  }

  void _onGenerateTap() {
    homeBloc.add(ChatCompletionLoadingEvent());
    TrialRequestHandler(
      context: context,
      onAllowed: () {
        if (widget.fromHistory) {
          historyBloc.resetValues();
        }
        homeBloc.add(GetChatCompletionEvent());
      },
    ).handleTrialRequest(() => homeBloc.add(StopChatCompletionLoadingEvent()));
  }

  Widget _buildFormField(FieldModel field, HomeState state) {
    switch (field.type) {
      case FieldType.dropDown:
        return FormFieldDropdownWidget(
          field: field,
          count: field.options.length,
          state: state,
        );
      case FieldType.input:
        return FormInputField(field: field, state: state);
      default:
        return FormMultilinerInputField(field: field, state: state);
    }
  }

  String get title => widget.fromEng
      ? homeBloc.selectedCategory!.title
      : homeBloc.selectedCategory!.translatedTitle;

  void setDefaultToneAndLength() {
    if (homeBloc.form?.isTone ?? true && homeBloc.tone.isEmpty) {
      homeBloc.tone = lc(GlobalContext.currentContext!).normal;
    }

    // if (homeBloc.form?.isLength ?? true && homeBloc.length.isEmpty) {
    //   homeBloc.length = lc(GlobalContext.currentContext!).medium;
    //   homeBloc.lengthInLines =
    //       homeBloc.getLength(homeBloc.length, GlobalContext.currentContext!);
    // }
  }
}
