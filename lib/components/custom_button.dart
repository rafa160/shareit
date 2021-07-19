
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final Widget widget;
  final VoidCallback onPressed;

  const CustomButton({Key key, this.widget, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
          height: ScreenUtil.screenHeight * 0.06,
          width: ScreenUtil.screenWidth,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
              onPressed: onPressed,
              child: widget
          ),
      ),
    );
  }
}