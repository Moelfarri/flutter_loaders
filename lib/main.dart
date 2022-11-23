import 'package:flutter/material.dart';
import 'package:flutter_loaders/custom_loading_indicators/pulse_in_out_progress_indicator.dart';
import 'custom_loading_indicators/cube_grid_progress_indicator.dart';
import 'custom_loading_indicators/fading_circle_progress_indicator.dart';
import 'custom_loading_indicators/three_bounce_progress_indicator.dart';
import 'custom_loading_indicators/chasing_dots_progress_indicator.dart';
import 'custom_loading_indicators/double_bounce_progress_indicator.dart';
import 'custom_loading_indicators/pulse_progress_indicator.dart';
import 'custom_loading_indicators/rotating_progress_indicator.dart';
import 'custom_loading_indicators/wandering_cubes_progress_indicator.dart';

//inspired by: https://tobiasahlin.com/spinkit/

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        colorSchemeSeed: Colors.red,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.red,
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //     ThreeBounceProgressIndicator( animationType: CircleAnimation.fade,),
            //   ThreeBounceProgressIndicator(),
            //    PulseInOutProgressIndicator(),
            //    PulseProgressIndicator(),
            //     DoubleBounceProgressIndicator(),
            //  RotatingProgressIndicator(),
            //  RotatingProgressIndicator(shape: RotatingObjectShape.rectangle,),
            // ChasingDotsProgressIndicator(),
            // WanderingCubesProgressIndicator(),
            //CubeGridProgressIndicator(),
            // FadingCircleProgressIndicator( shape: AnimationShape.ellipse,),
            // FadingCircleProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
