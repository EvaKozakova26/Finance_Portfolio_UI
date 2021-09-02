import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mystocks_ui/components/portfolio_detail_card.dart';
import 'package:mystocks_ui/constants/style.dart';
import 'package:mystocks_ui/helper/AssetNameUtils.dart';

import 'chart.dart';

class PortfolioDetails extends StatelessWidget {
  final String userId;

  PortfolioDetails({
    Key? key,
    required this.pieChartSelectionDataHistoric, required this.userId, required this.pieChartSelectionDataCurrent});

  final List<PieChartSectionData> pieChartSelectionDataHistoric;
  final List<PieChartSectionData> pieChartSelectionDataCurrent;

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
          children:
          [
            Text(
              "Portfolio details",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: defaultPadding),
            Text(
              "Historic",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            Chart(pieChartSelectionData: pieChartSelectionDataHistoric),
            Text(
              "Current",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            Chart(pieChartSelectionData: pieChartSelectionDataCurrent),
            for ( var i in createPortfolioDetailData(pieChartSelectionDataHistoric, pieChartSelectionDataCurrent) ) PortfolioDetailsInfoCard(
              title: AssetNameUtils.mapName(i.code),
              code: i.code,
              percentageHistoric: i.historicValue,
              percentageCurrent: i.currentValue,
            )
          ],


      ),
    );
  }

}


class PortfolioDetailData {
  late String code;
  late double historicValue;
  late double currentValue;
}

List<PortfolioDetailData> createPortfolioDetailData(List<PieChartSectionData> historic, List<PieChartSectionData> current) {
  List<PortfolioDetailData> result = [];
  for (var data in historic) {
    PortfolioDetailData portfolioDetailData = PortfolioDetailData();
    portfolioDetailData.code = data.title;

    PieChartSectionData currentData = current.firstWhere((element) => element.title == data.title);
    portfolioDetailData.currentValue = currentData.value;

    portfolioDetailData.historicValue = data.value;

    result.sort((a, b) => b.currentValue.compareTo(a.historicValue));

    result.add(portfolioDetailData);
  }
  return result;
}





