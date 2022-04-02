import './command.dart';
import '../models/arguments.dart';
import '../models/transaction.dart';

class TotalEarningMonthCommand extends Command {
  TotalEarningMonthCommand(
    Iterable<Transaction> transactions,
    Arguments arguments,
  ) : super(transactions, arguments);

  @override
  void execute(Iterable<Transaction> transactions, Arguments arguments) {
    final total = transactions.fold(
      0,
      (num value, element) => value + element.usdEquivalent,
    );
    final date = '${arguments.month}/${arguments.year}';
    final formattedTotal = humanReadablePrice(total);
    print('Total earning for $date = \$$formattedTotal');
  }

  @override
  Iterable<Transaction> filter(
    Iterable<Transaction> transactions,
    Arguments arguments,
  ) {
    return transactions.where((e) => e.type == TransactionType.interest).where(
        (e) =>
            e.createdAt.month == arguments.month &&
            e.createdAt.year == arguments.year);
  }

  @override
  bool validate(Arguments arguments) {
    try {
      RangeError.checkValueInInterval(arguments.month!, 1, 12);
      return arguments.year != null;
    } catch (e) {
      return false;
    }
  }
}
