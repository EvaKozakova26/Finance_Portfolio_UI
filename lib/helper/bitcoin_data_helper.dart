import 'package:mystocks_ui/constants/currency.dart';
import 'package:mystocks_ui/model/bitcoin_info.dart';
import 'package:mystocks_ui/model/btc_balance.dart';

class BitcoinDataHelper {

  num getAccBalanceValue(BitcoinInfo data, String currency) {
    BtcBalance balance = filterBalanceByCurrency(data, currency)!;
    num accBalance = num.parse(balance.accBalance);
    num investedBalance = num.parse(data.investedInCrowns);
    num diff = accBalance - investedBalance;
    return diff;
  }

  double getAccBalancePercentage(BitcoinInfo data, String currency) {
    BtcBalance balance = filterBalanceByCurrency(data, currency)!;
    num accBalance = num.parse(balance.accBalance);
    num investedBalance = num.parse(data.investedInCrowns);
    double percentage = accBalance * 100 / investedBalance;
    return percentage - 100;
  }

  BtcBalance? filterBalanceByCurrency(BitcoinInfo data, String currency) {
    return data.btcRates.firstWhere((element) => element.currency == currency,
        orElse: () => new BtcBalance(currency: Currency.USD, price: "0", accBalance: "0"));
  }

}