import 'dart:io';

import '../args_parser/args_parser.dart';
import '../models/arguments.dart';
import '../models/transaction.dart';

/// Represets a command that can be invoked from the CLI.
abstract class Command {
  /// Create a new command with [transactions] read from the CSV file
  /// and CLI [arguments].
  Command(Iterable<Transaction> transactions, Arguments arguments) {
    if (validate(arguments)) {
      execute(filter(transactions, arguments), arguments);
    } else {
      print(ArgsParser.help);
      exit(1);
    }
  }

  /// Execute this command.
  void execute(Iterable<Transaction> transactions, Arguments arguments);

  /// Filter [transactions] based on [arguments] if needed.
  ///
  /// Returns [transactions] by default.
  Iterable<Transaction> filter(
    Iterable<Transaction> transactions,
    Arguments arguments,
  ) {
    return transactions;
  }

  /// Validate that [arguments] are valid to execute this command.
  ///
  /// Returns `true` if [arguments] are correct.
  ///
  /// Always returns `true` by default.
  bool validate(Arguments arguments) {
    return true;
  }

  /// Returns a price with a human readable style.
  double humanReadablePrice(num price) {
    return double.parse(price.toStringAsFixed(2));
  }
}
