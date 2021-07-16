import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:share_it/app_module.dart';
import 'package:share_it/blocs/employee_bloc.dart';
import 'package:share_it/components/custom_button.dart';
import 'package:share_it/components/custom_circular_progress_indicator.dart';
import 'package:share_it/components/custom_color_circular_progress_indicator.dart';
import 'package:share_it/components/custom_form_builder.dart';
import 'package:share_it/components/logo_container.dart';
import 'package:share_it/components/style.dart';
import 'package:share_it/screens/login/login_module.dart';
import 'package:share_it/screens/request_access/request_access_module.dart';
import 'package:share_it/screens/reset_password/reset_password_module.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  var employeeBloc = AppModule.to.getBloc<EmployeeBloc>();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: ScreenUtil.screenHeight,
          child: FormBuilder(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// colocar logo posteriormente
                  SizedBox(
                    height: 20,
                  ),
                  Flexible(
                    flex: 3,
                    child: LogoContainer(
                      tag: 'logo',
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  CustomFormBuilderNoBorder(
                    text: 'email',
                    initialValue: '',
                    hint: 'email',
                    enabled: true,
                    action: TextInputAction.next,
                    type: TextInputType.emailAddress,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.email(context),
                      FormBuilderValidators.required(context),
                    ]),
                    obscureText: false,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomFormBuilderNoBorder(
                    text: 'password',
                    initialValue: '',
                    hint: 'senha',
                    enabled: true,
                    action: TextInputAction.send,
                    type: TextInputType.text,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                    ]),
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(() => ResetPasswordModule());
                        },
                          child: Text(
                        'esqueceu sua senha?',
                        style: titleForms,
                      )),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
              StreamBuilder(
                  stream: employeeBloc.loginStream,
                  initialData: [],
                  builder: (context, snapshot) {
                    if(snapshot.data != true) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: bottom),
                        child: CustomButton(
                          widget: Text('entrar', style: buttonColors,),
                          onPressed: () async {
                            FocusScope.of(context).requestFocus(new FocusNode());
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              await employeeBloc.signIn(
                                  _formKey.currentState.value['email'],
                                  _formKey.currentState.value['password'],
                                  context);
                            }
                          },
                        ),
                      );
                    } else {
                      return CustomButton(
                        onPressed: () {},
                        widget: CustomColorCircularProgressIndicator(),
                      );
                    }
                  }
              ),
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => RequestAccessModule());
                      },
                        child: Text('gostaria de solicitar o serviço',style: titleForms)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
