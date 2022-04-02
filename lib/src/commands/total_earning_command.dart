import './command.dart';
import '../models/arguments.dart';
import '../models/transaction.dart';

class TotalEarningCommand extends Command {
  TotalEarningCommand(
    Iterable<Transaction> transactions,
    Arguments arguments,
  ) : super(transactions, arguments);

  @override
  void execute(Iterable<Transaction> transactions, Arguments arguments) {
    final total = transactions.fold(
      0,
      (num value, element) => value + element.usdEquivalent,
    );
    print('Total earning = \$${humanReadablePrice(total)}');
  }

  @override
  Iterable<Transaction> filter(
    Iterable<Transaction> transactions,
    Arguments arguments,
  ) {
    return transactions.where((e) => e.type == TransactionType.interest);
  }
}
