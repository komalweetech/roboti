// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';

class MyColors {
  static Color containerShimmerColor = MyColors.grey4E5067.withOpacity(0.3);
  static const Color primaryDarkBlue060A19 = Color(0xff060A19);
  static const Color secondaryBlue141F48 = Color(0xff141F48);
  static Color pinFieldBlue141F48 = const Color(0xff141F48).withOpacity(0.4);
  static const Color softPinkFD6AF5 = Color(0xffFD6AF5);
  static const Color purple6C63FF = Color(0xff6C63FF);
  static const Color blue2575FC = Color(0xff2575FC);
  static const Color blue6C63FF = Color(0xff6C63FF);
  static const Color blue6B79AD = Color(0xff6B79AD);
  static const Color blue2A2D9E = Color(0xff2A2D9E);
  static const Color blue296FF9 = Color(0xff296FF9);
  static const Color blue601FD2 = Color(0xff601FD2);
  static const Color blue4B3EE1 = Color(0xff4B3EE1);
  static const Color grey74747B = Color(0xff74747B);
  static const Color grey161A27 = Color(0xff161A27);
  static const Color blue374A91 = Color(0xff374A91);
  static const Color lightblue6B79AD = Color(0xff6B79AD);
  static const Color indigo3958ED = Color(0xff3958ED);
  static const Color orangeF88B2E = Color(0xffF88B2E);
  static const Color blue0351FF = Color(0xff0351FF);
  static const Color blue23326A = Color(0xff23326A);
  static const Color lightBlue0D142F = Color(0xff0D142F);
  static const Color lightBlue404C79 = Color(0xff404C79);
  static const Color slateGrey676A88 = Color(0xff676A88);
  static const Color limeGreen67FF66 = Color(0xff67FF66);
  static const Color black0D0D0D = Color(0xff0D0D0D);
  static const Color black7B8598 = Color(0xff7B8598);
  static const Color tapSplashColor = Color.fromARGB(62, 167, 167, 167);
  static const Color grey252736 = Color(0xff252736);
  static const Color whiteFFFFFF = Color(0xffFFFFFF);
  static const Color white788598 = Color(0xff788598);
  static const Color whiteC1C1C1 = Color(0xffC1C1C1);
  static const Color greyD9D9D9 = Color(0xffD9D9D9);
  static const Color greyEAECF0 = Color(0xffEAECF0);
  static const Color grey707070 = Color(0xff707070);
  static const Color grey181924 = Color(0xff181924);
  static const Color grey4E5067 = Color(0xff4E5067);
  static const Color green658F7B = Color(0xff658F7B);
  static const Color green00D17F = Color(0xff00D17F);
  static const Color green67FF66 = Color(0xff67FF66);
  static const Color green667085 = Color(0xff667085);
  static const Color transparent = Colors.transparent;
  static const Color white585f78 = Color(0xff585f78);
  static const Color white = Colors.white;
  static const Color red = Colors.red;
  // Gradients
  static const LinearGradient gradientD21F79ToFC2525 = LinearGradient(
    colors: [Color(0xffD21F79), Color(0xffFC2525)],
  );

  static const LinearGradient gradient4B3EE1To2575FC = LinearGradient(
    colors: [Color(0xff4B3EE1), Color(0xff2575FC)],
  );
  static const LinearGradient gradient4B3EE1To2575FCTopToBottom =
      LinearGradient(
    colors: [Color(0xff4B3EE1), Color(0xff2575FC)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient gradient0014FFTo00E5FF = LinearGradient(
    colors: [Color(0xff0014FF), Color(0xff00E5FF)],
  );
  static const LinearGradient gradient0014FFTo00E5FFTopToBottom =
      LinearGradient(
    // colors: [Color(0xff0014FF), Color(0xff00E5FF)],
    colors: [Color(0xff601FD2), Color(0xff2575FC)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient gradient601FD2x2575FC = LinearGradient(
    colors: [Color(0xff601FD2), Color(0xff2575FC)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static Map<int, Color> get primarySwatch => {
        100: black0D0D0D,
        200: black0D0D0D,
        300: black0D0D0D,
        400: black0D0D0D,
        500: black0D0D0D,
        600: black0D0D0D,
        700: black0D0D0D,
        800: black0D0D0D,
        900: black0D0D0D,
        50: black0D0D0D,
        0: black0D0D0D,
      };
}
