import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_it/app_module.dart';
import 'package:share_it/blocs/employee_bloc.dart';
import 'package:share_it/components/logo_container.dart';
import 'package:share_it/components/style.dart';
import 'package:share_it/models/employee_model.dart';
import 'package:share_it/screens/login/login_module.dart';
import 'package:share_it/screens/main/main_module.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  var employeeBloc = AppModule.to.getBloc<EmployeeBloc>();

  @override
  void initState() {
    _redirectToHome();
    super.initState();
  }


  Future _redirectToHome() async {
    EmployeeModel employeeModel = await employeeBloc.loggedUserAsync();
    if(employeeModel != null) {
      EmployeeModel tourEmployee = await employeeBloc.getUserModel(id: employeeModel.id);
      if(await employeeBloc.isLogged() && tourEmployee.finishTour == true && tourEmployee.available == true) {
        await Get.offAll(() => MainModule());
      }
      // else if (await employeeBloc.isLogged() && tourEmployee.finishTour == false) {
      //   await Get.offAll(() => TourScreen());
      // }
      else {
        await Get.offAll(() => LoginModule());
      }
    } else {
      await Get.offAll(() => LoginModule());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.white,
              Colors.lightBlueAccent,
            ],
          ),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LogoContainer(
                tag: 'logo',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
