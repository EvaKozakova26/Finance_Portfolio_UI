import 'package:mystocks_ui/model/transaction.dart';

class TransactionListEntity {
  final List<TransactionDto> transactions;
  final double averageTransactionValueInDollars;
  final double averageTransactionValueInCrowns;

  TransactionListEntity({required this.averageTransactionValueInDollars, required this.averageTransactionValueInCrowns, required this.transactions});

  factory TransactionListEntity.fromJson(Map<String, dynamic> json) {
    var transactionsFromJson = json['transactions'] as List;
    List<TransactionDto> transactions = transactionsFromJson.map((transactionsJson) => TransactionDto.fromJson(transactionsJson)).toList();
    return TransactionListEntity(
        averageTransactionValueInCrowns: json['averageTransactionValueInCrowns'],
        averageTransactionValueInDollars: json['averageTransactionValueInDollars'],
        transactions: transactions,
    );
  }
}