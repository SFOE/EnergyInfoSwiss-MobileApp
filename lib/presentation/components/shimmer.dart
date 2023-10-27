import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// This widgets provides a Shimmer effect
///
/// It creates a shimmer effect overlay for its child elements
/// The child elements require a solid background color for the effect to work
class Shimmer extends StatefulWidget {
  Shimmer({
    super.key,
    required this.child,
    required Color baseColor,
    required Color highlightColor,
    this.duration = const Duration(milliseconds: 1500),
  }) : gradient = LinearGradient(
    begin: Alignment.topLeft,
    colors: [baseColor, baseColor, highlightColor, baseColor, baseColor],
    stops: const [0.0, 0.2, 0.5, 0.8, 1.0],
  );

  final Widget child;
  final Duration duration;
  final Gradient gradient;

  @override
  ShimmerState createState() => ShimmerState();
}

class ShimmerState extends State<Shimmer> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..addListener(() {
        setState(() {
        });
      })
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _Shimmer(
    gradient: widget.gradient,
    percent: _controller.value,
    child: widget.child,
  );
}

// ignore: prefer-single-widget-per-file
class _Shimmer extends SingleChildRenderObjectWidget {
  const _Shimmer({Widget? child, required this.gradient, required this.percent}) : super(child: child);

  final Gradient gradient;
  final double percent;

  @override
  RenderObject createRenderObject(BuildContext context) => _ShimmerFilter(gradient);

  @override
  void updateRenderObject(BuildContext context, RenderObject renderObject) {
    super.updateRenderObject(context, renderObject);
    (renderObject as _ShimmerFilter).shiftPercentage = percent;
  }
}

class _ShimmerFilter extends RenderProxyBox {
  _ShimmerFilter(this._gradient);

  final Gradient _gradient;
  double _shiftPercentage = 0.0;

  set shiftPercentage(double newValue) {
    if (_shiftPercentage != newValue) {
      _shiftPercentage = newValue;
      markNeedsPaint();
    }
  }

  @override
  ShaderMaskLayer? get layer => super.layer as ShaderMaskLayer?;

  @override
  bool get alwaysNeedsCompositing => child != null;

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
      assert(needsCompositing);

      final width = child!.size.width;
      final height = child!.size.height;
      double dx = _offset(-width, width * 2, _shiftPercentage);
      double dy = 0.0;
      final rect = Rect.fromLTWH(dx, dy, width, height);

      layer ??= ShaderMaskLayer();
      layer!
        ..shader = _gradient.createShader(rect)
        ..maskRect = offset & size
        ..blendMode = BlendMode.srcIn;
      context.pushLayer(layer!, super.paint, offset);
    }
  }

  double _offset(double start, double end, double percent) => start + (end - start) * percent;
}