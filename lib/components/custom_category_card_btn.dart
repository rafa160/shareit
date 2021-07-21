import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_it/components/style.dart';

class CustomCategoryCardBtn extends StatelessWidget {
  final String text;
  final FaIcon icon;
  final VoidCallback onPressed;

  const CustomCategoryCardBtn({this.text, this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 5, top: 20),
      child: Container(
        height: 80,
        width: 100,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 5,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
          onPressed: onPressed,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 5,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: icon),
              SizedBox(
                height: 20,
              ),
              Flexible(child: Text(text, style: subtitleProfileHeader, overflow: TextOverflow.ellipsis,))
            ],
          ),
        ),
      ),
    );
  }
}
