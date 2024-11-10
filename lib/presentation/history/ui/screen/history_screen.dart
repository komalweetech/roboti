import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/common/widget/my_loader/custom_cupertino_loader.dart';
import 'package:roboti_app/common/widget/no_data_widget.dart';
import 'package:roboti_app/presentation/history/ui/widget/history_list_widget.dart';
import 'package:roboti_app/presentation/history/view_model/bloc/history_bloc.dart';
import 'package:roboti_app/presentation/history/view_model/bloc/history_events.dart';
import 'package:roboti_app/presentation/history/view_model/bloc/history_states.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    historyBloc.add(GetAllHistoryEvent());
    super.initState();
  }

  @override
  void dispose() {
    historyBloc.resetValues();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => primaryFocus!.unfocus(),
      child: Scaffold(
        body: BlocBuilder<HistoryBloc, HistoryStates>(
          bloc: historyBloc,
          builder: (context, state) {
            if (state is GetAllHistoryLoadingState) {
              return CustomCupertinoLoader.showLoaderWidget(center: true);
            } else if (historyBloc.history.isEmpty ||
                state is GetAllHistoryErrorState) {
              return NoDataWidget(text: lc(context).nohistorytodisplay);
            } else {
              return HistoryListWidget(
                history: historyBloc.history,
                state: state,
              );
            }
          },
        ),
      ),
    );
  }
}
