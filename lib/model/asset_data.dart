import 'package:flutter/material.dart';
import 'package:mystocks_ui/model/AssetType.dart';
import 'btc_balance.dart';

class AssetData {
  final String type;
  final String symbol;
  final List<AssetRate> assetBalanceList;
  final String assetBalance;
  final String investedInCrowns;

  AssetData( {required this.type, required this.symbol, required this.assetBalance, required this.assetBalanceList, required this.investedInCrowns});


  factory AssetData.fromJson(Map<String, dynamic> json) {
    var assetRatesFromJson = json['assetBalanceList'] as List;
    List<AssetRate> assetRates = assetRatesFromJson.map((btcBalanceJson) => AssetRate.fromJson(btcBalanceJson)).toList();
    return AssetData(
      type: json['type'],
      symbol: json['symbol'],
      assetBalance: json['assetBalance'],
      assetBalanceList: assetRates,
      investedInCrowns: json['investedInCrowns']
    );
  }
}