import 'package:flutter/material.dart';

class AssetRate {

  final String currency;
  final String price;
  final String accBalance;

  AssetRate({required this.currency, required this.price, required this.accBalance});

  factory AssetRate.fromJson(Map<String, dynamic> json) {
    return AssetRate(
      currency: json['currency'],
      price: json['price'],
      accBalance: json['accBalance'],
    );
  }
}