import 'package:mystocks_ui/model/crypto_transaction.dart';

class CryptoTransactionListEntity {
  final List<CryptoTransactionDto> transactions;
  final double averageTransactionValueInDollars;
  final double averageTransactionValueInCrowns;

  CryptoTransactionListEntity({required this.averageTransactionValueInDollars, required this.averageTransactionValueInCrowns, required this.transactions});

  factory CryptoTransactionListEntity.fromJson(Map<String, dynamic> json) {
    var transactionsFromJson = json['cryptoTransactions'] as List;
    List<CryptoTransactionDto> cryptoTransactions = transactionsFromJson.map((transactionsJson) => CryptoTransactionDto.fromJson(transactionsJson)).toList();
    return CryptoTransactionListEntity(
        averageTransactionValueInCrowns: json['averageTransactionValueInCrowns'],
        averageTransactionValueInDollars: json['averageTransactionValueInDollars'],
        transactions: cryptoTransactions,
    );
  }
}