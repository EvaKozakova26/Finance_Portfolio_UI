import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:mystocks_ui/constants/currency.dart';
import 'package:mystocks_ui/model/btc_balance.dart';
import 'package:mystocks_ui/transaction_list.dart';
import 'package:mystocks_ui/user_form.dart';
import 'model/bitcoin_info.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BTC',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.amber,
      ),
      home: UserForm(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String userId;

  MyHomePage({Key key, this.title, @required this.userId}) : super(key: key);

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

Future<BitcoinInfo> fetch(String userId, String currency) async {
  // todo konfiguračně...
  // localhost:8080  - jen http
  // sheltered-eyrie-96229.herokuapp.com
  final response = await http.get(Uri.https('sheltered-eyrie-96229.herokuapp.com', 'btc/$userId'));
  return BitcoinInfo.fromJson(jsonDecode(response.body));
}

class _MyHomePageState extends State<MyHomePage> {
  Future<BitcoinInfo> futureBtc;
  String userId;
  String currency = Currency.CZK;
  String accBalanceText = "";

  String formAmountOfBtc;

  _MyHomePageState({@required this.userId});

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
    });
  }

  @override
  void initState() {
    super.initState();
    futureBtc = fetch(userId, currency);
  }

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
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
                    snapshot.data.btcBalance + ' BTC',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Text(
                    'My account balance:',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(
                    getAccountBalanceText(snapshot.data),
                    style: accBalanceTheme(context, snapshot.data),
                  ),
                  Text(
                    getAccBalance(snapshot.data),
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Text(
                    'Current price of bitcoin: ',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(
                    getPrice(snapshot.data),
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
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'select date',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'enter date';
                                  }
                                  formAmountOfBtc = value;
                                  setState(() {
                                    value = selectedDate.toString();
                                  });
                                  return null;
                                },
                                initialValue: "${selectedDate.toLocal()}".split(' ')[0],
                                onTap: () => _selectDate(context),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                child: Text("Submit"),
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    //_formKey.currentState.save();

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

  //todo ziskat data nejak jednoduseji, at nemusim volat 2x stejnou metodu
  TextStyle accBalanceTheme(BuildContext context, BitcoinInfo data) =>
      getAccountBalanceText(data).startsWith("-") ?
      Theme.of(context).textTheme.headline4.apply(color: Colors.redAccent) :
      Theme.of(context).textTheme.headline4.apply(color: Colors.greenAccent);

  Future<void> _refreshData(String actCurrency) async {
    setState(() {
      currency = actCurrency;
    });
  }

  String getAccBalance(BitcoinInfo data) {
    BtcBalance balance = filterBalance(data);
    if (currency == Currency.USD) {
      return '\$' + balance.accBalance;
    } else {
      return balance.accBalance + " Kč";
    }
  }

  String getPrice(BitcoinInfo data) {
    BtcBalance balance = filterBalance(data);
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
      double diff = getAccBalanceValue(data);
      double percentage = getAccBalancePercentage(data);
      return text + diff.round().toString() + " Kč " + "(" + percentage.round().toString() + "%" + ")";
    }
    accBalanceText = text;
    return text;
  }

  double getAccBalanceValue(BitcoinInfo data) {
    BtcBalance balance = filterBalance(data);
    num accBalance = num.parse(balance.accBalance);
    num investedBalance = num.parse(data.investedInCrowns);
    double diff = accBalance - investedBalance;
    return diff;
  }

  double getAccBalancePercentage(BitcoinInfo data) {
    BtcBalance balance = filterBalance(data);
    num accBalance = num.parse(balance.accBalance);
    num investedBalance = num.parse(data.investedInCrowns);
    double percentage = accBalance * 100 / investedBalance;
    return percentage > 100 ? percentage - 100 : 100 - percentage;
  }

  BtcBalance filterBalance(BitcoinInfo data) {
    return data?.btcRates?.firstWhere((element) => element.currency == currency,
        orElse: () => new BtcBalance(currency: Currency.USD, price: "0", accBalance: "0"));
  }
}
