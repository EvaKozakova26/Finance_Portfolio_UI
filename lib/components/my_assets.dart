
import 'package:flutter/material.dart';
import 'package:mystocks_ui/constants/currency.dart';
import 'package:mystocks_ui/constants/style.dart';
import 'package:mystocks_ui/model/MyAssets.dart';
import 'package:mystocks_ui/model/bitcoin_info.dart';

import '../crypto_api.dart';
import 'asset_info_card.dart';

class MyAssets extends StatefulWidget {
  final String userId;

  MyAssets({Key? key, required this.userId}) : super(key: key);

  @override
  _MyAssets createState() => _MyAssets(userId: userId);
}

class _MyAssets extends State<MyAssets> {
  final String userId;
  String currency = Currency.CZK;

  Future<BitcoinInfo>? futureBtc;

  _MyAssets({required this.userId});

  @override
  void initState() {
    super.initState();
    futureBtc = CryptoApi().getBtcPrice(userId, currency);
  }

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
        FutureBuilder<BitcoinInfo>(
          future: futureBtc,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GridView.builder(
                      shrinkWrap: true,
                      itemCount: 6, //todo dynamic count podle poctu assetu?
                      gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: defaultPadding,
                          mainAxisSpacing: defaultPadding,
                          childAspectRatio: 2.0
                      ),
                      itemBuilder: (context, index) => AssetInfoCard(info: snapshot.data!, currency: currency,)
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