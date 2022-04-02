import 'dart:io';

import 'package:csv/csv.dart';

import './models/transaction.dart';

/// Parse a Nexo transactions CSV file to a list of [Transaction]
Future<Iterable<Transaction>> parseCsvFile(File file) async {
  return file
      .readAsString()
      .then(CsvToListConverter(eol: '\n').convert)
      .then((value) => value.skip(1).map(Transaction.fromCsv));
}
