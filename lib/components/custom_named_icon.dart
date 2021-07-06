import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_it/components/style.dart';

class NamedIcon extends StatelessWidget {
  final FaIcon icon;
  final String text;
  final VoidCallback onTap;
  final int notificationCount;

  const NamedIcon({
    Key key,
    this.onTap,
    @required this.text,
    @required this.icon,
    this.notificationCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 72,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                icon,
                Text(text, overflow: TextOverflow.ellipsis, style: titleForms,),
              ],
            ),
            Positioned(
              top: 10,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.redAccent),
                alignment: Alignment.center,
                child: Text('$notificationCount'),
              ),
            )
          ],
        ),
      ),
    );
  }
}