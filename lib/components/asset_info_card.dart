import 'package:flutter/material.dart';
import 'package:mystocks_ui/constants/currency.dart';
import 'package:mystocks_ui/constants/style.dart';
import 'package:mystocks_ui/helper/bitcoin_data_helper.dart';
import 'package:mystocks_ui/model/asset_data.dart';
import 'package:mystocks_ui/model/btc_balance.dart';

class AssetInfoCard extends StatelessWidget {
  AssetInfoCard({
    Key? key, required this.info, required this.currency
  }) : super(key: key);

  final AssetData info;
  String currency;

  final BitcoinDataHelper bitcoinDataHelper = new BitcoinDataHelper();


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(10))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Container(
              padding: EdgeInsets.all(defaultPadding * 0.75),
              height: 50,
              width: 200,
              decoration: BoxDecoration(
                  color: Colors.yellow.withOpacity(0.1),
                  borderRadius: const BorderRadius.all(Radius.circular(10))
              ),
              child: Text(
                  info.assetBalance + ' BTC',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: Colors.white),
                  ),
            ),
              Icon(Icons.more_vert, color: Colors.white54)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Bitcoin",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.white),
              ),
              Text(
                getPriceText(info),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.white),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                getAccountBalanceText(info),
                style: accBalanceTheme(context, info),
              ),
              Text(
                getAccBalanceText(info),
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.white),
              )
            ],
          )
        ],
      ),
    );
  }

  TextStyle accBalanceTheme(BuildContext context, AssetData data) =>
      getAccountBalanceText(data).startsWith("-") ?
      Theme.of(context).textTheme.headline6!.apply(color: Colors.redAccent) :
      Theme.of(context).textTheme.headline6!.apply(color: Colors.greenAccent);

  String getAccBalanceText(AssetData data) {
    AssetRate balance = bitcoinDataHelper.filterBalanceByCurrency(data, currency)!;
    if (currency == Currency.USD) {
      return '\$' + balance.accBalance;
    } else {
      return balance.accBalance + " Kč";
    }
  }

  String getPriceText(AssetData data) {
    AssetRate balance = bitcoinDataHelper.filterBalanceByCurrency(data, currency)!;
    if (currency == Currency.USD) {
      return '\$' + balance.price;
    } else {
      return balance.price + " Kč";
    }
  }
  // todo refactor volam nektere metodz nekolikrat
  String getAccountBalanceText(AssetData data) {
    String text = '';
    if (currency == Currency.CZK) {
      num diff = bitcoinDataHelper.getAccBalanceValue(data, currency);
      double percentage = bitcoinDataHelper.getAccBalancePercentage(data, currency);
      return text + diff.round().toString() + " Kč " + "(" + percentage.round().toString() + "%" + ")";
    }
    return text;
  }

}