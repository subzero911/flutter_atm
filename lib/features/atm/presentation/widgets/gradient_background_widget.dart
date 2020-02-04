import 'package:flutter/material.dart';
import 'package:flutter_atm/core/app_colors.dart';

class GradientBackground extends StatelessWidget {

  final Widget child;

  const GradientBackground({
    this.child
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [AppColors.primary, AppColors.primarySecond]
          ),
      ),
      child: child ?? Container(),
    );
  }
}