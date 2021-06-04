import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mystocks_ui/components/portfolio_detail_card.dart';
import 'package:mystocks_ui/constants/style.dart';

import 'chart.dart';

class PortfolioDetails extends StatelessWidget {
  const PortfolioDetails({
    Key? key,
    required this.pieChartSelectionData,
  }) : super(key: key);

  final List<PieChartSectionData> pieChartSelectionData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Portfolio details",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: defaultPadding),
            Chart(pieChartSelectionData: pieChartSelectionData),
            PortfolioDetailsInfoCard(
                title: "Bitcoin",
                code: "BTC",
                percentage: 50
            ),
            PortfolioDetailsInfoCard(
                title: "Avast PLC",
                code: "AVST",
                percentage: 25
            ),
            PortfolioDetailsInfoCard(
                title: "Phillip Morris",
                code: "PMI",
                percentage: 25
            )
          ]
      ),
    );
  }
}