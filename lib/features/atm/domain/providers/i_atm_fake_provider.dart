import 'package:flutter_atm/features/atm/data/models/bank_cell.dart';

abstract class IAtmFakeProvider {
  /// Gets the List<BankCell> which was gotten the last time.
  /// In a real application, use secure data storage!
  List<BankCell> getBalance();
}