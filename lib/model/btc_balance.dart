import 'package:flutter/material.dart';

class BtcBalance {

  final String currency;
  final String price;
  final String accBalance;

  BtcBalance({required this.currency, required this.price, required this.accBalance});

  factory BtcBalance.fromJson(Map<String, dynamic> json) {
    return BtcBalance(
      currency: json['currency'],
      price: json['price'],
      accBalance: json['accBalance'],
    );
  }
}