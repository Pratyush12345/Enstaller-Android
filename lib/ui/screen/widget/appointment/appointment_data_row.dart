import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/size_config.dart';
import 'package:flutter/material.dart';

class AppointmentDataRow extends StatelessWidget {
  final String firstText;
  final String secondText;
  final Widget secondChild;
  AppointmentDataRow({this.firstText,this.secondText,this.secondChild});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: firstText == "Serial Number" ? AppColors.green : Colors.white,
        border: Border(
          bottom: BorderSide(
            color: AppColors.lightGrayDotColor
          )
        )
      ),
      child:  Padding(
        padding: SizeConfig.padding,
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: Text(
                  firstText,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: firstText == "Serial Number"? Colors.black54 : AppColors.darkGrayColor,
                    fontWeight: firstText == "Serial Number"? FontWeight.bold: FontWeight.normal),
                )),
            SizeConfig.horizontalSpaceMedium(),
            Expanded(
                flex: 3,
                child: secondChild!=null?secondChild:Text(
                  secondText,
                  style: TextStyle(color: secondText == "Item Name"? Colors.black54 : AppColors.darkGrayColor,
                  fontWeight: secondText == "Item Name"? FontWeight.bold: FontWeight.normal),
                  textAlign: TextAlign.start,
                )),
          ],
        ),
      ),
    );
  }
}
