import 'package:flutter/material.dart';
import 'dart:math';

//https://github.com/samarthagarwal/FlutterScreens/tree/master/lib/loaders

enum CircleAnimation { fade, bounce }

//Level 3 difficulty Progress Indicator
/*
- 3 circles
- they are out of sync but appear after each other
- can be done with 3 animation controllers or just one with nested if sentences
  and parameter tuning
 */

class ThreeBounceProgressIndicator extends StatefulWidget {
  final double animationSpeed;
  final double radius;
  final Color? color;
  final CircleAnimation animationType;

  const ThreeBounceProgressIndicator(
      {Key? key,
      this.animationSpeed = 1.0,
      this.radius = 15.0,
      this.color,
      this.animationType = CircleAnimation.bounce})
      : super(key: key);

  @override
  State<ThreeBounceProgressIndicator> createState() =>
      _ThreeBounceProgressIndicatorState();
}

class _ThreeBounceProgressIndicatorState
    extends State<ThreeBounceProgressIndicator>
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
          //circle 1
          animation(
              Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: Container(
                  width: widget.radius,
                  height: widget.radius,
                  decoration: BoxDecoration(
                    color:
                        widget.color ?? Theme.of(context).colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              animationRightCircle.value),
          //circle 2
          animation(
              Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: Container(
                  width: widget.radius,
                  height: widget.radius,
                  decoration: BoxDecoration(
                    color:
                        widget.color ?? Theme.of(context).colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              animationMiddleCircle.value),

          //circle 3
          animation(
              Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: Container(
                  width: widget.radius,
                  height: widget.radius,
                  decoration: BoxDecoration(
                    color:
                        widget.color ?? Theme.of(context).colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              animationLeftCircle.value),
        ],
      ),
    );
  }
}
