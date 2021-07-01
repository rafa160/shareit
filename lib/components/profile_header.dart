import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_it/components/style.dart';

class ProfileHeader extends StatelessWidget {

  final String name;
  final String email;
  final String role;
  final IconButton iconButton;

  const ProfileHeader({Key key, this.name, this.email, this.role, this.iconButton}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.white24))),
            child: FaIcon(
              FontAwesomeIcons.userCircle,
              size: 40,
            ),
          ),
          title: Text(
            name,
            style: textPlanCard,
          ),
          subtitle: Row(
            children: <Widget>[
              Icon(Icons.linear_scale, color: Colors.black),
              SizedBox(width: 10,),
              Text(email, style: subtitleProfileHeader),
              SizedBox(width: 10,),
              Expanded(child: Text(role, style: subtitleProfileHeader)),
            ],
          ),
          trailing:
              iconButton
        ),
      ),
    );
  }
}
