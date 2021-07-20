import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:share_it/app_module.dart';
import 'package:share_it/blocs/called_bloc.dart';
import 'package:share_it/blocs/category_bloc.dart';
import 'package:share_it/blocs/employee_bloc.dart';
import 'package:share_it/components/custom_button.dart';
import 'package:share_it/components/custom_circular_progress_indicator.dart';
import 'package:share_it/components/custom_color_circular_progress_indicator.dart';
import 'package:share_it/components/custom_expansion_tile_card.dart';
import 'package:share_it/components/custom_form_builder.dart';
import 'package:share_it/components/custom_form_builder_dropdown.dart';
import 'package:share_it/components/style.dart';
import 'package:share_it/helpers/strings.dart';
import 'package:share_it/models/called_model.dart';
import 'package:share_it/models/category_model.dart';
import 'package:share_it/models/company_model.dart';
import 'package:share_it/models/employee_model.dart';
import 'package:share_it/screens/main/main_module.dart';
import 'package:share_it/screens/new_called/new_called_module.dart';

class NewCalledScreen extends StatefulWidget {

  final EmployeeModel employeeModel;

  const NewCalledScreen({Key key, this.employeeModel}) : super(key: key);

  @override
  _NewCalledScreenState createState() => _NewCalledScreenState();
}

class _NewCalledScreenState extends State<NewCalledScreen> {

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var employeeBloc = AppModule.to.getBloc<EmployeeBloc>();
  var categoryBloc = NewCalledModule.to.getBloc<CategoryBloc>();
  var calledBloc = NewCalledModule.to.getBloc<CalledBloc>();
  FocusNode _focusNode = FocusNode();
  String category;

  @override
  void initState() {
    super.initState();
    categoryBloc.getCategories();
  }

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
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: FormBuilder(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 60,
                ),
                Text(Strings.TITLE_NEW_CALLED_HINT, style: homeMessage,),
                SizedBox(
                  height: 40,
                ),
                Text(Strings.SUBJECT_STRING, style: textPlanCard,),
                SizedBox(
                  height: 5,
                ),
                CustomFormBuilderNoBorder(
                  text: 'subject',
                  initialValue: '',
                  hint: Strings.SUBJECT_HINT,
                  enabled: true,
                  action: TextInputAction.done,
                  type: TextInputType.text,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                  ]),
                  obscureText: false,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(Strings.EMPLOYEE_TITLE_HINT, style: textPlanCard,),
                SizedBox(
                  height: 5,
                ),
                CustomFormBuilderNoBorder(
                  text: 'employee_name',
                  initialValue: widget.employeeModel.name ?? '',
                  enabled: false,
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
                Text(Strings.EMPLOYEE_EMAIL_HINT, style: textPlanCard,),
                SizedBox(
                  height: 5,
                ),
                CustomFormBuilderNoBorder(
                  text: 'employee_email',
                  initialValue: widget.employeeModel.email ?? '',
                  enabled: false,
                  obscureText: false,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(Strings.CATEGORY_HINT, style: textPlanCard,),
                SizedBox(
                  height: 5,
                ),
                FutureBuilder<List<CategoryModel>>(
                    initialData: categoryBloc.categories,
                    future: categoryBloc.getCategories(),
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
                        name: 'category_id',
                        focusNode: _focusNode,
                        validator: FormBuilderValidators.required(context),
                        initialValue: categoryBloc.categories,
                        options: categoryBloc.categories.map((e) => FormBuilderFieldOption(
                          child: Align(alignment: Alignment.topLeft, child: Text(e.name, style: titleForms,)), value: e.id,
                        )).toList(growable: false),
                      );
                    }
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar:  Padding(
        padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
        child: StreamBuilder(
          initialData: [],
          stream: calledBloc.loading,
          builder: (context, snapshot) {
            if (snapshot.data != true) {
              return CustomButton(
                widget: Text(Strings.NEW_CALLED_BTN, style: buttonColors,),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    var newItem = CalledModel.fromMapping(
                        _formKey.currentState.value);
                    List<EmployeeModel> list = await employeeBloc.getSupportEmployeeList(employeeBloc);
                    await calledBloc.createCalledRequest(calledModel: newItem, employeeModel: employeeBloc.user, employeeSupportList: list);
                    requestFocus();
                    Get.offAll(() => MainModule());
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
