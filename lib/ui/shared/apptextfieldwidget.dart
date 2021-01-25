import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/size_config.dart';
import 'package:flutter/material.dart';
class AppTextField extends StatelessWidget {
  double width;
  String hintText;
  bool obsecureText;
  TextEditingController controller;
  TextStyle style;
  bool autoValidation;
  AppTextField({this.width,this.hintText,this.controller,this.obsecureText:false,this.style,this.autoValidation});
  @override
  Widget build(BuildContext context) {
    print("style"+style.toString());
    return Form(
      autovalidate: autoValidation,
      child: Container(
        width: width??SizeConfig.screenWidth,
        decoration: BoxDecoration(
          color: AppColors.whiteColor
        ),
        child: Padding(
          padding: SizeConfig.sidepadding,
          child: TextFormField(
            controller: controller,
            obscureText: obsecureText,
            decoration: InputDecoration(
              //isDense: true,
              contentPadding: EdgeInsets.only(bottom:0,top: MediaQuery.of(context).size.width*0.015),
              hintText: hintText,
              labelStyle: style,
              border: InputBorder.none,
            ),
            validator: (value){
              if(value.isEmpty){
                return 'required';
              }
              else
                return null;
            },
          ),
        ),
      ),
    );
  }
}
