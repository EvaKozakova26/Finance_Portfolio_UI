import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mystocks_ui/app.dart';

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
        primarySwatch: Colors.blue,
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

class BitcoinInfo {
  final String priceInDollars;
  final String btcBalance;
  final String accBalance;

  BitcoinInfo({@required this.priceInDollars, @required this.btcBalance, @required this.accBalance});

  factory BitcoinInfo.fromJson(Map<String, dynamic> json) {
    return BitcoinInfo(
     priceInDollars: json['priceInDollars'],
     btcBalance: json['btcBalance'],
     accBalance: json['accBalance'],
    );
  }
}

Future<BitcoinInfo> fetch(String userId) async {
  final response = await http.get(Uri.https('sheltered-eyrie-96229.herokuapp.com', 'btc/$userId'));
  return BitcoinInfo.fromJson(jsonDecode(response.body));
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Future<BitcoinInfo> futureBtc;
  String userId;

  _MyHomePageState({@required this.userId});
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    futureBtc = fetch(userId);
  }

  @override
  Widget build(BuildContext context) {
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
                    'My account balance: ',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(
                    '\$' + snapshot.data.accBalance,
                    style: Theme.of(context).textTheme.headline2,
                  ),

                  Text(
                    'Current price of bitcoin: ',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(
                    '\$' + snapshot.data.priceInDollars,
                    style: Theme.of(context).textTheme.headline2,
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
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
