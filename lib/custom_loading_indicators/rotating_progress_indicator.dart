import 'package:flutter/material.dart';
import 'dart:math' as math;

enum RotatingObjectShape { circle, rectangle }

//Level 1 difficulty Progress Indicator
/*
- 1 Object rectangle or circle
- Rotation of object is animated
 */
class RotatingProgressIndicator extends StatefulWidget {
  final double animationSpeed;
  final double size;
  final Color? color;
  final RotatingObjectShape shape;

  const RotatingProgressIndicator({
    Key? key,
    this.size = 50.0,
    this.animationSpeed = 1.0,
    this.color,
    this.shape = RotatingObjectShape.circle,
  }) : super(key: key);

  @override
  State<RotatingProgressIndicator> createState() => _RotatingIndicatorState();
}

class _RotatingIndicatorState extends State<RotatingProgressIndicator>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: Duration(milliseconds: 1200 * widget.animationSpeed.round()),
        vsync: this);

    animation = Tween<double>(begin: 0.0, end: 2 * math.pi).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeIn,
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

  @override
  Widget build(BuildContext context) {
    return Transform(
      origin: Offset(widget.size / 2, widget.size / 2),
      transform: (animation.value <= math.pi)
          ? (Matrix4.identity()
            ..setEntry(3, 2, 1)
            ..setRotationY(animation.value))
          : (Matrix4.identity()
            ..setEntry(3, 2, 1)
            ..setRotationX(animation.value)),
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: widget.color ?? Theme.of(context).colorScheme.primary,
          shape: widget.shape == RotatingObjectShape.circle
              ? BoxShape.circle
              : BoxShape.rectangle,
        ),
      ),
    );
  }
}
