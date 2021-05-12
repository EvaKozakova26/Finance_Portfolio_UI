import 'package:flutter/material.dart';
import 'btc_balance.dart';

class BitcoinInfo {
  final List<BtcBalance> btcRates;
  final String btcBalance;
  final String investedInCrowns;

  BitcoinInfo({@required this.btcBalance, @required this.btcRates, @required this.investedInCrowns});


  factory BitcoinInfo.fromJson(Map<String, dynamic> json) {
    var btcRatesFromJson = json['btcRates'] as List;
    List<BtcBalance> btcRates = btcRatesFromJson.map((btcBalanceJson) => BtcBalance.fromJson(btcBalanceJson)).toList();
    return BitcoinInfo(
      btcBalance: json['btcBalance'],
      btcRates: btcRates,
      investedInCrowns: json['investedInCrowns']
    );
  }
}