import 'package:energy_dashboard/core/mixins/ampel_system_mixin.dart';
import 'package:energy_dashboard/core/resources/paddings.dart';
import 'package:energy_dashboard/domain/entities/ampel.dart';
import 'package:energy_dashboard/presentation/components/ampel_system/ampel_system_body.dart';
import 'package:energy_dashboard/presentation/components/ampel_system/ampel_system_header.dart';
import 'package:energy_dashboard/presentation/components/ampel_system/ampel_system_tabs.dart';
import 'package:flutter/material.dart';


class AmpelSystem extends StatefulWidget {
  final Ampel ampel;
  const AmpelSystem({super.key, required this.ampel});

  @override
  State<AmpelSystem> createState() => _AmpelSystemState();
}

class _AmpelSystemState extends State<AmpelSystem> with TickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<double> _animation;
  late ValueNotifier<bool> _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = ValueNotifier(false);
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  dispose(){
    _controller.dispose();
    _isExpanded.dispose();
    super.dispose();
  }


  _toggleAmpelSystem() {
    if (_animation.status != AnimationStatus.completed) {
      _isExpanded.value = true;
      _controller.forward();
    } else {
      _controller.animateBack(0.15, duration: const Duration(milliseconds: 250),curve: Curves.fastOutSlowIn);
      _isExpanded.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(Paddings.paddingS, Paddings.paddingXS, Paddings.paddingS, Paddings.paddingM),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AmpelSystemMixin.kAmpelSystemBorderRadius),
        child: Stack(
          children: [
            AmpelSystemBody(
              ampel: widget.ampel,
              animation: _animation
            ),
            AmpelSystemHeader(
              ampel: widget.ampel,
              isExpanded: _isExpanded,
              toggleCallback: () => _toggleAmpelSystem()
            ),
            AmpelSystemTabs(ampel: widget.ampel),
          ],
        ),
      ),
    );
  }
}

