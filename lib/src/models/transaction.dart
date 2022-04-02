/// Represents a Nexo transaction
class Transaction {
  /// Transaction id
  final String id;

  /// Transaction type
  final TransactionType type;

  /// Calculate interests based on [inputAmount] in this currency
  final String inputCurrency;

  /// Owned amount in [inputCurrency]
  final String inputAmount;

  /// Currency in which interest are paid
  final String outputCurrency;

  /// Interests won in [outputCurrency]
  final double outputAmount;

  /// Equivalent in USD of [outputAmount] at [createdAt]
  final double usdEquivalent;

  /// Details about this transaction
  final String details;

  /// Amount to be refunded if user have a current load
  final double outstandingLoan;

  /// Date when this transaction has been created
  final DateTime createdAt;

  const Transaction({
    required this.id,
    required this.type,
    required this.inputCurrency,
    required this.inputAmount,
    required this.outputCurrency,
    required this.outputAmount,
    required this.usdEquivalent,
    required this.details,
    required this.outstandingLoan,
    required this.createdAt,
  });

  /// Creates a transaction from a CSV line
  factory Transaction.fromCsv(List<dynamic> list) {
    return Transaction(
      id: list[0],
      type: TransactionType.parse(list[1]),
      inputCurrency: list[2],
      inputAmount: list[3].toString(),
      outputCurrency: list[4],
      outputAmount: list[5].toDouble(),
      usdEquivalent: double.parse(list[6].toString().substring(1)),
      details: list[7],
      outstandingLoan: double.parse(list[8].toString().substring(1)),
      createdAt: DateTime.parse(list[9]),
    );
  }
}

/// Represents a Nexo transaction type
class TransactionType {
  final String name;
  const TransactionType._(this.name);

  static final interest = TransactionType._('interest');
  static final exchange = TransactionType._('exchange');
  static final exchangeCashback = TransactionType._('exchangeCashback');
  static final exchangeDepositedOn = TransactionType._('exchangeDepositedOn');
  static final depositToExchange = TransactionType._('depositToExchange');
  static final withdrawal = TransactionType._('withdrawal');
  static final deposit = TransactionType._('deposit');
  static final lockingTermDeposit = TransactionType._('lockingTermDeposit');
  static final fixedTermInterest = TransactionType._('fixedTermInterest');
  static final unlockingTermDeposit = TransactionType._('unlockingTermDeposit');

  /// Parse a transaction type from a string
  static TransactionType parse(String string) {
    switch (string) {
      case 'Interest':
        return TransactionType.interest;
      case 'Withdrawal':
        return TransactionType.withdrawal;
      case 'Deposit':
        return TransactionType.deposit;
      case 'Exchange Cashback':
        return TransactionType.exchangeCashback;
      case 'ExchangeDepositedOn':
        return TransactionType.exchangeDepositedOn;
      case 'DepositToExchange':
        return TransactionType.depositToExchange;
      case 'Exchange':
        return TransactionType.exchange;
      case 'LockingTermDeposit':
        return TransactionType.lockingTermDeposit;
      case 'FixedTermInterest':
        return TransactionType.fixedTermInterest;
      case 'UnlockingTermDeposit':
        return TransactionType.unlockingTermDeposit;
      default:
        throw Exception('$string is not a valid type');
    }
  }
}
