/// Represents CLI arguments
class Arguments {
  /// Command to execute
  final String command;

  /// Filter transactions on this month
  final int? month;

  /// Filter transactions on this year
  final int? year;

  /// Filter transactions on this currency
  final String? currency;

  const Arguments({
    required this.command,
    this.month,
    this.year,
    this.currency,
  });
}
