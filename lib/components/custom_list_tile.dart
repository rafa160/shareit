
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_it/components/style.dart';

class CustomListTile extends StatelessWidget {

  final String title;
  final String subTitle;
  final FaIcon icon;
  final VoidCallback onTap;

  const CustomListTile({Key key, this.title, this.icon, this.onTap, this.subTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          leading: icon,
          title: Text(title,style: textPlanCard,),
          subtitle: Text(subTitle, style: subtitleProfileHeader,),
          trailing: Icon(FontAwesomeIcons.chevronRight, size: 18,),
        ),
      ),
    );
  }
}
