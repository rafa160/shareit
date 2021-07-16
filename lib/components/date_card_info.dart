import 'package:flutter/material.dart';
import 'package:share_it/components/style.dart';
import 'package:share_it/helpers/utils.dart';

class DateCardInfo extends StatelessWidget {

  final DateTime date;

  const DateCardInfo({this.date});

  @override
  Widget build(BuildContext context) {

    var time = formatDate(date);

    return Container(
      constraints: BoxConstraints(
        maxWidth: double.infinity,
        maxHeight: double.infinity,
      ),
      decoration: BoxDecoration(
          color: Colors.blue[200],
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 2, right: 2),
              child: Text(
                time,
                style: timeText,
              ),
            )
          ],
        ),
      ),
    );
  }
}
