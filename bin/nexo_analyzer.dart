import 'dart:io';
import 'dart:mirrors';

import 'package:nexo_analyzer/nexo_analyzer.dart';

const commands = {
  'total': TotalEarningCommand,
  'month': TotalEarningMonthCommand,
  'each-month': TotalEarningEachMonthCommand,
  'currency': TotalEarningForCurrency,
};

void main(List<String> arguments) async {
  try {
    final config = await Config.read();
    final args = ArgsParser.parse(arguments);
    final transactions = await parseCsvFile(config.transactionsFile);
    final command = commands[args.command];
    reflectClass(command!).newInstance(Symbol.empty, [transactions, args]);
  } catch (_) {
    print(ArgsParser.help);
    exit(1);
  }
}
