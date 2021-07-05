import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';

class CustomExpansionTileCard extends StatelessWidget {

  final String title;
  final Widget widget;


  const CustomExpansionTileCard({Key key, this.title, this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpansionTileCard(
          baseColor: Colors.green[200],
          title: Text(title),
          children: [
            widget
          ],
        ),
      ],
    );
  }
}
