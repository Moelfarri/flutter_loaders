import 'dart:math' as math show sin, pi;

import 'package:flutter/material.dart';

enum AnimationShape { circle, ellipse }

class DelayTween extends Tween<double> {
  DelayTween({double? begin, double? end, required this.delay})
      : super(begin: begin, end: end);

  final double delay;

  @override
  double lerp(double t) =>
      super.lerp((math.sin((t - delay) * 2 * math.pi) + 1) / 2);

  @override
  double evaluate(Animation<double> animation) => lerp(animation.value);
}

class FadingCircleProgressIndicator extends StatefulWidget {
  final Color? color;
  final double size;
  final IndexedWidgetBuilder? itemBuilder;
  final Duration duration;
  final AnimationController? controller;
  final AnimationShape shape;

  const FadingCircleProgressIndicator({
    Key? key,
    this.color,
    this.size = 50.0,
    this.itemBuilder,
    this.duration = const Duration(milliseconds: 1200),
    this.controller,
    this.shape = AnimationShape.circle,
  }) : super(key: key);

  @override
  _FadingCircleProgressIndicatorState createState() =>
      _FadingCircleProgressIndicatorState();
}

class _FadingCircleProgressIndicatorState
    extends State<FadingCircleProgressIndicator>
    with SingleTickerProviderStateMixin {
  final List<double> delays = [
    0,
    -1.1,
    -1.0,
    -0.9,
    -0.8,
    -0.7,
    -0.6,
    -0.5,
    -0.4,
    -0.3,
    -0.2,
    -0.1
  ];
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = (widget.controller ??
        AnimationController(vsync: this, duration: widget.duration))
      ..repeat();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.fromSize(
        size: Size.square(widget.size),
        child: Stack(
          children: List.generate(12, (i) {
            final _position = widget.size * .5;
            return Positioned.fill(
              left: _position,
              top: _position,
              child: Transform(
                transform: Matrix4.rotationZ(30.0 * i * 0.0174533),
                child: Align(
                  alignment: Alignment.center,
                  child: FadeTransition(
                    opacity: DelayTween(begin: 0.0, end: 1.0, delay: delays[i])
                        .animate(_controller),
                    child: widget.shape == AnimationShape.circle
                        ? SizedBox.fromSize(
                            size: Size.square(widget.size * 0.15),
                            child: _itemBuilder(i))
                        : _itemBuilder(i),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _itemBuilder(int index) => widget.itemBuilder != null
      ? widget.itemBuilder!(context, index)
      : (widget.shape == AnimationShape.circle
          ? DecoratedBox(
              decoration: BoxDecoration(
              color: widget.color ?? Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
            ))
          : Transform.rotate(
              angle: 90 * 180 / 3.14,
              child: ClipOval(
                child: Container(
                  color: widget.color ?? Theme.of(context).colorScheme.primary,
                  height: widget.size / 10,
                  width: widget.size / 5,
                ),
              ),
            ));
}
