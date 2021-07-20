import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:share_it/components/style.dart';

class CustomCachedImage extends StatelessWidget {
  final String image;

  CustomCachedImage(this.image);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        placeholder: (context, url) => Container(
          color: greyColor2,
        ),
        errorWidget: (context, url, error) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error),
            Text('erro ao tentar trazer imagem', style: titleForms,),
          ],
        ),
        imageUrl: image,
        height: 160,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.fill);
  }
}
