import 'package:flutter/material.dart';

class BitcoinInfo {
  final String priceInDollars;
  final String btcBalance;
  final String accBalance;

  BitcoinInfo({@required this.priceInDollars, @required this.btcBalance, @required this.accBalance});

  factory BitcoinInfo.fromJson(Map<String, dynamic> json) {
    return BitcoinInfo(
      priceInDollars: json['priceInDollars'],
      btcBalance: json['btcBalance'],
      accBalance: json['accBalance'],
    );
  }
}