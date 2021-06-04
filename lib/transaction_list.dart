import 'package:flutter/material.dart';
import 'package:mystocks_ui/crypto_api.dart';
import 'package:mystocks_ui/model/crypto_transaction_list_entity.dart';

import 'model/crypto_transaction.dart';

class TransactionList extends StatefulWidget {
  final String userId;
  Future<CryptoTransactionListEntity>? futureTransactions;

  TransactionList({required this.userId, this.futureTransactions}) {
    futureTransactions = CryptoApi().getAllTransactions(userId);
  }

  @override
  _TransactionListState createState() => _TransactionListState(userId: userId, futureTransactions: futureTransactions!);

}

class _TransactionListState extends State<TransactionList> {
  String userId;
  Future<CryptoTransactionListEntity> futureTransactions;

  _TransactionListState({required this.userId, required this.futureTransactions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transaction List"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          FutureBuilder<CryptoTransactionListEntity>(
            future: futureTransactions,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return PaginatedDataTable(
                  header: Text('List of all transactions'),
                  rowsPerPage: 5,
                  columns: [
                    DataColumn(label: Text('Asset')),
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
        ],
      ),
    );
  }

}

class _DataSource extends DataTableSource {
  _DataSource(this.context, this.userId, this.transactions) {
    _rows = transactions;
  }

  final BuildContext context;
  final String userId;
  final List<CryptoTransactionDto> transactions;
  List<CryptoTransactionDto> _rows = [];

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