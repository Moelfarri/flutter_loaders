import 'package:flutter/material.dart';
import 'dart:math' as math;

//Level 2 difficulty Progress Indicator
/*
- 2 rectangles
- starting diagonally to each other
- translating around in a rectangular shape
- rotating 90 degrees on each x or y translation
- also size is pulsing in its own frequency
 */

class WanderingCubesProgressIndicator extends StatefulWidget {
  final double animationSpeed;
  final double size;
  final bool referenceCenterActive;
  final Color? color;

  const WanderingCubesProgressIndicator({
    Key? key,
    this.size = 20.0,
    this.animationSpeed = 1.0,
    this.color,
    this.referenceCenterActive = false,
  }) : super(key: key);

  @override
  State<WanderingCubesProgressIndicator> createState() =>
      _WanderingCubesProgressIndicatoState();
}

class _WanderingCubesProgressIndicatoState
    extends State<WanderingCubesProgressIndicator>
    with TickerProviderStateMixin {
  late Animation<double> translationRotationAnimation;
  late AnimationController translationRotationController;
  late Animation<double> scaleAnimation;
  late AnimationController scaleController;

  @override
  void initState() {
    super.initState();

    translationRotationController = AnimationController(
        duration: Duration(milliseconds: 1000 * widget.animationSpeed.round()),
        vsync: this);

    translationRotationAnimation = Tween<double>(begin: 0, end: 4).animate(
      CurvedAnimation(
        parent: translationRotationController,
        curve: Curves.linear,
      ),
    );

    translationRotationController.addListener(() {
      setState(() {});
    });

    translationRotationController.repeat();

    scaleController = AnimationController(
        duration: Duration(milliseconds: 500 * widget.animationSpeed.round()),
        vsync: this);

    scaleAnimation = Tween<double>(begin: 1.0, end: 0.5).animate(
      CurvedAnimation(
        parent: scaleController,
        curve: Curves.linear,
      ),
    );

    scaleController.addListener(() {
      setState(() {});
    });

    scaleController.repeat(reverse: true);
  }

  @override
  void dispose() {
    translationRotationController.dispose();
    scaleController.dispose();

    super.dispose();
  }

  Offset rectangularTranslation(
      double startingX, double startingY, double tween) {
    if (tween > 4.0) {
      tween = tween - 4.0;
    }

    //bottom left up to top left
    if (tween <= 1.0) {
      return Offset(
        startingX,
        startingY - 2 * widget.size * tween,
      );
    }

    //top right down to bottom right
    if (tween > 1.0 && tween <= 2.0) {
      return Offset(
        startingX + 2 * widget.size * (tween - 1.0),
        startingY - 2 * widget.size,
      );
    }

    if (tween > 2.0 && tween <= 3.0) {
      return Offset(startingX + 2 * widget.size,
          (startingY - 2 * widget.size) + 2 * widget.size * (tween - 2.0));
    } else {
      //bottom right to bottom left
      return Offset(
        startingX + 2 * widget.size - 2 * widget.size * (tween - 3.0),
        startingY,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        //reference center for debugging
        widget.referenceCenterActive
            ? Container(
                width: 2,
                height: 2,
                decoration: BoxDecoration(
                  color: widget.color ?? Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                ),
              )
            : const SizedBox(),

        //first rectangle
        Transform.translate(
          offset: rectangularTranslation(-widget.size, widget.size,
              2 + translationRotationAnimation.value),
          child: Transform.scale(
            scale: scaleAnimation.value,
            child: Transform.rotate(
              angle: -math.pi / 4 * translationRotationAnimation.value,
              child: Container(
                width: widget.size,
                height: widget.size,
                decoration: BoxDecoration(
                  color: widget.color ?? Theme.of(context).colorScheme.primary,
                  shape: BoxShape.rectangle,
                ),
              ),
            ),
          ),
        ),

        //second rectangle
        Transform.translate(
          offset: rectangularTranslation(
              -widget.size, widget.size, translationRotationAnimation.value),
          child: Transform.scale(
            scale: scaleAnimation.value,
            child: Transform.rotate(
              angle: -math.pi / 4 * translationRotationAnimation.value,
              child: Container(
                width: widget.size,
                height: widget.size,
                decoration: BoxDecoration(
                  color: widget.color ?? Theme.of(context).colorScheme.primary,
                  shape: BoxShape.rectangle,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
