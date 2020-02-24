import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_atm/features/atm/data/models/bank_cell.dart';
import 'package:flutter_atm/features/atm/domain/repositories/atm_repository.dart';
import './bloc.dart';

class AtmBloc extends Bloc<AtmEvent, AtmState> {
  final AtmRepository atmRepository;

  AtmBloc({
    @required this.atmRepository
  }): assert (atmRepository != null);

  @override
  AtmState get initialState => Initialized();

  @override
  Stream<AtmState> mapEventToState(AtmEvent event) async* {
    yield* _mapCashWithdrawnToState(event);
  }

  Stream<AtmState> _mapCashWithdrawnToState(CashWithdrawn e) async* {
    List<BankCell> bills = atmRepository.cashWithdraw(e.value);
    if (bills.isEmpty) {
      yield OperationFailed();
    } else {
      // If the operation was successful, update the balance of the ATM
      atmRepository.updateBalance();
      yield BillsReturned(value: bills);
    }
  }
}
