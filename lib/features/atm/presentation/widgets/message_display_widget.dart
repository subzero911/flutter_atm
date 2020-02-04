import 'package:flutter/material.dart';
import 'package:flutter_atm/core/app_colors.dart';

class MessageDisplay extends StatelessWidget {
  final String message;

  const MessageDisplay({
    Key key,
    @required this.message,
  })  : assert(message != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 10),
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: Text(
              message,
              style: TextStyle(fontSize: 18, color: AppColors.accent),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
