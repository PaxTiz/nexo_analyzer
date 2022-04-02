import './command.dart';
import '../models/transaction.dart';

class TotalEarningForCurrency extends Command {
  TotalEarningForCurrency(
    Iterable<Transaction> transactions,
    List<dynamic>? params,
  ) : super(transactions, params);

  @override
  void execute(Iterable<Transaction> transactions, List<dynamic>? params) {
    final month = params?[0];
    final year = params?[1];
    final currency = params![2].toUpperCase();
    final total = transactions.fold(
      0,
      (num value, element) => value + element.usdEquivalent,
    );
    final text = StringBuffer('Total earning for $currency for ');
    if (month == null && year == null) {
      text.write('all time');
    } else if (month == null) {
      text.write('year $year');
    } else {
      text.write('$month/$year');
    }
    text.write(' = \$${humanReadablePrice(total)}');
    print(text);
  }

  @override
  Iterable<Transaction> filter(
    Iterable<Transaction> transactions,
    List<dynamic>? params,
  ) {
    final month = params?[0];
    final year = params?[1];
    final currency = params![2].toUpperCase();
    transactions = transactions.where(
      (e) => e.type == TransactionType.interest,
    );
    transactions = transactions.where((e) {
      final details = e.details.split(' ');
      if (currency == 'NEXO') {
        return details[details.length - 3] == currency;
      }
      return details.last == currency;
    });
    transactions = transactions.where((e) {
      if (month != null && year == null) {
        return e.earnedAt.month == month;
      }
      if (month == null && year != null) {
        return e.earnedAt.year == year;
      }
      return e.earnedAt.month == month && e.earnedAt.year == year;
    });
    return transactions;
  }

  @override
  bool validate(List? params) {
    try {
      if (params?[2] == null) {
        // Currency can't be null
        return false;
      }
      if (params?[0] != null && params?[1] == null) {
        // If month is defined, then year must be also defined
        return false;
      }
      if (params?[0] != null) {
        RangeError.checkValueInInterval(params?[0], 1, 12);
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
