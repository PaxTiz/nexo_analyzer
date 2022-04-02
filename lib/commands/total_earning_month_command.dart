import './command.dart';
import '../models/transaction.dart';

class TotalEarningMonthCommand extends Command {
  TotalEarningMonthCommand(
    Iterable<Transaction> transactions,
    List<dynamic>? params,
  ) : super(transactions, params);

  @override
  void execute(Iterable<Transaction> transactions, List<dynamic>? params) {
    final month = params![0];
    final year = params[1];
    final total = transactions.fold(
      0,
      (num value, element) => value + element.usdEquivalent,
    );
    print('Total earning for $month/$year = \$${humanReadablePrice(total)}');
  }

  @override
  Iterable<Transaction> filter(
    Iterable<Transaction> transactions,
    List<dynamic>? params,
  ) {
    final month = params![0];
    final year = params[1];
    return transactions
        .where((e) => e.type == TransactionType.interest)
        .where((e) => e.earnedAt.month == month && e.earnedAt.year == year);
  }

  @override
  bool validate(List? params) {
    try {
      RangeError.checkValueInInterval(params?[0], 1, 12);
      return params != null && params.every((e) => e != null);
    } catch (e) {
      return false;
    }
  }
}
