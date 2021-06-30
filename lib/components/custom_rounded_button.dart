
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomRoundedButton extends StatelessWidget {
  final FaIcon icon;
  final VoidCallback onPressed;
  final Color color;
  final double radius;

  const CustomRoundedButton({Key key, this.icon, this.onPressed, this.color, this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(radius))),
      backgroundColor: color,
      elevation: 5,
      onPressed: onPressed,
      child: icon,
    );
  }
}
