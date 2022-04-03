import 'dart:convert';
import 'dart:io';

/// Represents the configuration file placed at
/// `$HOME/.confg/nexo/config.json`
class Config {
  /// CSV file containing all the transactions
  File transactionsFile;

  /// Date when the last calculation of earnings was made
  DateTime? crawledAt;

  Config({
    required this.transactionsFile,
    required this.crawledAt,
  });

  /// Read the configuration from the JSON file
  static Future<Config> read() async {
    final path = Platform.environment['HOME'];
    if (path == null) {
      throw FileSystemException('User home directory not found');
    }

    final nexoDirectory = '$path/.config/nexo';
    final configFile = File('$nexoDirectory/config.json');
    final configFileExists = await configFile.exists();
    if (!configFileExists) {
      await configFile.create(recursive: true);
      final config = jsonEncode({
        'transactionsFile': '$nexoDirectory/transactions.csv',
        'crawledAt': null
      });
      await configFile.writeAsString(config);
    }

    final configAsString = await configFile.readAsString();
    final config = jsonDecode(configAsString);

    return Config(
      transactionsFile: File(config['transactionsFile']),
      crawledAt: DateTime.tryParse(config['crawledAt'] ?? ''),
    );
  }

  /// Write this configuration to the file
  void write() {}
}
