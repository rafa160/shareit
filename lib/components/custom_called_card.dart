import 'package:bubble/bubble.dart';
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
      height: ScreenUtil.screenHeight * 0.29,
      child: Card(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration:  BoxDecoration(
                  color: Colors.blueAccent,
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
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Padding(
                padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
                child: Container(
                  width: ScreenUtil.screenWidth,
                  child: Bubble(
                    // margin: BubbleEdges.only(top: 10),
                    stick: true,
                    nip: BubbleNip.leftTop,
                    color: Colors.blue[200],
                    child: Text(
                      subject,
                      style: titleForms,
                    ),
                  ),
                ),
              ),
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
