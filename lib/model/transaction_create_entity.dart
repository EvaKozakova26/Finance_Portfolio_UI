import 'package:flutter/material.dart';

class TransactionCreateEntity {

  final String amount;
  final String transactionValue;
  final String assetType;
  final String currency;
  final DateTime transactionDate;

  TransactionCreateEntity({required this.assetType, required this.amount, required this.currency, required this.transactionDate, required this.transactionValue});

  factory TransactionCreateEntity.fromJson(Map<String, dynamic> json) {
    return TransactionCreateEntity(
      amount: json['amount'],
      currency: json['currency'],
      transactionValue: json['transactionValue'],
      assetType: json['assetType'],
      transactionDate: json['transactionDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'currency': currency,
      'transactionValue': transactionValue,
      'assetType': assetType,
      'transactionDate': transactionDate.toString(),
    };
  }
}