import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// A custom page route that disables the animated transition on web and
/// shows the default MaterialPageRoute animation for other platforms
class CustomPageRoute<T> extends MaterialPageRoute<T> {
  CustomPageRoute({
    required super.builder,
    super.settings,
    super.fullscreenDialog,
  });

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (kIsWeb) {
      // Non animated transition on web
      return child;
    } else {
      // Default MaterialPageRoute animation for other platforms
      return super.buildTransitions(
        context,
        animation,
        secondaryAnimation,
        child,
      );
    }
  }
}
