import 'package:meta/meta.dart';

class BankCell {
  int count;
  final int denomination;

  BankCell({
    @required this.count,
    @required this.denomination
  }) : assert(count != null, denomination != null);

  @override
  String toString() {
    return "$count X ₽$denomination";
  }
}