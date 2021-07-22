import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:share_it/blocs/category_bloc.dart';
import 'package:share_it/components/custom_circular_progress_indicator.dart';
import 'package:share_it/components/custom_form_builder.dart';
import 'package:share_it/components/date_card_info.dart';
import 'package:share_it/components/style.dart';
import 'package:share_it/models/called_model.dart';
import 'package:share_it/models/category_model.dart';
import 'package:share_it/screens/my_called_details_only_read/my_called_details_only_read_module.dart';

class MyCalledDetailsOnlyReadScreen extends StatefulWidget {
  final CalledModel calledModel;

  const MyCalledDetailsOnlyReadScreen({Key key, this.calledModel}) : super(key: key);
  @override
  _MyCalledDetailsOnlyReadScreenState createState() => _MyCalledDetailsOnlyReadScreenState();
}

class _MyCalledDetailsOnlyReadScreenState extends State<MyCalledDetailsOnlyReadScreen> {

  var categoryBloc = MyCalledDetailsOnlyReadModule.to.getBloc<CategoryBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          'detalhe do chamado',
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
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              SizedBox(
                height: 30,
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
                    );
                  }
              ),
              SizedBox(
                height: 10,
              ),
              CustomFormBuilderNoBorder(
                initialValue: widget.calledModel.employeeName,
                enabled: false,
                obscureText: false,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: ScreenUtil.screenWidth,
                height: 100,
                child: Bubble(
                  stick: true,
                  nip: BubbleNip.leftTop,
                  color: Colors.blue[200],
                  child: Text(
                    widget.calledModel.subject,
                    style: textPlanCard,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
               mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DateCardInfo(
                    date: widget.calledModel.calledCreatedTime,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: ScreenUtil.screenWidth,
                height: 100,
                child:Bubble(
                  stick: true,
                  nip: BubbleNip.rightTop,
                  color: Colors.greenAccent,
                  child:  widget.calledModel.comment != '' ? Text(
                    widget.calledModel.comment,
                    style: textPlanCard,
                  ) : Text(
                    'Sem observações do suporte',
                    style: textPlanCard,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DateCardInfo(
                    date: widget.calledModel.calledFinishedTime,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
