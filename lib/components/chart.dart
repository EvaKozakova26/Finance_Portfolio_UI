import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart({
    Key? key,
    required this.pieChartSelectionData,
  }) : super(key: key);

  final List<PieChartSectionData> pieChartSelectionData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          PieChart(
              PieChartData(
                  sectionsSpace: 0,
                  centerSpaceRadius: 0,
                  sections: pieChartSelectionData
              )
          ),
          Positioned.fill(
              child: Column(
                children: [],
              )
          )
        ],
      ),
    );
  }
}