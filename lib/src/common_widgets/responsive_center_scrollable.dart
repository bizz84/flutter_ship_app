import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// A responsive centered scrollable layout that solves the problem described here:
/// https://rydmike.com/blog_layout_and_theming
/// Note that if a non-null ScrollController is given, it must be passed as a
/// controller to the child widget otherwise you will get this error:
/// "ScrollController not attached to any scroll views."
/// Example usage:
///
/// ```dart
/// final controller = ScrollController();
/// return ResponsiveCenterScrollable(
///   controller: controller,
///   child: ListView.builder(
///     controller: controller,
///     ...
///   ),
/// )
/// ```
///
/// Here's a GPT-4 chat explaining how the code was obtained:
/// https://cloud.typingmind.com/share/cb35afba-1141-4db7-9201-e2fea9a92b16
class ResponsiveCenterScrollable extends StatelessWidget {
  const ResponsiveCenterScrollable({
    super.key,
    this.maxContentWidth = 600,
    this.padding = EdgeInsets.zero,
    this.controller,
    required this.child,
  });
  final double maxContentWidth;
  final EdgeInsetsGeometry padding;
  final ScrollController? controller;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerSignal: (pointerSignal) {
        final c = controller;
        if (pointerSignal is PointerScrollEvent && c != null) {
          final newOffset = c.offset + pointerSignal.scrollDelta.dy;
          if (newOffset < c.position.minScrollExtent) {
            c.jumpTo(c.position.minScrollExtent);
          } else if (newOffset > c.position.maxScrollExtent) {
            c.jumpTo(c.position.maxScrollExtent);
          } else {
            c.jumpTo(newOffset);
          }
        }
      },
      child: Scrollbar(
        controller: controller,
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxContentWidth),
            child: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: Padding(
                padding: padding,
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// A simpler variant of ResponsiveCenterScrollable for non-scrollable layouts.
/// Shows a child with a maximum content width constraint.
/// If available width is larger than the maximum width, the child will be
/// centered.
/// If available width is smaller than the maximum width, the child use all the
/// available width.
class ResponsiveCenter extends StatelessWidget {
  const ResponsiveCenter({
    super.key,
    this.maxContentWidth = 600,
    this.padding = EdgeInsets.zero,
    required this.child,
  });
  final double maxContentWidth;
  final EdgeInsetsGeometry padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // Use Center as layout has unconstrained width (loose constraints),
    // together with SizedBox to specify the max width (tight constraints)
    // Also add a Scrollbar outside the Center widget and disable the inner one
    // See this article for more info:
    // https://rydmike.com/blog_layout_and_theming
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxContentWidth),
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
