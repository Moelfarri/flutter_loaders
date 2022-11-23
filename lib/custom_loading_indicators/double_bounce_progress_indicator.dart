import 'package:flutter/material.dart';

//Level 2 difficulty Progress Indicator

/*
- 2 circles
- size of small circle is animated
- size of big circle is animated
- the size animations go forward then in reverse 
 */
class DoubleBounceProgressIndicator extends StatefulWidget {
  final double animationSpeed;
  final double radius;
  final Color? color;

  const DoubleBounceProgressIndicator({
    Key? key,
    this.radius = 50.0,
    this.animationSpeed = 1.0,
    this.color,
  }) : super(key: key);

  @override
  State<DoubleBounceProgressIndicator> createState() =>
      _DoubleBounceProgressIndicatorState();
}

class _DoubleBounceProgressIndicatorState
    extends State<DoubleBounceProgressIndicator>
    with SingleTickerProviderStateMixin {
  late Animation<double> animationBigDot;
  late Animation<double> animationLittleDot;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: Duration(milliseconds: 500 * widget.animationSpeed.round()),
        vsync: this);

    animationBigDot = Tween<double>(begin: 1.0, end: 0.5).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeIn),
    );

    animationLittleDot = Tween<double>(begin: 0.0, end: 0.6).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeIn),
    );

    controller.addListener(() {
      setState(() {});
    });

    controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Transform.scale(
          scale: animationLittleDot.value,
          child: Container(
            width: widget.radius,
            height: widget.radius,
            decoration: BoxDecoration(
              color: widget.color ?? Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Opacity(
          opacity: 0.5,
          child: Transform.scale(
            scale: animationBigDot.value,
            child: Container(
              width: widget.radius,
              height: widget.radius,
              decoration: BoxDecoration(
                color: widget.color ?? Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
              ),
            ),
          ),
        )
      ],
    );
  }
}
