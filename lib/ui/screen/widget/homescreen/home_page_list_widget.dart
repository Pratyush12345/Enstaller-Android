import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/image_file.dart';
import 'package:enstaller/core/constant/size_config.dart';
import 'package:enstaller/core/constant/text_style.dart';
import 'package:flutter/material.dart';

class HomePageListWidget extends StatelessWidget {
  final bool expanded;
  final String dateString;
  final double height;
  HomePageListWidget({this.dateString,this.expanded,this.height});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(7),
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: AppColors.itemColor,
//        borderRadius: BorderRadius.circular(10),
          border: Border(left: BorderSide(color: AppColors.green,width: 10),),
          boxShadow: [
            BoxShadow(
                color: Colors.black54,
                blurRadius: 15.0,
                offset: Offset(0.0, 2.25)
            )
          ]
        ),
        child: Center(
          child: Padding(
            padding: SizeConfig.sidepadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(dateString,style: AppStyles.BlackStyleWithBold_Font36(context).copyWith(
                  fontWeight: FontWeight.w400
                ),),
                SizedBox(child: Image.asset(expanded?ImageFile.downArrow:ImageFile.rightArrow),
                height: SizeConfig.screenHeight*0.02,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
