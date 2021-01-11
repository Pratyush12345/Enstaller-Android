import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:enstaller/core/constant/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ViewAppImage extends StatelessWidget {
  final String imageUrl;
  final File imageFile;
  final String assetsUrl;
  final double height;
  final double width;
  final double radius;
  ViewAppImage(
      {this.imageUrl,
      this.width,
      this.height,
      this.radius: 0.0,
      this.assetsUrl,
      this.imageFile});
  @override
  Widget build(BuildContext context) {
    print("%%%%%%");
    print(imageUrl);
    print("%%%%%%");
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      child: imageFile != null
          ? Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: FileImage(imageFile), fit: BoxFit.cover),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            )
          : Container(
              width: width ?? SizeConfig.screenWidth,
              height: height ?? SizeConfig.screenHeight,
              child: imageUrl != null && imageUrl != ''
                  ? imageUrl.endsWith(".svg")
                      ? SvgPicture.network(
                          imageUrl,
                          placeholderBuilder: (BuildContext context) =>
                              Container(
                                  padding: const EdgeInsets.all(30.0),
                                  child: const CircularProgressIndicator()),
                        ):
                        CachedNetworkImage(
                          imageUrl: imageUrl,
                          fit: BoxFit.contain,
                          placeholder: (context, url) => Container(
                            width: 40,
                            height: 40,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        )
                      
                  : Container(),
            ),
    );
  }
}
