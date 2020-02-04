import 'package:super_enum/super_enum.dart';

part 'atm_event.g.dart';

@superEnum
enum _AtmEvent {
  @Data(fields: [
    DataField('amount', int),
  ])
  CashWithdrawn
}