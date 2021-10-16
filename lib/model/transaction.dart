import 'package:flutter/material.dart';

class TransactionDto {

  final String type;
  final String code;
  final String date;
  final String amount;
  final String buySellValue;
  final String buySellValueInDollars;
  final String stockPriceInDollars;
  final String stockPriceInCrowns;

  TransactionDto({
      required this.type,
      required this.code,
      required this.date,
      required this.amount,
      required this.buySellValue,
      required this.buySellValueInDollars,
      required this.stockPriceInDollars,
      required this.stockPriceInCrowns
  });


  factory TransactionDto.fromJson(Map<String, dynamic> json) {
    return TransactionDto(
      type: json['type'],
      code: json['code'],
      date: json['date'],
      amount: json['amount'],
      buySellValue: json['buySellValue'],
      buySellValueInDollars: json['buySellValueInDollars'],
      stockPriceInDollars: json['stockPriceInDollars'],
      stockPriceInCrowns: json['stockPriceInCrowns'],
    );
  }

  bool selected = false;

}