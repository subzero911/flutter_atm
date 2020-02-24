import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_atm/core/app_colors.dart';
import 'package:flutter_atm/features/atm/presentation/bloc/bloc.dart';
import 'package:flutter_atm/features/atm/presentation/widgets/animations/wave_animation_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeControls extends StatefulWidget {
  const HomeControls({
    Key key,
  }) : super(key: key);

  @override
  _HomeControlsState createState() => _HomeControlsState();
}

class _HomeControlsState extends State<HomeControls> {
  final _controller = TextEditingController();
  int inputAmount = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Column(
        children: <Widget>[
          Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Transform.rotate(
                    angle: -pi,
                    child: WaveAnimation()
                ),
                _buildInputBody(),
              ]
          ),
          ButtonTheme(
            minWidth: 200.0,
            height: 60.0,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(50.0),
              ),
              child: Text('Give out amount',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.white,
                  )),
              color: Theme.of(context).accentColor,
              textTheme: ButtonTextTheme.primary,
              onPressed: dispatchCashWithdrawn,
            ),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildInputBody() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            'Enter the amount:',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: AppColors.white,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 120),
          child: TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              WhitelistingTextInputFormatter.digitsOnly
            ], // Only nu
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 30,
              color: AppColors.white,
            ),
            decoration: InputDecoration(
              hintText: inputAmount.toString(),
              suffixText: '₽',
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.white),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.white.withOpacity(0.7)),
              ),
            ),
            textAlign: TextAlign.start,
            onChanged: (value) {
              inputAmount = int.parse(value);
            },
            onSubmitted: (_) {
              dispatchCashWithdrawn();
            },
          ),
        )
      ],
    );
  }

  void dispatchCashWithdrawn() {
    BlocProvider.of<AtmBloc>(context).add(
        CashWithdrawn(value: inputAmount)
    );
  }
}
