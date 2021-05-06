import 'package:flutter/material.dart';
import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/constant/size_config.dart';


class ImageFullView extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final ImageProvider image;
  ImageFullView({this.image});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
            backgroundColor: AppColors.appThemeColor,
            title: Text(
              AppStrings.surveyImage,
              style: TextStyle(color: AppColors.whiteColor),
            ),
          ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          decoration: BoxDecoration(
            image: DecorationImage(image: image,
            fit: BoxFit.contain)
          ),
        ),
      ),

    );
  }
}