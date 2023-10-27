import 'package:flutter/material.dart';

// stretch scroll behavior
class StretchyScrollBehavior extends ScrollBehavior{
  final AxisDirection direction;
  const StretchyScrollBehavior({Key? key, required this.direction}) : super();

  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return StretchingOverscrollIndicator(
      axisDirection: direction,
      child: child,
    );
  }

}