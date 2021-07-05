import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:share_it/app_module.dart';
import 'package:share_it/blocs/category_bloc.dart';
import 'package:share_it/blocs/employee_bloc.dart';
import 'package:share_it/components/custom_circular_progress_indicator.dart';
import 'package:share_it/components/custom_expansion_tile_card.dart';
import 'package:share_it/components/custom_form_builder.dart';
import 'package:share_it/components/custom_form_builder_dropdown.dart';
import 'package:share_it/components/style.dart';
import 'package:share_it/models/category_model.dart';
import 'package:share_it/models/company_model.dart';
import 'package:share_it/models/employee_model.dart';
import 'package:share_it/screens/new_called/new_called_module.dart';

class NewCalledScreen extends StatefulWidget {

  final EmployeeModel employeeModel;

  const NewCalledScreen({Key key, this.employeeModel}) : super(key: key);

  @override
  _NewCalledScreenState createState() => _NewCalledScreenState();
}

class _NewCalledScreenState extends State<NewCalledScreen> {

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  var employeeBloc = AppModule.to.getBloc<EmployeeBloc>();
  var categoryBloc = NewCalledModule.to.getBloc<CategoryBloc>();
  FocusNode _focusNode = FocusNode();
  String category;

  @override
  void initState() {
    super.initState();
    categoryBloc.getCategories();
  }


  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Text('Inicie seu chamado para a área de Suporte', style: homeMessage,),
                SizedBox(
                  height: 40,
                ),
                Text('qual o assunto do seu pedido?', style: textPlanCard,),
                SizedBox(
                  height: 5,
                ),
                CustomFormBuilderNoBorder(
                  text: 'subject',
                  initialValue: '',
                  hint: 'assunto',
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
                Text('nome do solicitante', style: textPlanCard,),
                SizedBox(
                  height: 5,
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
                Text('e-mail do solicitante', style: textPlanCard,),
                SizedBox(
                  height: 5,
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
                Text('categoria', style: textPlanCard,),
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
                      return Column(
                        children: [
                          CustomExpansionTileCard(
                            title: 'Selecione uma categoria',
                            widget: FormBuilderRadioGroup(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                              name: 'category',
                              focusNode: _focusNode,
                              validator: FormBuilderValidators.required(context),
                              initialValue: categoryBloc.categories,
                              options: categoryBloc.categories.map((e) => FormBuilderFieldOption(
                                child: Align(alignment: Alignment.topLeft, child: Text(e.name, style: titleForms,)), value: e.id,
                              )).toList(growable: false),
                            )
                            ,
                          ),
                        ],
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
    );
  }
}
