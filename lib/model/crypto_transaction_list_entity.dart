import 'package:flutter/material.dart';
import 'package:mystocks_ui/model/crypto_transaction.dart';

class CryptoTransactionListEntity {
  final List<CryptoTransactionDto> transactions;

  CryptoTransactionListEntity({@required this.transactions});

  factory CryptoTransactionListEntity.fromJson(Map<String, dynamic> json) {
    var transactionsFromJson = json['cryptoTransactions'] as List;
    List<CryptoTransactionDto> cryptoTransactions = transactionsFromJson.map((transactionsJson) => CryptoTransactionDto.fromJson(transactionsJson)).toList();
    return CryptoTransactionListEntity(
        transactions: cryptoTransactions,
    );
  }
}