import 'package:flutter/material.dart';
import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/constant/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';


class PImageFullView extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final String imageUrl;
  PImageFullView({this.imageUrl});
  @override
  Widget build(BuildContext context) {
    print("%%%%%%");
    print(imageUrl);
    print("%%%%%%");
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
            backgroundColor: AppColors.green,
            title: Text(
              AppStrings.surveyImage,
              style: TextStyle(color: AppColors.whiteColor),
            ),
          ),

    body: ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(0)),
      child: Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight,
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
    ),


    );
  }
}