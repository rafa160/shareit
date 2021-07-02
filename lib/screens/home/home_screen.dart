import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_it/app_module.dart';
import 'package:share_it/blocs/employee_bloc.dart';
import 'package:share_it/components/custom_color_circular_progress_indicator.dart';
import 'package:share_it/components/style.dart';
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
          ],
        ),
      ),
    );
  }
}
