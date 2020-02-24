import 'package:flutter_atm/features/atm/data/models/bank_cell.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'atm_state.freezed.dart';

@freezed
abstract class AtmState with _$AtmState {
  const factory AtmState.initialized() = Initialized;
  const factory AtmState.billsReturned({List<BankCell> value}) = BillsReturned;
  const factory AtmState.operationFailed() = OperationFailed;
}