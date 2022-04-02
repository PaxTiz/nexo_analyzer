import './command.dart';
import '../models/arguments.dart';
import '../models/transaction.dart';

class TotalEarningForCurrency extends Command {
  TotalEarningForCurrency(
    Iterable<Transaction> transactions,
    Arguments arguments,
  ) : super(transactions, arguments);

  @override
  void execute(Iterable<Transaction> transactions, Arguments arguments) {
    final total = transactions.fold(
      0,
      (num value, element) => value + element.usdEquivalent,
    );
    final text = StringBuffer('Total earning for ${arguments.currency} for ');
    if (arguments.month == null && arguments.year == null) {
      text.write('all time');
    } else if (arguments.month == null) {
      text.write('year ${arguments.year}');
    } else {
      text.write('${arguments.month}/${arguments.year}');
    }
    text.write(' = \$${humanReadablePrice(total)}');
    print(text);
  }

  @override
  Iterable<Transaction> filter(
    Iterable<Transaction> transactions,
    Arguments arguments,
  ) {
    final currency = arguments.currency!.toUpperCase();
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
      if (arguments.month != null && arguments.year == null) {
        return e.createdAt.month == arguments.month;
      }
      if (arguments.month == null && arguments.year != null) {
        return e.createdAt.year == arguments.year;
      }
      return e.createdAt.month == arguments.month &&
          e.createdAt.year == arguments.year;
    });
    return transactions;
  }

  @override
  bool validate(Arguments arguments) {
    try {
      if (arguments.currency == null) {
        return false;
      }
      if (arguments.month != null && arguments.year == null) {
        return false;
      }
      if (arguments.month != null) {
        RangeError.checkValueInInterval(arguments.month!, 1, 12);
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
