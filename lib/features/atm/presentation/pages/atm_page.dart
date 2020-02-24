import 'package:flutter/material.dart';
import 'package:flutter_atm/features/atm/data/models/bank_cell.dart';
import 'package:flutter_atm/features/atm/presentation/bloc/bloc.dart';
import 'package:flutter_atm/features/atm/presentation/widgets/animations/wave_animation_widget.dart';
import 'package:flutter_atm/features/atm/presentation/widgets/builders/atm_list_builder_widget.dart';
import 'package:flutter_atm/features/atm/presentation/widgets/gradient_background_widget.dart';
import 'package:flutter_atm/features/atm/presentation/widgets/home_controls_widget.dart';
import 'package:flutter_atm/features/atm/presentation/widgets/message_display_widget.dart';
import 'package:flutter_atm/injection_container.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';

class AtmPage extends StatelessWidget {

  get atmBloc => di.sl<AtmBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ATM'),
        flexibleSpace: GradientBackground(),
      ),
      body: SingleChildScrollView(
        child: _buildBody(context),
      ),
    );
  }

  BlocProvider<AtmBloc> _buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<AtmBloc>(),
      child: Column(
        children: <Widget>[
          HomeControls(),
          BlocBuilder<AtmBloc, AtmState>(builder: _atmPageBuilder),
          _buildBankBalance(context),
          WaveAnimation()
        ],
      ),
    );
  }

  Widget _atmPageBuilder(BuildContext context, AtmState state) {
    return state.map(
        initialized: (_) => Container(),
        billsReturned: (s) => _buildBillsReturned(context, s.value),
        operationFailed: (_) => MessageDisplay(
            message: 'The ATM cannot issue the requested amount!')
    );
  }

  StreamBuilder<List<BankCell>> _buildBankBalance(BuildContext context) {
    return StreamBuilder(
      stream: atmBloc.atmRepository.watchBalance(),
      builder: (context, AsyncSnapshot<List<BankCell>> snapshot) {
        final balance = snapshot.data ?? List();
        return AtmListBuilder(
            categoryName: 'ATM balance:',
            items: balance
        );
      },
    );
  }

  Widget _buildBillsReturned(BuildContext context, List<BankCell> bills) {
    return AtmListBuilder(
        categoryName: 'The ATM issued the following bills:',
        items: bills
    );
  }

}
