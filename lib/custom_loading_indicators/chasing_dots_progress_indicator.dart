import 'package:flutter/material.dart';
import 'dart:math' as math;

//Level 2 difficulty Progress Indicator
/*
- 2 circles
- both have translation lowerCircleAnimation around the same center (like an orbit)
- each circle does only half a rotation, one on the downside and one on the opside
- both have a size lowerCircleAnimation, out of sync

 */

class ChasingDotsProgressIndicator extends StatefulWidget {
  final double animationSpeed;
  final double radius;
  final double distanceFromCenter;
  final Color? color;

  const ChasingDotsProgressIndicator({
    Key? key,
    this.radius = 50.0,
    this.distanceFromCenter = 0.2,
    this.animationSpeed = 1.0,
    this.color,
  }) : super(key: key);

  @override
  State<ChasingDotsProgressIndicator> createState() =>
      _ChasingDotsIndicatorState();
}

class _ChasingDotsIndicatorState extends State<ChasingDotsProgressIndicator>
    with TickerProviderStateMixin {
  late Animation<double> lowerCircleAnimation;
  late AnimationController lowerCircleController;
  late Animation<double> upperCircleAnimation;
  late AnimationController upperCircleController;

  double _lowerBegin = math.pi;
  double _lowerEnd = 0.0;
  double _upperBegin = math.pi;
  double _upperEnd = 2 * math.pi;

  @override
  void initState() {
    super.initState();

    lowerCircleController = AnimationController(
        duration: Duration(milliseconds: 1000 * widget.animationSpeed.round()),
        vsync: this);

    lowerCircleAnimation =
        Tween<double>(begin: _lowerBegin, end: _lowerEnd).animate(
      CurvedAnimation(
        parent: lowerCircleController,
        curve: Curves.linear,
      ),
    );

    lowerCircleController.addListener(() {
      setState(() {});
    });

    upperCircleController = AnimationController(
        duration: Duration(milliseconds: 1000 * widget.animationSpeed.round()),
        vsync: this);

    upperCircleAnimation =
        Tween<double>(begin: _upperBegin, end: _upperEnd).animate(
      CurvedAnimation(
        parent: upperCircleController,
        curve: Curves.linear,
      ),
    );

    upperCircleController.addListener(() {
      setState(() {});
    });

    lowerCircleController.repeat();
    upperCircleController.repeat();
  }

  @override
  void dispose() {
    lowerCircleController.dispose();
    upperCircleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //upper circle
        Transform.translate(
          offset: Offset(
            (widget.radius * widget.distanceFromCenter) *
                math.cos(upperCircleAnimation.value),
            (widget.radius * widget.distanceFromCenter) *
                math.sin(upperCircleAnimation.value),
          ),
          child: Transform.scale(
            scale: upperCircleAnimation.value / (2 * math.pi) - 0.5,
            child: Container(
              width: widget.radius,
              height: widget.radius,
              decoration: BoxDecoration(
                color: widget.color ?? Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        //lower circle
        Transform.translate(
          offset: Offset(
            (widget.radius * widget.distanceFromCenter) *
                math.cos(math.pi - lowerCircleAnimation.value),
            (widget.radius * widget.distanceFromCenter) *
                math.sin(math.pi - lowerCircleAnimation.value),
          ),
          child: Transform.scale(
            scale: lowerCircleAnimation.value / (math.pi * 2),
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
