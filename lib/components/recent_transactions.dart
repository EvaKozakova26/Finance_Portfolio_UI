import 'package:flutter/material.dart';
import 'package:mystocks_ui/constants/style.dart';
import 'package:mystocks_ui/model/transaction.dart';
import 'package:mystocks_ui/model/transaction_list_entity.dart';

import '../main_api.dart';

class RecentTransactions extends StatefulWidget {
  final String userId;
  Future<TransactionListEntity>? futureTransactions;

  RecentTransactions({required this.userId, this.futureTransactions}) {
    futureTransactions = MainApi().getAllTransactions(userId);
  }

  @override
  _RecentTransactionListState createState() => _RecentTransactionListState(
      userId: userId, futureTransactions: futureTransactions!);
}

class _RecentTransactionListState extends State<RecentTransactions> {
  String userId;
  Future<TransactionListEntity> futureTransactions;

  _RecentTransactionListState(
      {required this.userId, required this.futureTransactions});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent transactions",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          FutureBuilder<TransactionListEntity>(
            future: futureTransactions,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SizedBox(
                    width: double.infinity,
                    child: DataTable(
                      horizontalMargin: 0,
                      columnSpacing: defaultPadding,
                      columns: [
                        DataColumn(label: Text("Asset")),
                        DataColumn(label: Text("Date")),
                        DataColumn(label: Text("Transaction value")),
                        DataColumn(label: Text("Market price")),
                        DataColumn(label: Text("Amount"))
                      ],
                      rows: List.generate(
                        snapshot.data!.transactions.length,
                        (index) => recentTransactionsDataRow(
                            snapshot.data!.transactions[index]),
                      ),
                    ));
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

  DataRow recentTransactionsDataRow(TransactionDto recentTransaction) {
    return DataRow(cells: [
      DataCell(Text(recentTransaction.type)),
      DataCell(Text(recentTransaction.date)),
      DataCell(Text(recentTransaction.buySellValue +
          " Kč" +
          " / " +
          '\$' +
          recentTransaction.buySellValueInDollars)),
      DataCell(Text(recentTransaction.stockPriceInCrowns +
          " Kč" +
          " / " +
          '\$' +
          recentTransaction.stockPriceInDollars)),
      DataCell(Text(recentTransaction.amountBtc)),
    ]);
  }
}