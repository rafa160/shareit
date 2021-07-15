import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:share_it/app_module.dart';
import 'package:share_it/blocs/employee_bloc.dart';
import 'package:share_it/components/custom_button.dart';
import 'package:share_it/components/custom_color_circular_progress_indicator.dart';
import 'package:share_it/components/custom_form_builder.dart';
import 'package:share_it/components/style.dart';
import 'package:share_it/screens/login/login_module.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  var userBloc = AppModule.to.getBloc<EmployeeBloc>();

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          'renovar senha',
          style: textPlanCard,
        ),
        leading: IconButton(
          onPressed: () {
            Get.offAll(() => LoginModule());
          },
          icon: FaIcon(
            FontAwesomeIcons.chevronLeft,
            size: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: FormBuilder(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  CustomFormBuilderNoBorder(
                    text: 'email',
                    initialValue: '',
                    hint: 'email',
                    enabled: true,
                    action: TextInputAction.send,
                    type: TextInputType.emailAddress,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.email(context),
                      FormBuilderValidators.required(context),
                    ]),
                    obscureText: false,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: bottom ),
        child: StreamBuilder(
          initialData: [],
          stream: userBloc.loginStream,
          builder: (context, snapshot) {
            if(snapshot.data != true) {
              return CustomButton(
                  widget: Text('enviar solicitação para email'),
                  onPressed: () async {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      await userBloc.resetPassword(_formKey.currentState.value['email']);
                    }
                  });
            } else {
              return CustomButton(
                onPressed: () {},
                widget: CustomColorCircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
