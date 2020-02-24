import 'package:freezed_annotation/freezed_annotation.dart';

part 'atm_event.freezed.dart';

@freezed
abstract class AtmEvent with _$AtmEvent {
  const factory AtmEvent.cashWithdrawn({int value}) = CashWithdrawn;
}