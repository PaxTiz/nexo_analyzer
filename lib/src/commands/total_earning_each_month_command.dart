import './command.dart';
import '../models/transaction.dart';

class TotalEarningEachMonthCommand extends Command {
  TotalEarningEachMonthCommand(
    Iterable<Transaction> transactions,
  ) : super(transactions, null);

  @override
  void execute(Iterable<Transaction> transactions, List<dynamic>? params) {
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

  /// Returns all transactions that are of type [TransactionType.interest]
  /// to calculate the total earning.
  @override
  Iterable<Transaction> filter(
    Iterable<Transaction> transactions,
    List<dynamic>? params,
  ) {
    return transactions.where((e) => e.type == TransactionType.interest);
  }
}
