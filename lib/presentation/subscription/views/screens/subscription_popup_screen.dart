import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roboti_app/presentation/subscription/view_model/bloc/subscription_bloc.dart';
import 'package:roboti_app/presentation/subscription/view_model/bloc/subscription_events.dart';
import 'package:roboti_app/presentation/subscription/view_model/bloc/subscription_states.dart';
import 'package:roboti_app/presentation/subscription/views/widgets/subscription_pop_up.dart';

class SubscriptionPopStackedWidget extends StatefulWidget {
  final Widget screen;
  final Function() onInit;
  final Function() onDispose;
  final PreferredSizeWidget? appbar;
  const SubscriptionPopStackedWidget({
    super.key,
    required this.screen,
    this.appbar,
    required this.onInit,
    required this.onDispose,
  });

  @override
  State<SubscriptionPopStackedWidget> createState() =>
      _SubscriptionPopStackedWidgetState();
}

class _SubscriptionPopStackedWidgetState
    extends State<SubscriptionPopStackedWidget> {
  @override
  void initState() {
    super.initState();
    widget.onInit();
    subscriptionBloc.add(ResetSubscriptionStatesEvent());
  }

  @override
  void dispose() {
    widget.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SubscriptionBloc, SubscriptionState>(
      listener: (context, state) {
        if (subscriptionBloc.showPlans) {
          primaryFocus!.unfocus();
        }
      },
      bloc: subscriptionBloc,
      builder: (context, state) => Scaffold(
        appBar: subscriptionBloc.showPlans ? null : widget.appbar,
        body: Stack(
          children: [
            widget.screen,
            if (subscriptionBloc.showPlans)
              const Positioned(top: 0, left: 0, child: SubscriptionPopUp()),
          ],
        ),
      ),
    );
  }
}
