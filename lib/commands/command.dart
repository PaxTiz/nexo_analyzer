import 'dart:io';

import 'package:nexo_analyzer/nexo_analyzer.dart';

abstract class Command {
  Command(Iterable<Transaction> transactions, List<dynamic>? params) {
    if (validate(params)) {
      execute(filter(transactions, params), params);
    } else {
      print(ArgsParser.help);
      exit(1);
    }
  }

  void execute(Iterable<Transaction> transactions, List<dynamic>? params);

  Iterable<Transaction> filter(
    Iterable<Transaction> transactions,
    List<dynamic>? params,
  ) {
    return transactions;
  }

  double humanReadablePrice(num price) {
    return double.parse(price.toStringAsFixed(2));
  }

  bool validate(List<dynamic>? params) {
    return true;
  }
}
