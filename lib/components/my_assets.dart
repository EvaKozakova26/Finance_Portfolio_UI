
import 'package:flutter/material.dart';
import 'package:mystocks_ui/constants/currency.dart';
import 'package:mystocks_ui/constants/style.dart';
import 'package:mystocks_ui/model/asset_data_list_entity.dart';

import '../crypto_api.dart';
import 'asset_info_card.dart';

class MyAssets extends StatefulWidget {
  final String userId;
  Future<AssetDataListEntity>? futureAssets;
  String currency = Currency.CZK;

  MyAssets({Key? key, required this.userId, this.futureAssets}) {
    futureAssets = CryptoApi().getAssetsData(userId, currency);
  }

  @override
  _MyAssets createState() => _MyAssets(userId: userId, futureAssets: futureAssets!);
}

class _MyAssets extends State<MyAssets> {
  final String userId;
  String currency = Currency.CZK;

  Future<AssetDataListEntity>? futureAssets;

  _MyAssets({required this.userId, required this.futureAssets});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "My assets",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            // currency panel
            Row(
              children: [
                TextButton(
                    child: Text(Currency.CZK),
                    onPressed: () {
                      _refreshData(Currency.CZK);
                    }
                ),
                TextButton(
                    child: Text(Currency.USD),
                    onPressed: () {
                      _refreshData(Currency.USD);
                    }
                ),
              ],
            ),
            // currency panel end
            ElevatedButton.icon(
                style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        horizontal: defaultPadding * 1.5,
                        vertical: defaultPadding
                    )
                ),
                onPressed: () {},
                icon: Icon(Icons.add),
                label: Text("Add new")
            ),
          ],
        ),
        SizedBox(height: defaultPadding),
        FutureBuilder<AssetDataListEntity>(
          future: futureAssets,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GridView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.assetData.length, //todo dynamic count podle poctu assetu?
                      gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: defaultPadding,
                          mainAxisSpacing: defaultPadding,
                          childAspectRatio: 2.0
                      ),
                      itemBuilder: (context, index) => AssetInfoCard(info: snapshot.data!.assetData[index], currency: currency,)
                  )
                ],
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ],
    );
  }

  Future<void> _refreshData(String actCurrency) async {
    setState(() {
      currency = actCurrency;
    });
  }
}