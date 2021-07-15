import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:share_it/app_module.dart';
import 'package:share_it/blocs/employee_bloc.dart';
import 'package:share_it/components/custom_circular_progress_indicator.dart';
import 'package:share_it/components/style.dart';
import 'package:share_it/screens/info/bloc/info_bloc.dart';
import 'package:share_it/screens/info/components/indicator_widget.dart';
import 'package:share_it/screens/info/components/pie_data.dart';
import 'package:share_it/screens/info/info_module.dart';

class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {

  var infoBloc = AppModule.to.getBloc<InfoBloc>();
  var employeeBloc = AppModule.to.getBloc<EmployeeBloc>();
  @override
  void initState() {
    super.initState();
    infoBloc.syncCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            LayoutBuilder(
              builder:(context, constraint) => Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(120.0),
                ),
                child: Container(
                    height: 220,
                    width: 220,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle
                    ),
                    child:  FutureBuilder(
                      future: infoBloc.getAllList(employeeBloc.user),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return Center(
                              child: CustomCircularProgressIndicator(),
                            );
                          default:
                        }
                        return PieChart(
                          PieChartData(
                              borderData: FlBorderData(show: false),
                              sectionsSpace: 1,
                              centerSpaceRadius: 55,
                              sections: [
                                PieChartSectionData(
                                  color: Colors.blue,
                                  value: infoBloc.internetProblems.length.toDouble(),
                                  title: '${infoBloc.internetProblems.length}',
                                  titleStyle: subtitleProfileHeader,
                                ),
                                PieChartSectionData(
                                  color: Colors.blueAccent,
                                  value: infoBloc.reports.length.toDouble(),
                                  title: '${infoBloc.reports.length}',
                                  titleStyle: subtitleProfileHeader,
                                ),
                                PieChartSectionData(
                                  color: Colors.deepPurple,
                                  value: infoBloc.others.length.toDouble(),
                                  title: '${infoBloc.others.length}',
                                  titleStyle: subtitleProfileHeader,
                                ),
                                PieChartSectionData(
                                  color: Colors.purple,
                                  value: infoBloc.phoneProblems.length.toDouble(),
                                  title: '${infoBloc.phoneProblems.length}',
                                  titleStyle: subtitleProfileHeader,
                                ),
                                PieChartSectionData(
                                  color: Colors.deepOrange,
                                  value: infoBloc.softwareIssues.length.toDouble(),
                                  title: '${infoBloc.softwareIssues.length}',
                                  titleStyle: subtitleProfileHeader,
                                ),
                                PieChartSectionData(
                                  color: Colors.red,
                                  value: infoBloc.equipmentsIssues.length.toDouble(),
                                  title: '${infoBloc.equipmentsIssues.length}',
                                  titleStyle: subtitleProfileHeader,
                                ),
                                PieChartSectionData(
                                  color: Colors.yellow,
                                  value: infoBloc.login.length.toDouble(),
                                  title: '${infoBloc.login.length}',
                                  titleStyle: subtitleProfileHeader,
                                ),
                                PieChartSectionData(
                                  color: Colors.green,
                                  value: infoBloc.installEquipment.length.toDouble(),
                                  title: '${infoBloc.installEquipment.length}',
                                  titleStyle: subtitleProfileHeader,
                                ),
                                PieChartSectionData(
                                  color: Colors.black,
                                  value: infoBloc.softwareInstall.length.toDouble(),
                                  title: '${infoBloc.softwareInstall.length}',
                                  titleStyle: subtitleProfileHeader,
                                ),
                              ]
                          ),
                        );
                      },
                    ),
                  ),
              ),
            ),
            IndicatorWidget(categories: infoBloc.categories,)
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
