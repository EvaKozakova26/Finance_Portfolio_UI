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
    return Container(
      height: 250,
      child: Stack(
        children: [
          PieChart(
              PieChartData(
                  sectionsSpace: 3,
                  centerSpaceRadius: 20,
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