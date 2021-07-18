import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:share_it/app_module.dart';
import 'package:share_it/blocs/employee_bloc.dart';
import 'package:share_it/components/custom_circular_progress_indicator.dart';
import 'package:share_it/components/style.dart';
import 'package:share_it/screens/info/bloc/info_bloc.dart';
import 'package:share_it/screens/info/components/indicator_widget.dart';

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
    infoBloc.getAllList(employeeBloc.user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
            ),
             Card(
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
                                  value: infoBloc.internetProblems.length.toDouble() >= 1 ? infoBloc.internetProblems.length.toDouble() : 0.0,
                                  title: '${infoBloc.internetProblems.length}',
                                  titleStyle: subtitleProfileHeader,
                                ),
                                PieChartSectionData(
                                  color: Colors.lightBlueAccent,
                                  value: infoBloc.reports.length.toDouble() >= 1 ? infoBloc.reports.length.toDouble() : 0.0,
                                  title: '${infoBloc.reports.length}',
                                  titleStyle: subtitleProfileHeader,
                                ),
                                PieChartSectionData(
                                  color: Colors.deepPurple,
                                  value: infoBloc.others.length.toDouble() >= 1 ? infoBloc.others.length.toDouble() : 0.0,
                                  title: '${infoBloc.others.length}',
                                  titleStyle: subtitleProfileHeader,
                                ),
                                PieChartSectionData(
                                  color: Colors.purple,
                                  value: infoBloc.phoneProblems.length.toDouble() >= 1 ? infoBloc.phoneProblems.length.toDouble() : 0.0,
                                  title: '${infoBloc.phoneProblems.length}',
                                  titleStyle: subtitleProfileHeader,
                                ),
                                PieChartSectionData(
                                  color: Colors.deepOrange,
                                  value: infoBloc.softwareIssues.length.toDouble() >= 1 ? infoBloc.softwareIssues.length.toDouble() : 0.0,
                                  title: '${infoBloc.softwareIssues.length}',
                                  titleStyle: subtitleProfileHeader,
                                ),
                                PieChartSectionData(
                                  color: Colors.red,
                                  value: infoBloc.equipmentsIssues.length.toDouble() >= 1 ? infoBloc.equipmentsIssues.length.toDouble() : 0.0,
                                  title: '${infoBloc.equipmentsIssues.length}',
                                  titleStyle: subtitleProfileHeader,
                                ),
                                PieChartSectionData(
                                  color: Colors.yellow,
                                  value: infoBloc.login.length.toDouble() >= 1 ? infoBloc.login.length.toDouble() : 0.0,
                                  title: '${infoBloc.login.length}',
                                  titleStyle: subtitleProfileHeader,
                                ),
                                PieChartSectionData(
                                  color: Colors.green,
                                  value: infoBloc.installEquipment.length.toDouble() >= 1 ? infoBloc.installEquipment.length.toDouble() : 0.0,
                                  title: '${infoBloc.installEquipment.length}',
                                  titleStyle: subtitleProfileHeader,
                                ),
                                PieChartSectionData(
                                  color: Colors.black,
                                  value: infoBloc.softwareInstall.length.toDouble() >= 1 ? infoBloc.softwareInstall.length.toDouble() : 0.0,
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
            SizedBox(
              height: 20,
            ),
            IndicatorWidget(categories: infoBloc.categories,)
          ],
        ),
      ),
    );
  }

}
