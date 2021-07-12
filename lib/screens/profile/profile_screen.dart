import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:share_it/app_module.dart';
import 'package:share_it/blocs/employee_bloc.dart';
import 'package:share_it/blocs/version_bloc.dart';
import 'package:share_it/components/app_theme.dart';
import 'package:share_it/components/custom_button.dart';
import 'package:share_it/components/custom_color_circular_progress_indicator.dart';
import 'package:share_it/components/custom_list_tile.dart';
import 'package:share_it/components/custom_logout_bottom_sheet.dart';
import 'package:share_it/components/profile_header.dart';
import 'package:share_it/components/style.dart';
import 'package:share_it/models/employee_model.dart';
import 'package:share_it/screens/login/login_module.dart';
import 'package:share_it/screens/profile/contract/contract_module.dart';
import 'package:share_it/screens/profile/edit_profile/edit_profile_module.dart';
import 'package:share_it/screens/profile/profile_module.dart';
import 'package:share_it/themes/dark.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  var employeeBloc = AppModule.to.getBloc<EmployeeBloc>();
  var versionBloc = ProfileModule.to.getBloc<VersionBloc>();

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
                      iconButton:  IconButton(
                          icon: isDarkTheme != true
                              ? FaIcon(
                            FontAwesomeIcons.solidMoon,
                            size: 20,
                            color: Colors.green,
                          )
                              : FaIcon(
                            FontAwesomeIcons.solidSun,
                            size: 20,
                          ),
                          onPressed: () {
                            _switchThemeAction(isDarkTheme);
                          }),
                    );
                  }
              ),
              Divider(
                color: Theme.of(context).accentColor,
              ),
              SizedBox(
                height: 40,
              ),
              CustomListTile(
                title: 'meus dados',
                subTitle: 'visualize suas informações',
                icon: FaIcon(
                  FontAwesomeIcons.cog
                ),
                onTap: (){
                  Get.to(() => EditProfileModule(employeeBloc.user));
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Divider(),
              ),
              CustomListTile(
                title: 'meus contratos',
                subTitle: 'contratos e pendências de assinatura',
                icon: FaIcon(
                    FontAwesomeIcons.file
                ),
                onTap: (){
                  Get.to(() => ContractModule(companyId: employeeBloc.user.companyId,));
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Divider(),
              ),
              InkWell(
                onTap: () {
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
                child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: ListTile(
                    leading: Icon(FontAwesomeIcons.signOutAlt, color: redColor, size: 20,),
                    title: Text('sair',style: textPlanCard),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              StreamBuilder(
                stream: versionBloc.streamVersion$,
                 builder: (context, snapshot) {
                   return Text(
                     "versão: ${snapshot.data}", style: subtitleProfileHeader,
                   );
                 }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
