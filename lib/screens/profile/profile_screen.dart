import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:share_it/app_module.dart';
import 'package:share_it/blocs/employee_bloc.dart';
import 'package:share_it/components/app_theme.dart';
import 'package:share_it/components/custom_button.dart';
import 'package:share_it/components/custom_circular_progress_indicator.dart';
import 'package:share_it/components/custom_color_circular_progress_indicator.dart';
import 'package:share_it/components/custom_logout_bottom_sheet.dart';
import 'package:share_it/components/profile_header.dart';
import 'package:share_it/components/style.dart';
import 'package:share_it/models/employee_model.dart';
import 'package:share_it/screens/login/login_module.dart';
import 'package:share_it/screens/profile/profile_module.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  var employeeBloc = AppModule.to.getBloc<EmployeeBloc>();

  void _switchThemeAction(bool isDarkTheme) {
    AppTheme.of(context)
        .setBrightness(isDarkTheme ? Brightness.light : Brightness.dark);
  }

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 40,
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
                          return Text('error',style: TextStyle(color: Colors.black),);
                        }
                    }
                    EmployeeModel employee = snapshot.data;
                    return  ProfileHeader(
                      name: employee.name,
                      email: employee.email,
                      role: employee.statusText,
                      iconButton:     IconButton(
                          icon: isDarkTheme != true
                              ? FaIcon(
                            FontAwesomeIcons.solidSun,
                            size: 20,
                            color: Colors.green,
                          )
                              : FaIcon(
                            FontAwesomeIcons.solidMoon,
                            size: 20,
                          ),
                          onPressed: () {
                            _switchThemeAction(isDarkTheme);
                          }),
                    );
                  }
              ),
              SizedBox(
                height: 40,
              ),

            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 20,bottom: 40),
          child: CustomButton(
            onPressed: () async {
              showModalBottomSheet(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                context: context,
                builder: (builder) {
                  return CustomModalBottomSheet(
                    title: 'Gostaria de sair?',
                    actionButtonTitle: 'logout',
                    onPressed: () async {
                      await employeeBloc.signOut();
                      await Get.offAll(() => LoginModule());
                    },
                  );
                }
              );
            },
            widget: Text('sair', style: buttonColors,),
          ),
        ),
      ),
    );
  }
}
