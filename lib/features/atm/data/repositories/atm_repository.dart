import 'dart:async';
import 'package:flutter_atm/features/atm/data/models/bank_cell.dart';
import 'package:flutter_atm/features/atm/domain/providers/i_atm_fake_provider.dart';
import 'package:flutter_atm/features/atm/domain/repositories/i_atm_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../../injection.dart';

@RegisterAs(IAtmRepository, env: Env.prod)
@lazySingleton
@injectable
class AtmRepository implements IAtmRepository {

  final IAtmFakeProvider atmProvider;

  StreamController<List<BankCell>> _streamController = new StreamController();

  List<BankCell> _balance = [];

  AtmRepository({@required this.atmProvider})
      : assert(atmProvider != null) {
    // Get and sort balance by denomination (ascending)
    _balance = atmProvider.getBalance()
      ..sort((a, b) => b.denomination.compareTo(a.denomination));
    // Add data to stream controller
    _streamController.add(_balance);
  }

  @override
  Stream<List<BankCell>> watchBalance() {
    return _streamController.stream;
  }

  List<BankCell> cashWithdraw(int amount) {
    List<BankCell> banknotes = [];
    // If there is enough money at the ATM
    if (_operationCanBePerformed(amount: amount)) {
      _balance.forEach((bills) {
        // Taking money from an ATM
        while (amount >= bills.denomination && bills.count != 0) {
          amount -= bills.denomination;
          bills.count -= 1;
          banknotes.add(BankCell(count: 1, denomination: bills.denomination));
        }
      });
    }
    // Collect money in bundles
    return _groupBanknotes(banknotes: banknotes);
  }

  void updateBalance() {
    _streamController.add(_balance);
  }

  bool _operationCanBePerformed({@required int amount}) {
    int balance = 0;
    int remains = amount;

    _balance.forEach((bills) {
      if (bills.count != 0) {
        // Check whether the change will remain
        while (remains >= bills.denomination) {
          remains -= bills.denomination;
        }
        // We consider the residual balance of the ATM
        balance += bills.denomination * bills.count;
      }
    });

    return balance >= amount && remains == 0;
  }

  List<BankCell> _groupBanknotes({@required List<BankCell> banknotes}) {
    List<int> denominations = _getBanknoteDenominations(banknotes: banknotes);
    List<BankCell> groupedBanknotes = [];

    // Collect bills according to their value
    denominations.forEach((denomination) {
      groupedBanknotes.add(BankCell(
          count: banknotes.fold(0, (sum, bills) =>
          (bills.denomination == denomination) ? sum + 1 : sum),
          denomination: denomination)
      );
    });

    return groupedBanknotes;
  }

  List<int> _getBanknoteDenominations({@required List<BankCell> banknotes}) {
    List<int> denominations = [];

    banknotes.forEach((bills) {
      denominations.add(bills.denomination);
    });

    // Return unique banknote denominations
    return denominations.toSet().toList();
  }

  @override
  void dispose() {
    _streamController.close();
  }
}
