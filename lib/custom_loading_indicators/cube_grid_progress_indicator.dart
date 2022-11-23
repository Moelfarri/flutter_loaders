import 'package:flutter/material.dart';
import 'dart:math';

enum CircleAnimation { fade, bounce }

//Level 3 difficulty Progress Indicator
/*
-9 rectangles
-5 size animations
 
 */

class CubeGridProgressIndicator extends StatefulWidget {
  final double animationSpeed;
  final double size;
  final Color? color;
  final CircleAnimation animationType;

  const CubeGridProgressIndicator(
      {Key? key,
      this.animationSpeed = 1.0,
      this.size = 15.0,
      this.color,
      this.animationType = CircleAnimation.bounce})
      : super(key: key);

  @override
  State<CubeGridProgressIndicator> createState() =>
      _CubeGridProgressIndicatorState();
}

class _CubeGridProgressIndicatorState extends State<CubeGridProgressIndicator>
    with SingleTickerProviderStateMixin {
  late Animation<double> animationRightCircle;
  late Animation<double> animationMiddleCircle;
  late Animation<double> animationLeftCircle;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: Duration(milliseconds: 1000 * widget.animationSpeed.round()),
        vsync: this);

    animationRightCircle = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.70, curve: Curves.linear),
      ),
    );

    animationMiddleCircle = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.1, 0.80, curve: Curves.linear),
      ),
    );

    animationLeftCircle = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.2, 0.90, curve: Curves.linear),
      ),
    );

    controller.addListener(() {
      setState(() {});
    });

    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget animation(Widget child, double value) {
    return widget.animationType == CircleAnimation.bounce
        ? Transform.scale(
            scale: (value <= 0.4
                ? 2.5 * value
                : (value > 0.40 && value <= 0.60)
                    ? 1.0
                    : 2.5 - (2.5 * value)),
            child: child)
        : Opacity(
            opacity: (value <= 0.4
                ? 2.5 * value
                : (value > 0.40 && value <= 0.60)
                    ? 1.0
                    : 2.5 - (2.5 * value)),
            child: child);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              color: widget.color ?? Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}
