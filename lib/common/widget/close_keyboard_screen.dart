import 'package:flutter/material.dart';

class KeyboadClosableScreen extends StatelessWidget {
  final bool topSafeArea,
      bottomSafeArea,
      leftSafeArea,
      rightSafeArea,
      maintainBottomViewPadding,
      closeKeyboardOnScreenTap;
  final Function? onTap;
  final Widget child;
  final EdgeInsets padding;
  const KeyboadClosableScreen({
    super.key,
    this.topSafeArea = false,
    this.bottomSafeArea = false,
    this.leftSafeArea = false,
    this.rightSafeArea = false,
    this.closeKeyboardOnScreenTap = true,
    this.maintainBottomViewPadding = false,
    this.onTap,
    this.padding = EdgeInsets.zero,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (closeKeyboardOnScreenTap) {
          primaryFocus!.unfocus();
        }
        if (onTap != null) {
          onTap!();
        }
      },
      child: Scaffold(
        body: SafeArea(
          top: topSafeArea,
          left: leftSafeArea,
          right: rightSafeArea,
          bottom: bottomSafeArea,
          maintainBottomViewPadding: maintainBottomViewPadding,
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}
