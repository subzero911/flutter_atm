import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_atm/core/app_colors.dart';

import 'animated_wave.dart';

class WaveAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        AnimatedWave(
          height: 200,
          speed: 1.0,
          color: AppColors.primary.withAlpha(80),
        ),
        AnimatedWave(
          height: 140,
          speed: 0.9,
          offset: pi,
          color: AppColors.primarySecond.withAlpha(80),
        ),
        AnimatedWave(
          height: 220,
          speed: 1.2,
          offset: pi / 2,
          color: AppColors.primary.withOpacity(0.8),
        ),
        AnimatedWave(
          height: 160,
          speed: 1.1,
          offset: pi / 2,
          color: AppColors.primarySecond.withOpacity(0.8),
        ),
      ],
    );
  }
}
