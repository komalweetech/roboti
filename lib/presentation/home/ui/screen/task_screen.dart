import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roboti_app/common/widget/appbar/my_appbar.dart';
import 'package:roboti_app/presentation/home/ui/widget/home/localization_button.dart';
import 'package:roboti_app/presentation/home/ui/widget/home/my_logo_widget.dart';
import 'package:roboti_app/presentation/home/ui/widget/task/back_button.dart';
import 'package:roboti_app/presentation/home/ui/widget/task/category_task_screen.dart';
import 'package:roboti_app/presentation/home/ui/widget/task/task_shimmer.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/base_event.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/base_state.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/home_bloc.dart';

class TasksScreen extends StatefulWidget {
  static const String route = "category_screen";
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  void initState() {
    super.initState();
    homeBloc.add(GetTasksEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        leadingWidget: MyBackButton(),
        title: MyLogoWidget(),
        actionWidgets: [LocalizationButton()],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        bloc: homeBloc,
        builder: (context, state) => buildUi(context, state),
      ),
    );
  }

  Widget buildUi(BuildContext context, HomeState state) {
    if (state is TaskDataLoadingState || state is SelectCategorySuccessState) {
      return const TaskScreenLoadingShimmer();
    } else {
      return const CatergoryTaskScreen();
    }
  }
}
