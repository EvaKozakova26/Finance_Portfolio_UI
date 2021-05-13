import 'package:flutter/material.dart';

class CryptoTransactionDto {

  final String type;
  final String date;
  final String amountBtc;
  final String buySellValue;

  CryptoTransactionDto({
      @required this.type,
      @required this.date,
      @required this.amountBtc,
      @required this.buySellValue,
  });


  factory CryptoTransactionDto.fromJson(Map<String, dynamic> json) {
    return CryptoTransactionDto(
      type: json['type'],
      date: json['date'],
      amountBtc: json['amountBtc'],
      buySellValue: json['buySellValue'],
    );
  }

  bool selected = false;

}