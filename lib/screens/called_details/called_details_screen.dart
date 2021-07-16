import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:share_it/blocs/called_bloc.dart';
import 'package:share_it/blocs/category_bloc.dart';
import 'package:share_it/components/custom_button.dart';
import 'package:share_it/components/custom_circular_progress_indicator.dart';
import 'package:share_it/components/custom_form_builder.dart';
import 'package:share_it/components/date_card_info.dart';
import 'package:share_it/components/style.dart';
import 'package:share_it/helpers/utils.dart';
import 'package:share_it/models/called_model.dart';
import 'package:share_it/models/category_model.dart';
import 'package:share_it/screens/called_details/called_details_module.dart';
import 'package:share_it/screens/main/main_module.dart';

class CalledDetailsScreen extends StatefulWidget {
  final CalledModel calledModel;

  const CalledDetailsScreen({Key key, this.calledModel}) : super(key: key);

  @override
  _CalledDetailsScreenState createState() => _CalledDetailsScreenState();
}

class _CalledDetailsScreenState extends State<CalledDetailsScreen> {

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  var categoryBloc = CalledDetailsModule.to.getBloc<CategoryBloc>();
  var calledBloc = CalledDetailsModule.to.getBloc<CalledBloc>();
  FocusNode _focusNode = FocusNode();


  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'detalhes do chamado',
          style: textPlanCard,
        ),
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
        child: FormBuilder(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DateCardInfo(
                      date: widget.calledModel.calledCreatedTime,
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: ScreenUtil.screenWidth,
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue[200]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.calledModel.subject, style: textPlanCard,),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomFormBuilderNoBorder(
                  initialValue: widget.calledModel.employeeName,
                  enabled: false,
                  obscureText: false,
                ),
                SizedBox(
                  height: 20,
                ),
                FutureBuilder(
                  future: categoryBloc.getCategoryById(widget.calledModel.categoryId),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return Center(
                            child: CustomCircularProgressIndicator(),
                          );
                        default:
                      }
                      CategoryModel category = snapshot.data;
                      return CustomFormBuilderNoBorder(
                        initialValue: category.name,
                        enabled: false,
                        obscureText: false,
                        focusNode: _focusNode,
                      );
                    }
                ),
                SizedBox(
                  height: 20,
                ),
                CustomFormBuilderNoBorder(
                  text: 'comment',
                  initialValue: '',
                  hint: 'observações',
                  enabled: true,
                  action: TextInputAction.next,
                  type: TextInputType.text,
                  validator: FormBuilderValidators.compose([
                  ]),
                  obscureText: false,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: bottom),
        child: StreamBuilder(
          initialData: [],
          stream: calledBloc.loading,
          builder: (context, snapshot) {
            if (snapshot.data != true) {
              return CustomButton(
                widget: Text('encerrar chamado', style: buttonColors,),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    var comment = _formKey.currentState.value['comment'];
                    await calledBloc.update( calledModel: widget.calledModel, comment: comment);
                    requestFocus(context);
                    await Get.offAll(() => MainModule());
                  }
                },
              );
            } else {
              return CustomButton(
                onPressed: () {},
                widget: CustomCircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
