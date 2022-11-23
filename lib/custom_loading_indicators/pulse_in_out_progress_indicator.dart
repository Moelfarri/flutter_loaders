import 'package:flutter/material.dart';

//Level 1 difficulty Progress Indicator
class PulseInOutProgressIndicator extends StatefulWidget {
  final Widget? child;
  final double animationSpeed;

  const PulseInOutProgressIndicator({
    Key? key,
    this.child,
    this.animationSpeed = 1.0,
  }) : super(key: key);

  @override
  State<PulseInOutProgressIndicator> createState() =>
      _PulseInOutProgressIndicatorState();
}

class _PulseInOutProgressIndicatorState
    extends State<PulseInOutProgressIndicator>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: Duration(milliseconds: 700 * widget.animationSpeed.round()),
        //vsync: this - helps flutter optimize such that the animation only plays when this object is on the screen
        vsync: this);

    //Tween is a generic class that let's you decide the animation interval,
    //the animate method returns an Animation object which describes how this interval is to be animated
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        //the curve argument controls how fast animation.value goes from 0.0 (a) to 1.0 (b).
        curve: Curves.linear, //Interval(0.0, 0, curve: Curves.linear),
      ),
    );

    controller.addListener(() {
      setState(() {});
    });

    controller.repeat(
        reverse:
            true); //makes the animation.value go from 0 to 1 then from 1 to 0
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: animation.value,
      child: widget.child ??
          const FlutterLogo(
            size: 100,
          ),
    );
  }
}
