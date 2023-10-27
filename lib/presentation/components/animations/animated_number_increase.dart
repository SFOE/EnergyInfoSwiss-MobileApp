import 'dart:ui';

import 'package:energy_dashboard/core/mixins/kpi_card_mixin.dart';
import 'package:energy_dashboard/core/resources/color_palette.dart';
import 'package:flutter/material.dart';


class AnimatedNumberIncrease extends StatefulWidget with KPICardMixin{
  final double start;
  final double end;
  final Duration duration;
  final bool isDisabled;
  const AnimatedNumberIncrease({super.key, required this.start, required this.end, this.duration = const Duration(milliseconds: KPICardMixin.kNumberIncreaseDurationMs), this.isDisabled=false});

  @override
  State<AnimatedNumberIncrease> createState() => _AnimatedNumberIncreaseState();
}

class _AnimatedNumberIncreaseState extends State<AnimatedNumberIncrease> with SingleTickerProviderStateMixin{
  late ValueNotifier<double> _currentNumber;
  late AnimationController _controller;
  late Animation<double> _animation;


  @override
  void initState() {
    super.initState();
    _currentNumber = ValueNotifier(widget.start);
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
    _animation.addListener(() {
      _currentNumber.value = lerpDouble(
        widget.start,
        widget.end,
        _animation.value,
      )!;
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _currentNumber.dispose();
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _currentNumber,
      builder: (BuildContext context, Widget? child){
        final isInteger = widget.end % 1 == 0;
        // if end is integer do not show comma and decimal
        // else (if end is double) show comma with one decimal
        final formattedValue = isInteger
            ? _currentNumber.value.toInt().toString()
            : _currentNumber.value.toStringAsFixed(1);

        return Baseline(
          baseline: KPICardMixin.kValueTextStyle.fontSize!,
          baselineType: TextBaseline.alphabetic,
          child: Text(
            formattedValue,
            textAlign: TextAlign.end,
            style: KPICardMixin.kValueTextStyle.copyWith(color: ColorPalette.textColor.withOpacity(widget.isDisabled ? 0.7 : 1)),
          ),
        );
      },
    );
  }

}
