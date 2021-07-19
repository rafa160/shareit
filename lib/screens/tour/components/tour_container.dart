import 'package:flutter/material.dart';
import 'package:share_it/components/style.dart';

class TourContainer extends StatelessWidget {
  final String image, text;

  const TourContainer({Key key, this.image, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 100,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: dayTitle,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Image.asset(
          image,
          height: MediaQuery.of(context).size.width * 0.3,
        ),
      ],
    );
  }
}