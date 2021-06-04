import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mystocks_ui/constants/style.dart';

import 'components/header.dart';
import 'components/my_assets.dart';
import 'components/portfolio_details.dart';
import 'components/recent_transactions.dart';

class DashboardScreen extends StatefulWidget {
  final String userId;

  DashboardScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _DashboardScreen createState() => _DashboardScreen(userId: userId);
}


class _DashboardScreen extends State<DashboardScreen> {
  final String userId;

  _DashboardScreen({required this.userId});


  @override
  Widget build(BuildContext context) {
    List<PieChartSectionData> pieChartSelectionData = [
      PieChartSectionData(
          color: Colors.yellow,
          value: 50,
          title: "BTC",
          radius: 100,
      ),
      PieChartSectionData(
          color: Colors.orange,
          value: 25,
          title: "AVST",
          radius: 100,
      ),
      PieChartSectionData(
          color: Colors.blueGrey,
          value: 25,
          title: "PMI",
          radius: 100,
      ),
    ];

    return SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Header(userId: userId),
              SizedBox(height: defaultPadding),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        MyAssets(userId: userId,),
                        SizedBox(height: defaultPadding),
                        RecentTransactions(userId: userId)
                      ],
                    )
                  ),
                  SizedBox(width: defaultPadding),
                  Expanded(
                    flex: 2,
                    child: PortfolioDetails(pieChartSelectionData: pieChartSelectionData),
                  )
                ],
              )
            ],
          ),
        )
    );
  }
}