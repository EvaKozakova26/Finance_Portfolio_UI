import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:mystocks_ui/constants/api.dart';
import 'package:mystocks_ui/model/asset_data_list_entity.dart';
import 'package:mystocks_ui/model/transaction_create_entity.dart';
import 'package:mystocks_ui/model/transaction_list_entity.dart';
import 'package:mystocks_ui/model/portfolio_detail_list_entity.dart';

import 'model/bitcoin_info.dart';

class CryptoApi {

  Logger logger = Logger("CryptoApi");

  Future<AssetDataListEntity> getAssetsData(String userId, String currency) async {
    logger.fine("getAssetsData has started");
    final response = await http.get(Uri.https(Api.URL, 'assets/$userId'));
    logger.fine("getAssetsData has finished with code: " + response.statusCode.toString());
    return AssetDataListEntity.fromJson(jsonDecode(response.body));
  }

  Future<TransactionListEntity> getAllTransactions(String userId) async {
    logger.fine("getAllTransactions has started");
    final response = await http.get(Uri.https(Api.URL, 'all/$userId'));
    logger.fine("getAllTransactions has finished with code: " + response.statusCode.toString());
    return TransactionListEntity.fromJson(jsonDecode(response.body));
  }

  Future<TransactionCreateEntity> saveTransaction(TransactionCreateEntity ctce, String userId) async {
    logger.fine("saveTransaction has started");
    final response = await http.post(
        Uri.https(Api.URL, 'crypto/create/$userId'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(ctce.toJson()));
    logger.fine("saveTransaction has finished with code: " + response.statusCode.toString());
    return TransactionCreateEntity.fromJson(jsonDecode(response.body));
  }

  Future<PortfolioDetailListEntity> getPortfolioDetail(String userId) async {
    logger.fine("getPortfolioDetail has started");
    final response = await http.get(Uri.https(Api.URL, 'detail/$userId'));
    logger.fine("getPortfolioDetail has finished with code: " + response.statusCode.toString());
    return PortfolioDetailListEntity.fromJson(jsonDecode(response.body));
  }



}