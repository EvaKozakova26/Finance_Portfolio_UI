/*
import 'package:flutter/material.dart';
import 'package:mystocks_ui/transaction_list.dart';

import 'constants/currency.dart';
import 'main_api.dart';
import 'helper/bitcoin_data_helper.dart';
import 'model/bitcoin_info.dart';
import 'model/btc_balance.dart';
import 'model/transaction_create_entity.dart';

class MyHomePage extends StatefulWidget {
  final String userId;

  MyHomePage({Key? key, required this.title, required this.userId}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState(userId: userId);
}

class _MyHomePageState extends State<MyHomePage> {
  Future<BitcoinInfo>? futureBtc;
  String userId;
  String currency = Currency.CZK;
  String accBalanceText = "";

  String formAmountOfBtc = "";
  String formTransactionValueInCrowns = "";
  String formAssetType = "";
  DateTime? formTransactionDate;
  TextEditingController? dateField;


  final BitcoinDataHelper bitcoinDataHelper = new BitcoinDataHelper();

  _MyHomePageState({required this.userId});

  @override
  void initState() {
    super.initState();
    dateField = TextEditingController();
    futureBtc = CryptoApi().getAssetData(userId, currency);
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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextButton(
                child: Text(Currency.CZK),
                onPressed: () {
                  _refreshData(Currency.CZK);
                },
                style: TextButton.styleFrom(
                    primary: Colors.blueGrey,
                    backgroundColor: Colors.white70,
                    textStyle: TextStyle(fontSize: 20)),
              ),
              TextButton(
                child: Text(Currency.USD),
                onPressed: () {
                  _refreshData(Currency.USD);
                },
                style: TextButton.styleFrom(
                    primary: Colors.blueGrey,
                    backgroundColor: Colors.white70,
                    textStyle: TextStyle(fontSize: 20)),
              )
            ],
          )
        ],
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.

        child: FutureBuilder<BitcoinInfo>(
          future: futureBtc,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                // Column is also a layout widget. It takes a list of children and
                // arranges them vertically. By default, it sizes itself to fit its
                // children horizontally, and tries to be as tall as its parent.
                //
                // Invoke "debug painting" (press "p" in the console, choose the
                // "Toggle Debug Paint" action from the Flutter Inspector in Android
                // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
                // to see the wireframe for each widget.
                //
                // Column has various properties to control how it sizes itself and
                // how it positions its children. Here we use mainAxisAlignment to
                // center the children vertically; the main axis here is the vertical
                // axis because Columns are vertical (the cross axis would be
                // horizontal).
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'My BTC balance: ',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(
                    snapshot.data!.btcBalance + ' BTC',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Text(
                    'My account balance:',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(
                    getAccountBalanceText(snapshot.data!),
                    style: accBalanceTheme(context, snapshot.data!),
                  ),
                  Text(
                    getAccBalanceText(snapshot.data!),
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Text(
                    'Current price of bitcoin: ',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(
                    getPriceText(snapshot.data!),
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TransactionList(userId: userId,)),
                        );
                      },
                      child: Text('List of all transactions'),
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          child: Text(
            "Powered by CoinDesk",
            textAlign: TextAlign.center,
          ),
          color: Colors.blueGrey),
      floatingActionButton: FloatingActionButton(
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
                                  labelText: 'Type',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Type';
                                  }
                                  formAssetType = value;
                                  return null;
                                },
                                initialValue: "btc",
                                enabled: false,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'enter amount of btc',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'enter amount of btc';
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
                                  labelText: 'select date',
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
                                  labelText: 'enter transaction value in crowns',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'enter transaction value in crowns';
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
                                        transactionValue: formTransactionValueInCrowns);
                                    CryptoApi().saveTransaction(ctce, userId);

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
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<void> _refreshData(String actCurrency) async {
    setState(() {
      currency = actCurrency;
    });
  }

  //todo ziskat data nejak jednoduseji, at nemusim volat 2x stejnou metodu
  TextStyle accBalanceTheme(BuildContext context, BitcoinInfo data) =>
      getAccountBalanceText(data).startsWith("-") ?
      Theme.of(context).textTheme.headline4!.apply(color: Colors.redAccent) :
      Theme.of(context).textTheme.headline4!.apply(color: Colors.greenAccent);

  String getAccBalanceText(BitcoinInfo data) {
    AssetRate balance = bitcoinDataHelper.filterBalanceByCurrency(data, currency)!;
    if (currency == Currency.USD) {
      return '\$' + balance.accBalance;
    } else {
      return balance.accBalance + " Kč";
    }
  }

  String getPriceText(BitcoinInfo data) {
    AssetRate balance = bitcoinDataHelper.filterBalanceByCurrency(data, currency)!;
    if (currency == Currency.USD) {
      return '\$' + balance.price;
    } else {
      return balance.price + " Kč";
    }
  }
  // todo refactor volam nektere metodz nekolikrat
  String getAccountBalanceText(BitcoinInfo data) {
    String text = '';
    if (currency == Currency.CZK) {
      num diff = bitcoinDataHelper.getAccBalanceValue(data, currency);
      double percentage = bitcoinDataHelper.getAccBalancePercentage(data, currency);
      return text + diff.round().toString() + " Kč " + "(" + percentage.round().toString() + "%" + ")";
    }
    accBalanceText = text;
    return text;
  }
}
*/
