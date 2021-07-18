import 'package:flutter/material.dart';
import 'package:share_it/components/custom_text_button.dart';
import 'package:share_it/components/style.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback yes;
  final VoidCallback no;

  const CustomAlertDialog({Key key, this.title, this.content, this.no, this.yes}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      title: Text(
        title,
        style: alertDialogTitle,
      ),
      content: Text(
        content,
        style: alertDialogContent,
      ),
      actions: [
        Row(
          children: [
            CustomTextButton(
              text: 'não',
              onPressed: no,
            ),
            CustomTextButton(
              text: 'sim',
              onPressed: yes
            ),
          ],
        )
      ],
    );
  }
}
