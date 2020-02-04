import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations/controlled_animation.dart';

import 'curve_painter.dart';

class AnimatedWave extends StatelessWidget {
  final double height;

  final double speed;

  final double offset;

  final Color color;

  AnimatedWave({
    @required this.height,
    @required this.speed,
    @required this.color,
    this.offset = 0.0
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        height: height,
        width: constraints.biggest.width,
        child: ControlledAnimation(
            playback: Playback.LOOP,
            duration: Duration(milliseconds: (5000 / speed).round()),
            tween: Tween(begin: 0.0, end: 2 * pi),
            builder: (context, value) {
              return CustomPaint(
                foregroundPainter: CurvePainter(
                    value: value + offset,
                    color: color
                ),
              );
            }),
      );
    });
  }
}