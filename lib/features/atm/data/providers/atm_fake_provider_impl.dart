import 'package:meta/meta.dart';

import 'package:flutter_atm/features/atm/data/models/bank_cell.dart';
import 'package:flutter_atm/features/atm/domain/providers/atm_fake_provider.dart';

class AtmFakeProviderImpl extends AtmFakeProvider {
  List<BankCell> balance;

  AtmFakeProviderImpl({
    @required this.balance,
  }) : assert(balance != null);

  @override
  List<BankCell> getBalance() {
    return balance;
  }
}
