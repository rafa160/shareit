import 'package:flutter/material.dart';
import 'package:share_it/components/style.dart';
import 'package:share_it/models/category_model.dart';
import 'package:share_it/screens/info/components/pie_data.dart';

class IndicatorWidget extends StatelessWidget {

  final List<CategoryModel> categories;

  const IndicatorWidget({Key key, this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: PieData().data.map((e) => Container(
        padding: EdgeInsets.only(left: 20,right: 20, top: 10),
        child: buildIndicator(
          text: e.name,
          color: e.color
        ),
      )).toList()
    );

  }

  Widget buildIndicator({
    @required Color color,
    @required String text,
    bool isSquare = false,
    double size = 16,
    Color textColor = Colors.black,
  }) =>
      Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
                color: color,
              ),
            ),
            const SizedBox(width: 8,),
            Text(
              text,
              style: textPlanCard,
            ),
          ],
        ),
      );

}
