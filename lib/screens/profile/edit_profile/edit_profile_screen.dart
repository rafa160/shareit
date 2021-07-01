import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:share_it/app_module.dart';
import 'package:share_it/blocs/employee_bloc.dart';
import 'package:share_it/components/custom_button.dart';
import 'package:share_it/components/custom_circular_progress_indicator.dart';
import 'package:share_it/components/custom_color_circular_progress_indicator.dart';
import 'package:share_it/components/custom_form_builder.dart';
import 'package:share_it/components/style.dart';
import 'package:share_it/models/employee_model.dart';

class EditProfileScreen extends StatefulWidget {
  final EmployeeModel employeeModel;

  const EditProfileScreen({Key key, this.employeeModel}) : super(key: key);
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  var employeeBloc = AppModule.to.getBloc<EmployeeBloc>();
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return FormBuilder(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text('meus dados', style: appBarTitle,),
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: FaIcon(
              FontAwesomeIcons.chevronLeft,
              size: 20,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'nome',
                    style: textPlanCard,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomFormBuilderNoBorder(
                    text: 'name',
                    initialValue: widget.employeeModel.name ?? '',
                    enabled: true,
                    action: TextInputAction.next,
                    type: TextInputType.text,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                    ]),
                    obscureText: false,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'email',
                    style: textPlanCard,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomFormBuilderNoBorder(
                    text: 'email',
                    initialValue: widget.employeeModel.email ?? '',
                    enabled: false,
                    obscureText: false,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Text(
                  //   'função',
                  //   style: textPlanCard,
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // CustomFormBuilderNoBorder(
                  //   text: 'role',
                  //   initialValue: widget.employeeModel.statusText,
                  //   enabled: false,
                  //   obscureText: false,
                  // ),
                ],
              ),
            ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(left: 20,right: 20,bottom:bottom),
          child: StreamBuilder(
              stream: employeeBloc.loginStream,
              builder: (context, snapshot) {
                if(snapshot.data != true) {
                  return CustomButton(
                      widget: Text('atualizar', style: buttonColors,),
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        if(_formKey.currentState.validate()){
                          _formKey.currentState.save();
                          var updateUser = EmployeeModel.fromJson(
                              _formKey.currentState.value);
                          await employeeBloc.updateEmployee(employeeBloc: employeeBloc, employeeModel: updateUser);
                          Get.back();
                        }
                      });
                } else {
                  return CustomButton(
                    widget: CustomColorCircularProgressIndicator(),
                    onPressed: () async {},
                  );
                }
              }
          ),
        ),
      ),
    );
  }
}
