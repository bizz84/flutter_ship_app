import 'package:flutter/material.dart';

/// Reusable widget for showing a child with a maximum content width constraint.
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
    // See this tip for more info:
    // https://github.com/bizz84/flutter-tips-and-tricks/blob/main/tips/0013-responsive-flutter-card-layout-with-sizedbox-center/index.md
    return Center(
      child: SizedBox(
        width: maxContentWidth,
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
