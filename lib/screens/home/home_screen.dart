import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_it/app_module.dart';
import 'package:share_it/blocs/employee_bloc.dart';
import 'package:share_it/components/custom_circular_progress_indicator.dart';
import 'package:share_it/components/custom_color_circular_progress_indicator.dart';
import 'package:share_it/components/custom_named_icon.dart';
import 'package:share_it/components/style.dart';
import 'package:share_it/models/called_model.dart';
import 'package:share_it/models/employee_model.dart';
import 'package:share_it/screens/home/bloc/home_bloc.dart';
import 'package:share_it/screens/home/home_module.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var employeeBloc = AppModule.to.getBloc<EmployeeBloc>();
  var homeBloc = HomeModule.to.getBloc<HomeBloc>();
  List<CalledModel> todayListNumber = [];
  List<CalledModel> yesterdayListNumber = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todayListNumber = homeBloc.getListTodayCalledNumber(employeeBloc);
    yesterdayListNumber = homeBloc.getListYesterdayCalledNumber(employeeBloc);
    homeBloc.getCalledItems(employeeBloc);
    homeBloc.getYesterdayCalledItems(employeeBloc);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            StreamBuilder(
                initialData: [],
                stream: employeeBloc.userModel,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return CustomColorCircularProgressIndicator();
                    default:
                      if (!snapshot.hasData || snapshot.hasError) {
                        return Text(
                          'error',
                          style: TextStyle(color: Colors.black),
                        );
                      }
                  }
                  EmployeeModel employee = snapshot.data;
                  return Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: Row(
                      children: [
                        Text('Olá,', style: homeMessage,),
                        SizedBox(
                          width: 5,
                        ),
                        Text('${employee.name}.', style: homeMessage,),
                      ],
                    ),
                  );
                }),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                // color: Colors.deepPurple,
                height: 90,
                child: Card(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      StreamBuilder(
                        initialData: todayListNumber,
                          stream: homeBloc.todayCalledStreamList,
                          builder: (context, snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                              case ConnectionState.waiting:
                                return Center(
                                  child: CustomCircularProgressIndicator(),
                                );
                              default:
                            }
                            return NamedIcon(
                              text: 'hoje',
                              icon: FaIcon(
                                FontAwesomeIcons.calendarTimes,
                                size: 30,
                              ),
                              notificationCount: todayListNumber.length,
                              onTap: () {},
                            );
                          }
                      ),
                      Spacer(),
                      StreamBuilder(
                          initialData: yesterdayListNumber,
                          stream: homeBloc.yesterdayCalledStreamList,
                          builder: (context, snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                              case ConnectionState.waiting:
                                return Center(
                                  child: CustomCircularProgressIndicator(),
                                );
                              default:
                            }
                            return NamedIcon(
                              text: 'ontem',
                              icon: FaIcon(
                                FontAwesomeIcons.calendarWeek,
                                size: 30,
                              ),
                              notificationCount: yesterdayListNumber.length,
                              onTap: () {},
                            );
                          }
                      ),
                      Spacer(),
                      NamedIcon(
                        text: 'mês',
                        icon: FaIcon(
                          FontAwesomeIcons.calendarAlt,
                          size: 30,
                        ),
                        notificationCount: 11,
                        onTap: () {},
                      ),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}