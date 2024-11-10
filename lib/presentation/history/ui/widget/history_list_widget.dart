import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/common/widget/my_loader/custom_cupertino_loader.dart';
import 'package:roboti_app/common/widget/my_text_field.dart';
import 'package:roboti_app/presentation/history/model/history_model.dart';
import 'package:roboti_app/presentation/history/ui/widget/chat_history_widget.dart';
import 'package:roboti_app/presentation/history/ui/widget/history_widget.dart';
import 'package:roboti_app/presentation/history/view_model/bloc/history_bloc.dart';
import 'package:roboti_app/presentation/history/view_model/bloc/history_events.dart';
import 'package:roboti_app/presentation/history/view_model/bloc/history_states.dart';
import 'package:roboti_app/presentation/history/view_model/extensions/searching_extension.dart';
import 'package:roboti_app/theme/my_icons.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';
import 'package:roboti_app/utils/extensions/padding.dart';

class HistoryListWidget extends StatefulWidget {
  final List<HistoryModel> history;
  final HistoryStates state;
  const HistoryListWidget({
    super.key,
    required this.history,
    required this.state,
  });

  @override
  State<HistoryListWidget> createState() => _HistoryListWidgetState();
}

class _HistoryListWidgetState extends State<HistoryListWidget> {
  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();
  List<HistoryModel> searchedData = [];
  bool isSearchTapped = false;

  @override
  void dispose() {
    searchController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      historyBloc.add(GetPaginatedHistoryEvent());
      // scrollController.jumpTo(scrollController.position.maxScrollExtent + 64);
    }
  }

  @override
  initState() {
    scrollController.addListener(_onScroll);
    super.initState();
  }

  void searchData(String val) {
    searchedData = widget.history.searchData(val);
  }

  void togggleSearchTap({bool? defVal}) {
    setState(() => isSearchTapped = defVal ?? !isSearchTapped);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyTextFormField(
          prefixIconPath: MyIcons.historySearchIcon,
          margin: 20.paddingH(context),
          bottomSpace: 24,
          hintText: lc(context).searchTask,
          controller: searchController,
          onChanged: (val) => setState(() => searchData(val)),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: data.length + 1,
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              double topMargin = index == 0 ? 13 : 0;
              // double btmMargin = index == data.length - 1 ? 40 : 6;
              double btmMargin = 6;
              if (index == data.length) {
                return SizedBox(
                  height: 10.percentHeight(context),
                  child: pagination
                      ? CustomCupertinoLoader.showLoaderWidget()
                      : null,
                );
              }
              if (data[index].isCompletion) {
                return HistoryWidget(
                  onTap: _onHistoryTap,
                  history: data[index],
                  topMargin: topMargin,
                  bottomMargin: btmMargin,
                );
              } else {
                return ChatHistoryWidget(
                  onTap: _onHistoryTap,
                  history: data[index],
                  topMargin: topMargin,
                  bottomMargin: btmMargin,
                );
              }
            },
          ),
        ),
      ],
    );
  }

  bool get pagination => (widget.state is GetAllHistoryPaginationLoadingState);

  List<HistoryModel> get data =>
      searchController.text.isEmpty ? widget.history : searchedData;

  void _onHistoryTap(HistoryModel history) {
    primaryFocus!.unfocus();
    historyBloc.selectedHistory = HistoryModel.copy(history);
    historyBloc.add(GetHistoryByIdEvent());
  }
}
