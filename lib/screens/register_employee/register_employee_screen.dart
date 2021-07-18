import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:share_it/blocs/company_bloc.dart';
import 'package:share_it/blocs/employee_bloc.dart';
import 'package:share_it/blocs/plan_bloc.dart';
import 'package:share_it/components/custom_alert_dialog.dart';
import 'package:share_it/components/custom_button.dart';
import 'package:share_it/components/custom_circular_progress_indicator.dart';
import 'package:share_it/components/custom_color_circular_progress_indicator.dart';
import 'package:share_it/components/custom_form_builder.dart';
import 'package:share_it/components/custom_text_button.dart';
import 'package:share_it/components/style.dart';

import 'package:share_it/models/company_model.dart';
import 'package:share_it/models/plan_model.dart';
import 'package:share_it/screens/login/login_module.dart';
import 'package:share_it/screens/register_employee/register_employee_module.dart';

class RegisterEmployeeScreen extends StatefulWidget {
  final CompanyModel companyModel;
  final String id;
  const RegisterEmployeeScreen({Key key, this.companyModel, this.id}) : super(key: key);

  @override
  _RegisterEmployeeScreenState createState() => _RegisterEmployeeScreenState();
}

class _RegisterEmployeeScreenState extends State<RegisterEmployeeScreen> {

  var planBloc = RegisterEmployeeModule.to.getBloc<PlanBloc>();
  var companyBloc = RegisterEmployeeModule.to.getBloc<CompanyBloc>();
  var employeeBloc = RegisterEmployeeModule.to.getBloc<EmployeeBloc>();

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      appBar: AppBar(
        title: Text('registre seus funcionarios', style: textPlanCard,),
        leading: IconButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomAlertDialog(
                    title: 'Se você voltar agora não será possivel cadastrar mais seus funcionários',
                    content: 'Então, tem certeza que quer desistir?',
                    no: () {
                      Get.back();
                    },
                    yes: () async{
                      Get.offAll(() => LoginModule());
                    },
                  );
                }
            );
          },
          icon: FaIcon(
            FontAwesomeIcons.chevronLeft,
            size: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: FormBuilder(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                FutureBuilder(
                    future: planBloc.getPlanById(widget.companyModel.planId),
                    builder: (context, snapshot){
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return Center(
                            child: CustomCircularProgressIndicator(),
                          );
                        default:
                      }
                      PlanModel plan = snapshot.data;
                      return  Text('Você escolheu o ${plan.name}, cadastre os ${plan.employees} funcionários.', style: textPlanCard
                      );
                    }
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Lembre-se de colocar ao menos um funcionário com a função SUPORTE.', style: subtitleProfileHeader,),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'nome do funcionário',
                    style: titleForms,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomFormBuilderNoBorder(
                  text: 'name',
                  initialValue: '',
                  hint: 'nome',
                  enabled: true,
                  action: TextInputAction.next,
                  type: TextInputType.name,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                  ]),
                  obscureText: false,
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'e-mail',
                    style: titleForms,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomFormBuilderNoBorder(
                  text: 'email',
                  initialValue: '',
                  hint: 'email',
                  enabled: true,
                  action: TextInputAction.next,
                  type: TextInputType.emailAddress,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                  ]),
                  obscureText: false,
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'informe a primeira senha, ela pode ser alterada pelo funcionário.',
                    style: titleForms,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomFormBuilderNoBorder(
                  text: 'password',
                  initialValue: '',
                  hint: 'senha',
                  enabled: true,
                  action: TextInputAction.next,
                  type: TextInputType.name,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                  ]),
                  obscureText: true,
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'cargo do seu funcionário',
                    style: titleForms,
                  ),
                ),
                FormBuilderRadioGroup(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    name: 'role',
                    validator: FormBuilderValidators.required(context),
                    initialValue: planBloc.planList,
                    options: [
                      'Gerencia','Funcionário','Suporte'
                    ].map((e) => FormBuilderFieldOption(value: e, child: Text('$e'))).toList(growable: false),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(right: 20, left: 20,bottom: bottom),
        child: StreamBuilder(
          initialData: [],
          stream: employeeBloc.loginStream,
          builder: (context, snapshot) {
            if (snapshot.data != true) {
              return CustomButton(
                widget: Text('enviar solicitação', style: buttonColors,),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    await employeeBloc.signUpWithEmailPasswordAdminPastor(
                        _formKey.currentState.value['email'],
                        _formKey.currentState.value['password'],
                        _formKey.currentState.value['name'],
                      _formKey.currentState.value['role'],
                     widget.id
                    );
                   await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomAlertDialog(
                            title: 'Gostaria de adicionar mais algum Funcionário? lembre-se quantas pessoas são permitidas no seu plano.',
                            content: 'Caso não queira continuar, não vai ser mais possivel adicionar pelo App.',
                            no: () {
                              Get.offAll(() => LoginModule());
                            },
                            yes: () {
                              Get.offAll(() => RegisterEmployeeModule(widget.companyModel, widget.id));
                            },
                          );
                        }
                    );
                  }
                },
              );
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
