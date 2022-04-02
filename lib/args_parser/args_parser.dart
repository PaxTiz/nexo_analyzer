class ArgsParser {
  final String command;

  final int? month;

  final int? year;

  final String? currency;

  static const help = """
usage: nexo [--month] [--year] [--currency] {month|each-month|total|currency}
options:
  --month       filter on that month, 1-12
  --year        filter on that year
  --currency    filter on that currency, for a specific month/year or whole time
  """;

  ArgsParser._(this.command, this.month, this.year, this.currency);

  factory ArgsParser.parse(List<dynamic> arguments) {
    final command = arguments[0];
    final args = arguments.sublist(1);
    if (args.isEmpty) {
      return ArgsParser._(command, null, null, null);
    }

    return ArgsParser._(
      command,
      _findArgument<int?>(args, ['--month', '-m'], 'month'),
      _findArgument<int?>(args, ['--year', '-y'], 'year'),
      _findArgument<String?>(args, ['--currency', '-c'], 'currency'),
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
