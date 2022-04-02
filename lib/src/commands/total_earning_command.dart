import './command.dart';
import '../models/transaction.dart';

class TotalEarningCommand extends Command {
  TotalEarningCommand(
    Iterable<Transaction> transactions,
  ) : super(transactions, null);

  @override
  void execute(Iterable<Transaction> transactions, List<dynamic>? params) {
    final total = transactions.fold(
      0,
      (num value, element) => value + element.usdEquivalent,
    );
    print('Total earning = \$${humanReadablePrice(total)}');
  }

  @override
  Iterable<Transaction> filter(
    Iterable<Transaction> transactions,
    List<dynamic>? params,
  ) {
    return transactions.where((e) => e.type == TransactionType.interest);
  }
}
