import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class RTLPageRoute extends PageRouteBuilder {
  final Widget child;
  final int duration;
  RTLPageRoute(this.child, {this.duration = 900})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) {
            return child;
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: Offset.zero,
                  // end: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(secondaryAnimation),
                child: child,
              ),
            );
          },
          transitionDuration: Duration(milliseconds: duration),
        );
}

class BTTPageRoute extends PageRouteBuilder {
  final Widget child;
  final int duration;
  BTTPageRoute(this.child, {this.duration = 900})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) {
            return child;
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 1.0),
                end: Offset.zero,
              ).animate(animation),
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: Offset.zero,
                  // end: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(secondaryAnimation),
                child: child,
              ),
            );
          },
          transitionDuration: Duration(milliseconds: duration),
        );
}

class TTBPageRoute extends PageRouteBuilder {
  final Widget child;
  final int duration;
  TTBPageRoute(this.child, {this.duration = 900})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) {
            return child;
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, -1.0),
                end: Offset.zero,
              ).animate(animation),
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: Offset.zero,
                  // end: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(secondaryAnimation),
                child: child,
              ),
            );
          },
          transitionDuration: Duration(milliseconds: duration),
        );
}

class LTRPageRoute extends PageRouteBuilder {
  final Widget child;
  final int duration;
  LTRPageRoute(this.child, {this.duration = 900})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) {
            return child;
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(-1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: Offset.zero,
                  // end: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(secondaryAnimation),
                child: child,
              ),
            );
          },
          transitionDuration: Duration(milliseconds: duration),
        );
}
