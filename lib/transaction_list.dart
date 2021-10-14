import 'package:flutter/material.dart';
import 'package:mystocks_ui/main_api.dart';
import 'package:mystocks_ui/model/transaction_list_entity.dart';

import 'constants/style.dart';
import 'model/transaction.dart';
import 'model/transaction_create_entity.dart';

class TransactionList extends StatefulWidget {
  final String userId;
  Future<TransactionListEntity>? futureTransactions;

  TransactionList({required this.userId, this.futureTransactions}) {
    futureTransactions = MainApi().getAllTransactions(userId);
  }

  @override
  _TransactionListState createState() => _TransactionListState(userId: userId, futureTransactions: futureTransactions!);

}

class _TransactionListState extends State<TransactionList> {
  String userId;
  Future<TransactionListEntity> futureTransactions;

  String formAmountOfBtc = "";
  String formTransactionValueInCrowns = "";
  String formAssetType = "";
  String formCurrency = "";
  DateTime? formTransactionDate;
  TextEditingController? dateField = TextEditingController();
  DateTime selectedDate = DateTime.now();

  _TransactionListState({required this.userId, required this.futureTransactions});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Transaction List"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          FutureBuilder<TransactionListEntity>(
            future: futureTransactions,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return PaginatedDataTable(
                  header: Text('List of all transactions'),
                  rowsPerPage: 5,
                  columns: [
                    DataColumn(label: Text('Asset')),
                    DataColumn(label: Text('Code')),
                    DataColumn(label: Text('Date')),
                    DataColumn(label: Text('Transaction value')),
                    DataColumn(label: Text('Market Price')),
                    DataColumn(label: Text('Amount')),
                  ],
                  actions: [
                    Row(
                      children: [
                        Text(
                          'Average buy price: ',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        Text(
                          '\$' + snapshot.data!.averageTransactionValueInDollars.round().toString() + " / " + snapshot.data!.averageTransactionValueInCrowns.round().toString() + " Kč",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    )
                  ],
                  source: _DataSource(context, userId, snapshot.data!.transactions),
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
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
          )

        ],
      ),
    );
  }

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

}

class _DataSource extends DataTableSource {
  _DataSource(this.context, this.userId, this.transactions) {
    _rows = transactions;
  }

  final BuildContext context;
  final String userId;
  final List<TransactionDto> transactions;
  List<TransactionDto> _rows = [];

  int _selectedCount = 0;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _rows.length) return DataRow(cells: []);
    final row = _rows[index];
    return DataRow.byIndex(
      index: index,
      selected: row.selected,
      onSelectChanged: (value) {
        if (row.selected != value) {
          _selectedCount += value! ? 1 : -1;
          assert(_selectedCount >= 0);
          row.selected = value;
          notifyListeners();
        }
      },
      cells: [
        DataCell(Text(row.type)),
        DataCell(Text(row.code)),
        DataCell(Text(row.date)),
        DataCell(Text(row.buySellValue + " Kč" + " / " + '\$' + row.buySellValueInDollars)),
        DataCell(Text(row.stockPriceInCrowns + " Kč" + " / " + '\$' + row.stockPriceInDollars)),
        DataCell(Text(row.amountBtc)),
      ],
    );
  }

  @override
  int get rowCount => _rows.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

}