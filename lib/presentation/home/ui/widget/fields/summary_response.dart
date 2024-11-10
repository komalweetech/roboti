import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roboti_app/common/widget/bottom_sheet/my_btm_sheet.dart';
import 'package:roboti_app/common/widget/my_loader/custom_cupertino_loader.dart';
import 'package:roboti_app/common/widget/text_view.dart';
import 'package:roboti_app/presentation/home/ui/widget/fields/gpt_response_widget.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/base_state.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/home_bloc.dart';
import 'package:roboti_app/utils/extensions/media_query.dart';
import 'package:roboti_app/utils/extensions/padding.dart';

class SummaryResponse {
  static void showResponse(
    BuildContext context,
    bool translated,
    bool fromHistory,
  ) {
    MyBottomSheet.openBottomSheet(
      context,
      child: ChatSummaryResponseWidget(
          translated: translated, fromHistory: fromHistory),
      minHieght: 50.percentHeight(context),
    );
  }
}

class ChatSummaryResponseWidget extends StatelessWidget {
  final bool translated;
  final bool fromHistory;
  const ChatSummaryResponseWidget({
    super.key,
    required this.translated,
    required this.fromHistory,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) => SizedBox(
        height: 50.percentHeight(context),
        width: 100.percentWidth(context),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: _buildWidget(state, context, translated),
        ),
      ),
    );
  }

  Widget _buildWidget(HomeState state, BuildContext context, bool translated) {
    // if (state is ChatSummarizationLoadingState) {

    if (state is ChatSummarizationSuccessState) {
      return GPTResponseWidget(
        index: 1,
        total: 1,
        prompt: state.response,
        margin: 20.paddingH(context).copyWith(bottom: 60.pxV(context)),
        showRating: false,
        showSummarization: false,
        showDivider: false,
        showTranslation: false,
        alreadyTranslated: translated,
        fromHistory: fromHistory,
      );
    } else if (state is ChatSummarizationErrorState) {
      return TextView(state.message, padding: 20.paddingH(context));
    } else {
      return SizedBox(
        height: 40.percentHeight(context),
        width: 100.percentWidth(context),
        child: CustomCupertinoLoader.showLoaderWidget(
          bgColor: Colors.transparent,
        ),
      );
    }
  }
}
