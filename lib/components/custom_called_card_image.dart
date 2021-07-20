import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_it/components/custom_cached_image.dart';
import 'package:share_it/components/custom_sub_text_field.dart';
import 'package:share_it/components/date_card_info.dart';
import 'package:share_it/components/product_main_info_card.dart';

class CustomCalledCardImage extends StatelessWidget {

  final String image;
  final String title;
  final String sub;
  final String topic;
  final DateTime created;
  final DateTime finished;

  const CustomCalledCardImage({Key key, this.image, this.created, this.finished, this.title, this.sub, this.topic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Card(
            semanticContainer: true,
            elevation: 5,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: CustomCachedImage(image),
            ),
          ),
        ),
        Positioned(
            top: 20,
            left: 20,
            child: ProductNameCard(
              icon: FaIcon(
                FontAwesomeIcons.userClock,
                size: 12,
                color: Colors.white,
              ),
              title: title,
        )),
        Positioned(
          top: 60,
          left: 25,
          right: 15,
          child: CustomSubTextField(
            sub: topic,
          ),
        ),
        Positioned(
            bottom: 20,
            left: 20,
            child: DateCardInfo(
              icon: FaIcon(
                FontAwesomeIcons.plus,
                size: 12,
                color: Colors.white,
              ),
              date: created,
            )),
        Positioned(
            bottom: 20,
            right: 20,
            child: DateCardInfo(
              icon: FaIcon(
                FontAwesomeIcons.timesCircle,
                size: 12,
                color: Colors.white,
              ),
              date: finished,
            )),
      ],
    );
  }
}
