import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_it/components/style.dart';

class CustomCalledCard extends StatelessWidget {

  final String email;
  final String subject;
  final String createdDate;
  final String finishedDate;

  const CustomCalledCard({Key key, this.email, this.subject, this.createdDate, this.finishedDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Container(
      height: ScreenUtil.screenHeight * 0.23,
      child: Card(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration:  BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Autor: ', style: titleForms,),
                      SizedBox(
                        width: 1,
                      ),
                      Text(email, style: titleForms,),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
                child: Text('Assunto', style: titleForms,),
              ),
              SizedBox(
                height: 10,
              ),
              Flexible( flex: 3, child: Padding(
                padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
                child: Text('  $subject', style: titleForms,),
              )),
              SizedBox(
                height: 10,
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: [
                    Text('inicio - $createdDate', style: titleForms,),
                    Spacer(),
                    Text('fim - $finishedDate', style: titleForms,),
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
}
