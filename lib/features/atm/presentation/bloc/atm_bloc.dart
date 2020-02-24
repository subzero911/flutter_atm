import 'package:bloc/bloc.dart';
import 'package:flutter_atm/injection.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:flutter_atm/features/atm/data/models/bank_cell.dart';
import 'package:flutter_atm/features/atm/domain/repositories/i_atm_repository.dart';
import './bloc.dart';

@Environment(Env.prod)
@injectable
class AtmBloc extends Bloc<AtmEvent, AtmState> {
  final IAtmRepository atmRepository;

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
