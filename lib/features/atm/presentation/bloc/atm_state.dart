import 'package:super_enum/super_enum.dart';

part 'atm_state.g.dart';

@superEnum
enum _AtmState {
  @object
  Initialized,
  @generic
  @Data(fields: [
    DataField('biils', Generic),
  ])
  BillsReturned,
  @object
  OperationFailed
}