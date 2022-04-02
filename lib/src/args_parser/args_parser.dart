import '../models/arguments.dart';

/// Parses CLI arguments
class ArgsParser {
  static const help = """
usage: nexo [--month] [--year] [--currency] {month|each-month|total|currency}
options:
  --month       filter on that month, 1-12
  --year        filter on that year
  --currency    filter on that currency, for a specific month/year or whole time
  """;

  static Arguments parse(List<dynamic> arguments) {
    final command = arguments[0];
    final args = arguments.sublist(1);
    if (args.isEmpty) {
      return Arguments(command: command);
    }

    return Arguments(
      command: command,
      month: _findArgument<int?>(args, ['--month', '-m'], 'month'),
      year: _findArgument<int?>(args, ['--year', '-y'], 'year'),
      currency: _findArgument<String?>(args, ['--currency', '-c'], 'currency'),
    );
  }

  static T _findArgument<T>(
    List<dynamic> args,
    List<String> options,
    String optionName,
  ) {
    int? argIndex = args.indexWhere((e) => options.contains(e));
    if (argIndex != -1 && argIndex + 1 >= args.length) {
      throw ArgumentError('must be defined', optionName);
    }

    final arg = args[argIndex + 1];
    dynamic returnValue = arg;
    if (argIndex == -1) {
      returnValue = null;
      return null as T;
    }

    if (int.tryParse(arg) != null) {
      returnValue = int.tryParse(arg);
    } else if (double.tryParse(arg) != null) {
      returnValue = double.tryParse(arg);
    } else if (['true', 'false'].contains(arg)) {
      returnValue = arg == 'true';
    }
    return returnValue as T;
  }
}
