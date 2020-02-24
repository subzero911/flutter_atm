import 'package:flutter_atm/features/atm/data/models/bank_cell.dart';

abstract class IAtmRepository {
  /// Allows you to watch the balance change
  Stream<List<BankCell>> watchBalance();

  /// Withdraws cash from an ATM
  List<BankCell> cashWithdraw(int amount);

  /// Updates the ATM balance
  void updateBalance();

  /// Called for the closure of the stream
  /// Be sure to close the stream to prevent memory leaks!
  void dispose();
}
