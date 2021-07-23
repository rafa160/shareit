import 'package:carousel_slider/carousel_slider.dart';
import 'package:cnpj_cpf_formatter/cnpj_cpf_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_multi_formatter/formatters/phone_input_formatter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:share_it/blocs/company_bloc.dart';
import 'package:share_it/blocs/plan_bloc.dart';
import 'package:share_it/components/custom_button.dart';
import 'package:share_it/components/custom_circular_progress_indicator.dart';
import 'package:share_it/components/custom_color_circular_progress_indicator.dart';
import 'package:share_it/components/custom_form_builder.dart';
import 'package:share_it/components/custom_plan_card.dart';
import 'package:share_it/components/style.dart';
import 'package:share_it/models/company_model.dart';
import 'package:share_it/screens/register_employee/register_employee_module.dart';
import 'package:share_it/screens/request_access/request_access_module.dart';

class RequestAccessScreen extends StatefulWidget {
  @override
  _RequestAccessScreenState createState() => _RequestAccessScreenState();
}

class _RequestAccessScreenState extends State<RequestAccessScreen> {
  var planBloc = RequestAccessModule.to.getBloc<PlanBloc>();
  var companyBloc = RequestAccessModule.to.getBloc<CompanyBloc>();
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  int index = 0;
  FocusNode _focusNode = FocusNode();

  void requestFocus() {
   FocusScope.of(context).unfocus();
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 80,
                ),
                Text(
                  'Olá, informe o seus primeiros dados e retornamos em no maximo 48h.',
                  style: titleScreens,
                ),
                SizedBox(
                  height: 10,
                ),
                FutureBuilder(
                    future: planBloc.getPlans(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return Center(
                            child: CustomCircularProgressIndicator(),
                          );
                        default:
                      }
                      return CarouselSlider(
                          options: CarouselOptions(
                              height: ScreenUtil.screenHeight * 0.2,
                              autoPlay: true,
                              enlargeCenterPage: true,
                              aspectRatio: 3.2 / 1),
                          items: planBloc.planList.map((e) {
                            return CustomPlanCard(
                              title: e.name,
                              subTitle: '${e.value} mês',
                              text: e.index != 2
                                  ? 'funcionarios: até ${e.employees}'
                                  : 'funcionarios: ${e.employees}',
                            );
                          }).toList());
                    }),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'reponsavel',
                    style: titleForms,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomFormBuilderNoBorder(
                  text: 'person_name',
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
                    'empresa',
                    style: titleForms,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomFormBuilderNoBorder(
                  text: 'name',
                  initialValue: '',
                  hint: 'nome da empresa',
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
                    'documentação',
                    style: titleForms,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomFormBuilderNoBorder(
                  text: 'document',
                  initialValue: '',
                  hint: 'CNPJ ou CPF',
                  enabled: true,
                  input: [
                    CnpjCpfFormatter(
                      eDocumentType: EDocumentType.BOTH,
                    )
                  ],
                  action: TextInputAction.next,
                  type: TextInputType.number,
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
                    'e-mail de contato',
                    style: titleForms,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomFormBuilderNoBorder(
                  text: 'email',
                  initialValue: '',
                  hint: 'e-mail',
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
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'telefone ou whatsapp',
                    style: titleForms,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomFormBuilderNoBorder(
                  text: 'phone',
                  initialValue: '',
                  hint: '(85) 98912-1111',
                  enabled: true,
                  maxLength: 11,
                  action: TextInputAction.done,
                  type: TextInputType.number,
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
                    'plano',
                    style: titleForms,
                  ),
                ),
                FutureBuilder(
                  future: planBloc.getPlans(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return Center(
                          child:
                          CustomCircularProgressIndicator(),
                        );
                      default:
                    }
                    return FormBuilderRadioGroup(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      name: 'plan',
                      focusNode: _focusNode,
                      validator: FormBuilderValidators.required(context),
                      initialValue: planBloc.planList,
                      options: planBloc.planList.map((e) => FormBuilderFieldOption(
                        child: Text(e.name, style: titleForms,), value: e.id,
                      )).toList(growable: false),
                    );
                  }
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: bottom),
                  child: StreamBuilder(
                    initialData: [],
                    stream: companyBloc.loading,
                    builder: (context, snapshot) {
                      if (snapshot.data != true) {
                        return CustomButton(
                          widget: Text('enviar solicitação', style: buttonColors,),
                          onPressed: () async {
                            var plan = _formKey.currentState.fields['plan'];
                            var name = _formKey.currentState.fields['name'];
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              var newItem = CompanyModel.fromMapping(
                                  _formKey.currentState.value);
                              await companyBloc.createCompanyPreOrder(newItem);
                              requestFocus();
                              Get.offAll(() => RegisterEmployeeModule(newItem, companyBloc.id));
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
