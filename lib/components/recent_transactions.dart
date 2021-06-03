import 'package:flutter/material.dart';
import 'package:mystocks_ui/constants/style.dart';
import 'package:mystocks_ui/model/Transactions.dart';

class RecentTransactions extends StatelessWidget {

  const RecentTransactions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius:
          const BorderRadius.all(Radius.circular(10))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent transactions",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            width: double.infinity,
            child: DataTable(
              horizontalMargin: 0,
              columnSpacing: defaultPadding,
              columns: [
                DataColumn(
                    label: Text("Asset")
                ),
                DataColumn(
                    label: Text("Date")
                ),
                DataColumn(
                    label: Text("Transaction value")
                ),
                DataColumn(
                    label: Text("Market price")
                ),
                DataColumn(
                    label: Text("Amount")
                )
              ],
              rows: List.generate(
                  mockRecentTransactions.length,
                      (index) => recentTransactionsDataRow(mockRecentTransactions[index])),
            ),
          )
        ],
      ),
    );
  }

  DataRow recentTransactionsDataRow(RecentTransaction recentTransaction) {
    return DataRow(cells: [
      DataCell(Text(recentTransaction.title!)),
      DataCell(Text(recentTransaction.date!)),
      DataCell(Text(recentTransaction.transactionValue!)),
      DataCell(Text(recentTransaction.marketPrice!)),
      DataCell(Text(recentTransaction.amount!)),
    ]);
  }
}