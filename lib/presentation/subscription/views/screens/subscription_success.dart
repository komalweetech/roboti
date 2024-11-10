import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/common/widget/my_buttons/my_elevated_button.dart';
import 'package:roboti_app/common/widget/text_view.dart';
import 'package:roboti_app/presentation/home/ui/widget/home/my_logo_widget.dart';
import 'package:roboti_app/presentation/subscription/view_model/bloc/subscription_bloc.dart';
import 'package:roboti_app/presentation/subscription/view_model/bloc/subscription_events.dart';
import 'package:roboti_app/theme/my_icons.dart';
import 'package:roboti_app/theme/text_styling.dart';
import 'package:roboti_app/utils/extensions/padding.dart';
import 'package:roboti_app/utils/extensions/route_extension.dart';
import 'package:roboti_app/utils/extensions/sized_box.dart';

class SubscriptionSuccessFull extends StatefulWidget {
  static const String route = "subscription-successfull";
  const SubscriptionSuccessFull({super.key});

  @override
  State<SubscriptionSuccessFull> createState() =>
      _SubscriptionSuccessFullState();
}

class _SubscriptionSuccessFullState extends State<SubscriptionSuccessFull> {
  ConfettiController controllerCenter =
      ConfettiController(duration: const Duration(seconds: 5));

  @override
  void initState() {
    super.initState();
    subscriptionBloc.add(ShowSubcriptionPopupEvent(showPopup: false));
    controllerCenter.play();
  }

  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 15;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const MyAppBar(title: MyLogoWidget()),
      body: Stack(
        children: [
          Padding(
            padding: 20.paddingH(context),
            child: Column(
              children: [
                64.vSpace(context),
                const MyLogoWidget(),
                94.vSpace(context),
                Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    MyIcons.robotilogo,
                    width: 262,
                    height: 217,
                  ),
                ),
                14.vSpace(context),
                TextView(
                  "${lc(context).congratulations}!",
                  style: myTextStyle.font_31BoldGreen,
                  textAlign: TextAlign.center,
                ),
                TextView(
                  "${lc(context).youreNowaPremiumMember}!! ",
                  style: myTextStyle.font_25BoldGreen,
                  textAlign: TextAlign.center,
                ),
                11.vSpace(context),
                TextView(
                  lc(context).premiumSuccessMsg,
                  style: myTextStyle.font_16wRegular,
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                MyElevatedButton(
                  onPressed: () => context.pop(),
                  text: lc(context).startGenerating,
                  textStyle: myTextStyle.font_20wMedium,
                ),
                const Spacer(),
              ],
            ),
          ),
          Align(alignment: Alignment.topCenter, child: confettiWidget()),
          Align(alignment: Alignment.topCenter, child: confettiWidget()),
          Align(alignment: Alignment.topRight, child: confettiWidget()),
        ],
      ),
    );
  }

  Widget confettiWidget() {
    return ConfettiWidget(
      confettiController: controllerCenter,
      blastDirectionality: BlastDirectionality.explosive,
      shouldLoop: false,
      colors: const [
        Colors.green,
        Colors.blue,
        Colors.pink,
        Colors.orange,
        Colors.purple
      ], // manually specify the colors to be used
      createParticlePath: drawStar, // define a custom shape/path.
    );
  }
}
