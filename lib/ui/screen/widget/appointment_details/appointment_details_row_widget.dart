import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/size_config.dart';
import 'package:flutter/material.dart';

class  AppointmentDetailsRowWidget extends StatelessWidget {
  final String firstText;
  final String secondText;
  final Widget secondChild;
  final bool borderEnable;
  AppointmentDetailsRowWidget({this.secondChild,this.secondText,this.firstText,this.borderEnable:true});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: borderEnable?Border(
              bottom: BorderSide(
                  color: AppColors.lightGrayDotColor
              )
          ):Border()
      ),
      child:  Padding(
        padding: SizeConfig.mediumPadding,
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Text(
                  firstText,
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.normal),
                )),
            SizeConfig.horizontalSpaceMedium(),
            Expanded(
                flex: 1,
                child: secondChild!=null?secondChild:Text(
                  secondText,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.end,
                )),
          ],
        ),
      ),
    );
  }
}
