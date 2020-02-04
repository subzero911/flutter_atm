import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_atm/features/atm/data/models/bank_cell.dart';
import 'package:meta/meta.dart';
import 'package:flutter_atm/features/atm/domain/repositories/atm_repository.dart';
import './bloc.dart';

class AtmBloc extends Bloc<AtmEvent, AtmState> {
  final AtmRepository atmRepository;

  AtmBloc({
    @required this.atmRepository
  }): assert (atmRepository != null);

  @override
  AtmState get initialState => AtmState.initialized();

  @override
  Stream<AtmState> mapEventToState(AtmEvent event) async* {
    yield* event.when(
        cashWithdrawn: (e) => _mapCashWithdrawnToState(e)
    ) as Stream<AtmState>;
  }

  Stream<AtmState> _mapCashWithdrawnToState(CashWithdrawn e) async* {
    List<BankCell> bills = atmRepository.cashWithdraw(e.amount);
    if (bills.isEmpty) {
      yield OperationFailed();
    } else {
      // If the operation was successful, update the balance of the ATM
      atmRepository.updateBalance();
      yield BillsReturned(biils: bills);
    }
  }
}
