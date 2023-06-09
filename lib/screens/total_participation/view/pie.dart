import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class Pie extends StatelessWidget {
  final int completedPayoutPercentage;

  const Pie({super.key, required this.completedPayoutPercentage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: PieChart(
        dataMap: {
          "지급예정 금액": completedPayoutPercentage.toDouble(),
          "지급완료 금액": (100 - completedPayoutPercentage.toDouble()),
        },
        chartType: ChartType.ring,
        colorList: const [
          Color(0xFF0335B4),
          Color(0xFFDBE5FE),
        ],
        chartRadius: MediaQuery
            .of(context)
            .size
            .width / 2.7,
        ringStrokeWidth: 40,
        initialAngleInDegree: -90,
        animationDuration: const Duration(seconds: 2),
        chartValuesOptions: const ChartValuesOptions(
            chartValueBackgroundColor: Colors.white,
            showChartValuesInPercentage: true,
            showChartValuesOutside: true),
        legendOptions: const LegendOptions(showLegends: false),
      ),
    );
  }
}