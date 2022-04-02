import 'dart:io';

import 'package:nexo_analyzer/nexo_analyzer.dart';

/// Represets a command that can be invoked from the CLI.
abstract class Command {
  /// Create a new command with [transactions] read from the CSV file
  /// and CLI [params].
  Command(Iterable<Transaction> transactions, List<dynamic>? params) {
    if (validate(params)) {
      execute(filter(transactions, params), params);
    } else {
      print(ArgsParser.help);
      exit(1);
    }
  }

  /// Execute this command.
  void execute(Iterable<Transaction> transactions, List<dynamic>? params);

  /// Filter [transactions] based on [params] if needed.
  ///
  /// Returns [transactions] by default.
  Iterable<Transaction> filter(
    Iterable<Transaction> transactions,
    List<dynamic>? params,
  ) {
    return transactions;
  }

  /// Validate that [params] are valid to execute this command.
  ///
  /// Returns `true` if [params] are correct.
  ///
  /// Always returns `true` by default.
  bool validate(List<dynamic>? params) {
    return true;
  }

  /// Returns a price with a human readable style.
  double humanReadablePrice(num price) {
    return double.parse(price.toStringAsFixed(2));
  }
}
