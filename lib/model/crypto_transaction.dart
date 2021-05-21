import 'package:flutter/material.dart';

class CryptoTransactionDto {

  final String type;
  final String date;
  final String amountBtc;
  final String buySellValue;
  final String buySellValueInDollars;
  final String stockPriceInDollars;
  final String stockPriceInCrowns;

  CryptoTransactionDto({
      @required this.type,
      @required this.date,
      @required this.amountBtc,
      @required this.buySellValue,
      @required this.buySellValueInDollars,
      @required this.stockPriceInDollars,
      @required this.stockPriceInCrowns
  });


  factory CryptoTransactionDto.fromJson(Map<String, dynamic> json) {
    return CryptoTransactionDto(
      type: json['type'],
      date: json['date'],
      amountBtc: json['amountBtc'],
      buySellValue: json['buySellValue'],
      buySellValueInDollars: json['buySellValueInDollars'],
      stockPriceInDollars: json['stockPriceInDollars'],
      stockPriceInCrowns: json['stockPriceInCrowns'],
    );
  }

  bool selected = false;

}