import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DrawerRowWidget extends StatelessWidget {
  final Function onTap;
  final String assetPath;
  final String title;
  DrawerRowWidget({this.title,this.onTap,this.assetPath});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.lightGrayDotColor)
          )
        ),
        child: Padding(
          padding: SizeConfig.verticalC13Padding,
          child: Row(
            children: [
              SizedBox(
                width: 20,
              ),
              !assetPath.endsWith(".svg")? Image(
                  image: AssetImage(assetPath),
                  
                  height: 40,
                  width: 40): Container(
                    height: 40,
                  width: 40,
                    child: SvgPicture.asset( 
                                      assetPath,
                                      ),
                  ),
              SizedBox(
                width: 20,
              ),
              Text(
                title,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.normal),
              )
            ],
          ),
        ),
      ),
    );
  }
}
