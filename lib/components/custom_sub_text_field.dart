
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_it/components/style.dart';

class CustomSubTextField extends StatelessWidget {
  final String sub;

  const CustomSubTextField({this.sub});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Bubble(
      margin: BubbleEdges.only(top: 10),
      stick: true,
      nip: BubbleNip.leftTop,
      color: Colors.teal,
      child: Text(
        sub,
        style: titleForms,
      ),
    );

  }
}
