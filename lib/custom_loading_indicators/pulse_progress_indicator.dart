import 'package:flutter/material.dart';

//Level 1 difficulty Progress Indicator
/*
- 1 circle
- size animated
- opacity animated
 */
class PulseProgressIndicator extends StatefulWidget {
  final double animationSpeed;
  final double radius;
  final Color? color;

  const PulseProgressIndicator({
    Key? key,
    this.radius = 50.0,
    this.animationSpeed = 1.0,
    this.color,
  }) : super(key: key);

  @override
  State<PulseProgressIndicator> createState() => _PulseProgressIndicatorState();
}

class _PulseProgressIndicatorState extends State<PulseProgressIndicator>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: Duration(milliseconds: 1000 * widget.animationSpeed.round()),
        vsync: this);

    animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.8, curve: Curves.linear),
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
    return Opacity(
      opacity: 1 - animation.value,
      child: Transform.scale(
        scale: animation.value,
        child: Container(
          width: widget.radius,
          height: widget.radius,
          decoration: BoxDecoration(
            color: widget.color ?? Theme.of(context).colorScheme.primary,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
