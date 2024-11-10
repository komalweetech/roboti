import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roboti_app/app/app_view.dart';
import 'package:roboti_app/common/widget/appbar/my_appbar.dart';
import 'package:roboti_app/presentation/home/model/field_model.dart';
import 'package:roboti_app/presentation/home/ui/screen/chat_response_screen.dart';
import 'package:roboti_app/presentation/home/ui/widget/fields/fields_shimmer.dart';
import 'package:roboti_app/presentation/home/ui/widget/fields/task_form_screen.dart';
import 'package:roboti_app/presentation/home/ui/widget/home/localization_button.dart';
import 'package:roboti_app/presentation/home/ui/widget/home/my_logo_widget.dart';
import 'package:roboti_app/presentation/home/ui/widget/task/back_button.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/base_event.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/base_state.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/home_bloc.dart';
import 'package:roboti_app/presentation/subscription/views/screens/subscription_popup_screen.dart';
import 'package:roboti_app/utils/extensions/route_extension.dart';

class FieldsScreen extends StatefulWidget {
  static const String route = "fields_screen";
  final bool fromHistory;
  const FieldsScreen({
    super.key,
    this.fromHistory = false,
  });

  @override
  State<FieldsScreen> createState() => _FieldsScreenState();
}

class _FieldsScreenState extends State<FieldsScreen> {
  void _initializeFieldControllers() {
    if (!widget.fromHistory) {
      for (FieldModel field in homeBloc.form!.fields) {
        field.textController = TextEditingController();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => primaryFocus!.unfocus(),
      child: SubscriptionPopStackedWidget(
        onInit: () {
          if (!widget.fromHistory) {
            homeBloc.add(GetFieldsEvent());
          } else {
            homeBloc.add(GetEditTaskForHistoryEvent());
          }
        },
        onDispose: () {
          homeBloc.add(DisposeFieldsControllersEvent());
        },
        appbar: const MyAppBar(
          leadingWidget: MyBackButton(),
          title: MyLogoWidget(),
          actionWidgets: [LocalizationButton()],
        ),
        screen: BlocConsumer<HomeBloc, HomeState>(
          bloc: homeBloc,
          listener: (context, state) {
            if (state is ChatCompletionSuccessState) {
              if (widget.fromHistory) {
                context.pop();
              } else {
                context.pushNamed(ChatResponseScreen.route);
              }
            } else if (state is FieldsDataSuccessState) {
              _initializeFieldControllers();
            }
          },
          builder: (context, state) => buildUi(context, state),
        ),
      ),
    );
  }

  Widget buildUi(BuildContext context, HomeState state) {
    // if (state is FormFieldState) {
    if (state is FieldsDataLoadingState) {
      return const FiledScreenShimmer();
    } else {
      return TaskFormScreen(fromEng: isEng, fromHistory: widget.fromHistory);
    }
    //else {
    // return const SizedBox();
    // }
    // } else {
    //   return const SizedBox();
    // }
  }
}
