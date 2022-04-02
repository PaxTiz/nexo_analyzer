class Transaction {
  final String id;
  final TransactionType type;
  final String inputCurrency;
  final String inputAmount;
  final String outputCurrency;
  final double outputAmount;
  final double usdEquivalent;
  final String details;
  final double outstandingLoan;
  final DateTime earnedAt;

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
    required this.earnedAt,
  });

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
      earnedAt: DateTime.parse(list[9]),
    );
  }
}

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
