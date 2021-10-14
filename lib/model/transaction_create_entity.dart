import 'package:flutter/material.dart';

class TransactionCreateEntity {

  final String amount;
  final String transactionValue;
  final String assetType;
  final DateTime transactionDate;

  TransactionCreateEntity({required this.assetType, required this.amount, required this.transactionDate, required this.transactionValue});

  factory TransactionCreateEntity.fromJson(Map<String, dynamic> json) {
    return TransactionCreateEntity(
      amount: json['amount'],
      transactionValue: json['transactionValue'],
      assetType: json['assetType'],
      transactionDate: json['transactionDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'transactionValue': transactionValue,
      'assetType': assetType,
      'transactionDate': transactionDate.toString(),
    };
  }
}