
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_it/components/style.dart';

class ProductNameCard extends StatelessWidget {
  final String title;
  final FaIcon icon;

  const ProductNameCard({this.title, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: double.infinity,
        maxHeight: double.infinity,
      ),
      decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Padding(
        padding:
        const EdgeInsets.all(4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 2, right: 2),
                  child: icon,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 2, right: 2),
                  child: Text(
                    title,
                    style: titleForms,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
