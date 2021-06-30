import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_it/components/style.dart';

class CustomPlanCard extends StatelessWidget {

  final String title;
  final String subTitle;
  final String text;
  const CustomPlanCard({Key key, this.title, this.subTitle, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: ScreenUtil.screenHeight * 0.2,
        width: ScreenUtil.screenWidth * 0.5,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              title,
              style: titlePlanCard,
            ),
            SizedBox(
              height: 10,
            ),
            Flexible(
              child: Text(
                text,
                style: textPlanCard,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              subTitle,
              style: GoogleFonts.nunito(
                  color: Theme.of(context).accentColor,
                  fontSize: 16
              ),
            ),
          ],
        ),
      ),
    );
  }
}
