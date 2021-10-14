
import 'package:flutter/material.dart';
import 'package:mystocks_ui/constants/currency.dart';
import 'package:mystocks_ui/constants/style.dart';
import 'package:mystocks_ui/model/asset_data_list_entity.dart';
import 'package:mystocks_ui/model/transaction_create_entity.dart';

import '../main_api.dart';
import 'asset_info_card.dart';

class MyAssets extends StatefulWidget {
  final String userId;
  Future<AssetDataListEntity>? futureAssets;
  String currency = Currency.CZK;

  MyAssets({Key? key, required this.userId, this.futureAssets}) {
    futureAssets = MainApi().getAssetsData(userId, currency);
  }

  @override
  _MyAssets createState() => _MyAssets(userId: userId, futureAssets: futureAssets!);
}

class _MyAssets extends State<MyAssets> {
  final String userId;
  String currency = Currency.CZK;

  Future<AssetDataListEntity>? futureAssets;

  _MyAssets({required this.userId, required this.futureAssets});


  String accBalanceText = "";

  String formAmountOfBtc = "";
  String formTransactionValueInCrowns = "";
  String formAssetType = "";
  String formCurrency = "";
  DateTime? formTransactionDate;
  TextEditingController? dateField;

  @override
  void initState() {
    super.initState();
    dateField = TextEditingController();
  }

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        formTransactionDate = selectedDate;
        dateField?.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
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
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Stack(
                            children: <Widget>[
                              Positioned(
                                right: -40.0,
                                top: -40.0,
                                child: InkResponse(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: CircleAvatar(
                                    child: Icon(Icons.close),
                                    backgroundColor: Colors.red,
                                  ),
                                ),
                              ),
                              Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          border: UnderlineInputBorder(),
                                          labelText: 'Code',
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Code of share';
                                          }
                                          formAssetType = value;
                                          return null;
                                        },
                                        //initialValue: "btc",
                                        //enabled: false,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          border: UnderlineInputBorder(),
                                          labelText: 'Currency',
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'type currency';
                                          }
                                          formCurrency = value;
                                          return null;
                                        },
                                        //initialValue: "btc",
                                        //enabled: false,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          border: UnderlineInputBorder(),
                                          labelText: 'Shares',
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'enter amount of shares';
                                          }
                                          formAmountOfBtc = value;
                                          return null;
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        controller: dateField,
                                        decoration: InputDecoration(
                                          border: UnderlineInputBorder(),
                                          labelText: 'Select date',
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'enter date';
                                          }
                                          setState(() {
                                            value = selectedDate.toString();
                                          });
                                          return null;
                                        },
                                        onTap: () => _selectDate(context),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          border: UnderlineInputBorder(),
                                          labelText: 'Transaction value',
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'enter transaction value';
                                          }
                                          formTransactionValueInCrowns = value;
                                          return null;
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                        child: Text("Submit"),
                                        onPressed: () {
                                          if (_formKey.currentState!.validate()) {
                                            _formKey.currentState!.save();
                                            TransactionCreateEntity ctce = new TransactionCreateEntity(
                                                assetType: formAssetType,
                                                amount: formAmountOfBtc,
                                                transactionDate: formTransactionDate!,
                                                transactionValue: formTransactionValueInCrowns,
                                                currency: formCurrency);
                                            MainApi().saveTransaction(ctce, userId);

                                            // save form
                                          }
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                },
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
                      itemCount: snapshot.data!.assetData.length,
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