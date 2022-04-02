import 'dart:io';

import 'package:nexo_analyzer/nexo_analyzer.dart';

void main(List<String> arguments) async {
  final file = File('nexo_transactions.csv');
  try {
    final args = ArgsParser.parse(arguments);
    final transactions = await parseCsvFile(file);
    switch (args.command) {
      case 'total':
        TotalEarningCommand(transactions);
        break;
      case 'each-month':
        TotalEarningEachMonthCommand(transactions);
        break;
      case 'month':
        if (arguments.length < 3) {
          print('Missing or invalid month and date');
          exit(1);
        }
        TotalEarningMonthCommand(transactions, [args.month, args.year]);
        break;
      case 'currency':
        TotalEarningForCurrency(
          transactions,
          [args.month, args.year, args.currency],
        );
        break;
      default:
        print('Unknown command..');
        exit(1);
    }
  } catch (e) {
    print(e);
    exit(1);
  }
}
