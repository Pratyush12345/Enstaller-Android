import 'package:enstaller/core/constant/size_config.dart';
import 'package:enstaller/core/constant/text_style.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  String buttonText;
  double width,height;
  TextStyle textStyle;
  Color color;
  double radius;
  Function onTap;
  AppButton({this.buttonText,this.width,this.height,this.color,this.textStyle,this.onTap,this.radius:0});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width??SizeConfig.screenWidth,
        height: height??SizeConfig.screenHeight*.04,
        child: Center(
          child: Text(buttonText,
          style: textStyle??AppStyles.BlackStyleFontW600_12(context),),
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius)
        ),
      ),
    );
  }
}
