import 'package:mystocks_ui/constants/currency.dart';
import 'package:mystocks_ui/model/asset_data.dart';
import 'package:mystocks_ui/model/btc_balance.dart';

class AssetDataHelper {

  num getAccBalanceValue(AssetData data, String currency) {
    AssetRate balance = filterBalanceByCurrency(data, currency)!;
    num accBalance = num.parse(balance.accBalance);
    num investedBalance = num.parse(data.investedInCrowns);
    num diff = accBalance - investedBalance;
    return diff;
  }

  double getAccBalancePercentage(AssetData data, String currency) {
    AssetRate balance = filterBalanceByCurrency(data, currency)!;
    num accBalance = num.parse(balance.accBalance);
    num investedBalance = num.parse(data.investedInCrowns);
    double percentage = accBalance * 100 / investedBalance;
    return percentage - 100;
  }

  AssetRate? filterBalanceByCurrency(AssetData data, String currency) {
    return data.assetBalanceList.firstWhere((element) => element.currency == currency,
        orElse: () => data.assetBalanceList[0]);
  }

}