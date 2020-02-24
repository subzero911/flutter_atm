import 'package:meta/meta.dart';

import 'package:flutter_atm/features/atm/data/models/bank_cell.dart';
import 'package:flutter_atm/features/atm/domain/providers/i_atm_fake_provider.dart';

class AtmFakeProvider implements IAtmFakeProvider {
  List<BankCell> balance;

  AtmFakeProvider({
    @required this.balance,
  }) : assert(balance != null);

  @override
  List<BankCell> getBalance() {
    return balance;
  }
}
