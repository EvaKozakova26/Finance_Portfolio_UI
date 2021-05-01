import 'package:flutter/material.dart';
import 'btc_balance.dart';

class BitcoinInfo {
  final List<BtcBalance> btcRates;
  final String btcBalance;

  BitcoinInfo({@required this.btcBalance, @required this.btcRates});


  factory BitcoinInfo.fromJson(Map<String, dynamic> json) {
    var btcRatesFromJson = json['btcRates'] as List;
    print(btcRatesFromJson);
    List<BtcBalance> btcRates = btcRatesFromJson.map((btcBalanceJson) => BtcBalance.fromJson(btcBalanceJson)).toList();
    return BitcoinInfo(
      btcBalance: json['btcBalance'],
      btcRates: btcRates,
    );
  }
}