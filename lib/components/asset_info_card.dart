import 'package:flutter/material.dart';
import 'package:mystocks_ui/constants/currency.dart';
import 'package:mystocks_ui/constants/style.dart';
import 'package:mystocks_ui/helper/AssetNameUtils.dart';
import 'package:mystocks_ui/helper/bitcoin_data_helper.dart';
import 'package:mystocks_ui/helper/color_utils.dart';
import 'package:mystocks_ui/model/asset_data.dart';
import 'package:mystocks_ui/model/btc_balance.dart';

class AssetInfoCard extends StatelessWidget {
  AssetInfoCard({
    Key? key, required this.info, required this.currency
  }) : super(key: key);

  final AssetData info;
  String currency;

  final AssetDataHelper assetDataHelper = new AssetDataHelper();

  // TODO dodelat symbol currnecy

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
          color: ColorUtils.mapColor(info.symbol)!.withOpacity(0.3),
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
              width: 150,
              decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: const BorderRadius.all(Radius.circular(10))
              ),
              child: Text(
                  info.assetBalance,
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
                AssetNameUtils.mapName(info.symbol)!,
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
              Container(
                padding: EdgeInsets.all(defaultPadding * 0.75),
                height: 50,
                width: 150,
                decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: const BorderRadius.all(Radius.circular(10))
                ),
                child:  Text(
                  getAccountBalanceText(info),
                  style: accBalanceTheme(context, info),
                ),
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
      Theme.of(context).textTheme.headline6!.apply(color: Colors.greenAccent[700]);

  String getAccBalanceText(AssetData data) {
    AssetRate balance = assetDataHelper.filterBalanceByCurrency(data, currency)!;
    return balance.accBalance;
    if (currency == Currency.USD) {
      return '\$' + balance.accBalance;
    } else {
      return balance.accBalance + " Kč";
    }
  }

  String getPriceText(AssetData data) {
    AssetRate balance = assetDataHelper.filterBalanceByCurrency(data, currency)!;
    return balance.price;
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
      num diff = assetDataHelper.getAccBalanceValue(data, currency);
      double percentage = assetDataHelper.getAccBalancePercentage(data, currency);
      return text + diff.round().toString() + "(" + percentage.toStringAsPrecision(2) + "%" + ")";
    }
    return text;
  }

}