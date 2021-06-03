import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:mystocks_ui/constants/api.dart';
import 'package:mystocks_ui/model/crypto_transaction_create_entity.dart';
import 'package:mystocks_ui/model/crypto_transaction_list_entity.dart';

import 'model/bitcoin_info.dart';

class CryptoApi {

  Logger logger = Logger("CryptoApi");

  Future<BitcoinInfo> getBtcPrice(String userId, String currency) async {
    logger.fine("getBtcPrice has started");
    final response = await http.get(Uri.https(Api.URL, 'btc/$userId'));
    logger.fine("getBtcPrice has finished with code: " + response.statusCode.toString());
    return BitcoinInfo.fromJson(jsonDecode(response.body));
  }

  Future<CryptoTransactionListEntity> getAllTransactions(String userId) async {
    logger.fine("getAllTransactions has started");
    final response = await http.get(Uri.https(Api.URL, 'all/$userId'));
    logger.fine("getAllTransactions has finished with code: " + response.statusCode.toString());
    return CryptoTransactionListEntity.fromJson(jsonDecode(response.body));
  }

  Future<CryptoTransactionCreateEntity> saveCryptoTransaction(CryptoTransactionCreateEntity ctce, String userId) async {
    logger.fine("saveCryptoTransaction has started");
    final response = await http.post(
        Uri.https(Api.URL, 'crypto/create/$userId'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(ctce.toJson()));
    logger.fine("saveCryptoTransaction has finished with code: " + response.statusCode.toString());
    return CryptoTransactionCreateEntity.fromJson(jsonDecode(response.body));
  }



}