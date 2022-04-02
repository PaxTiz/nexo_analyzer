import './command.dart';
import '../models/arguments.dart';
import '../models/transaction.dart';

class TotalEarningEachMonthCommand extends Command {
  TotalEarningEachMonthCommand(
    Iterable<Transaction> transactions,
    Arguments arguments,
  ) : super(transactions, arguments);

  @override
  void execute(Iterable<Transaction> transactions, Arguments arguments) {
    final Map<DateTime, double> dateEarnings = {};
    for (final transaction in transactions) {
      final earnedAt = transaction.createdAt;
      final usdEquivalent = transaction.usdEquivalent;
      dateEarnings.update(
        DateTime(earnedAt.year, earnedAt.month),
        (value) => value + usdEquivalent,
        ifAbsent: () => usdEquivalent,
      );
    }

    dateEarnings.forEach((key, value) {
      final date = '${key.month}/${key.year}';
      print('Total earning for $date = \$${humanReadablePrice(value)}');
    });
    print('-------------');
    final total = dateEarnings.values.reduce((a, b) => a + b);
    print('Total = \$${humanReadablePrice(total)}');
  }

  @override
  Iterable<Transaction> filter(
    Iterable<Transaction> transactions,
    Arguments arguments,
  ) {
    return transactions.where((e) => e.type == TransactionType.interest);
  }
}
