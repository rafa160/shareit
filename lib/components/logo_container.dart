import 'package:flutter/material.dart';

class LogoContainer extends StatelessWidget {

  final String tag;

  const LogoContainer({Key key, this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80),
      child: Hero(
        tag: tag,
        child: Image.asset(
          'assets/images/shareit.png',
          fit: BoxFit.fill,
          scale: 2.5,
        ),
      ),
    );
  }
}
