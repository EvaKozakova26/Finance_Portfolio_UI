import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mystocks_ui/constants/style.dart';
import 'package:mystocks_ui/helper/color_utils.dart';
import 'package:mystocks_ui/model/portfolio_detail.dart';
import 'package:mystocks_ui/model/portfolio_detail_list_entity.dart';

import 'components/header.dart';
import 'components/my_assets.dart';
import 'components/portfolio_details.dart';
import 'components/recent_transactions.dart';
import 'crypto_api.dart';

class DashboardScreen extends StatefulWidget {
  final String userId;
  Future<PortfolioDetailListEntity>? futureDetails;


  DashboardScreen({Key? key, required this.userId}) {
    futureDetails = CryptoApi().getPortfolioDetail(userId);
  }

  @override
  _DashboardScreen createState() => _DashboardScreen(userId: userId, futureDetails: futureDetails);
}


class _DashboardScreen extends State<DashboardScreen> {
  final String userId;

  _DashboardScreen({required this.userId, required this.futureDetails});

  Future<PortfolioDetailListEntity>? futureDetails;

  @override
  Widget build(BuildContext context) {
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
                        //RecentTransactions(userId: userId)
                      ],
                    )
                  ),
                  SizedBox(width: defaultPadding),
                  FutureBuilder<PortfolioDetailListEntity>(
                    future: futureDetails,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Expanded(
                          flex: 2,
                          child: PortfolioDetails(
                            pieChartSelectionDataHistoric: createPieChartDataHistoric(snapshot.data!.portfolioDetails),
                            userId: userId,
                            pieChartSelectionDataCurrent: createPieChartDataCurrent(snapshot.data!.portfolioDetails),),
                        );
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      // By default, show a loading spinner.
                      return CircularProgressIndicator();
                    },
                  ),
                ],
              )
            ],
          ),
        )
    );
  }

  createPieChartDataHistoric(List<PortfolioDetail> details) {
    List<PieChartSectionData> pieChartSectionData = [];

    for (PortfolioDetail detail in details) {
      PieChartSectionData data = PieChartSectionData(
        color: ColorUtils.mapColor(detail.symbol)!.withOpacity(0.8),
        value: double.parse(detail.sharePercentageHistoric),
        title: detail.symbol,
        radius: 100,
      );
      pieChartSectionData.add(data);
    }
    return pieChartSectionData;
  }

  createPieChartDataCurrent(List<PortfolioDetail> details) {
    List<PieChartSectionData> pieChartSectionData = [];

    for (PortfolioDetail detail in details) {
      PieChartSectionData data = PieChartSectionData(
        color: ColorUtils.mapColor(detail.symbol)!.withOpacity(0.8),
        value: double.parse(detail.sharePercentageCurrent),
        title: detail.symbol,
        radius: 100,
      );
      pieChartSectionData.add(data);
    }
    return pieChartSectionData;
  }
}