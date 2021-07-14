import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:share_it/screens/info/components/indicator_widget.dart';
import 'package:share_it/screens/info/components/pie_data.dart';

class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Container(
              height: 200,
              child: PieChart(
                PieChartData(
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 1,
                  centerSpaceRadius: 55,
                  sections: getSections()
                ),
              ),
            ),
            IndicatorWidget()
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> getSections() => PieData().data.asMap().map<int, PieChartSectionData>((index, data) {
    final value = PieChartSectionData(
      color: data.color,
      value: data.percent,
      title: "${data.percent}",
      titleStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
      )
    );
    return MapEntry(index, value);
  }).values.toList();


}
