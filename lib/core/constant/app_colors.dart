
import 'package:enstaller/core/constant/app_string.dart';
import 'package:flutter/material.dart';


class AppColors{

  static const Color primaryColor = Color(0xFF27BB8B);
  static  Color yellow=Color(0xFFFC00).withOpacity(1);
  static  Color  backgroundColor = Color(0xFFEDEDEB);
  static const Color facebookButtonColor = Color(0xFF3b5998);
  static const Color scafoldColor=Color(0xFFE9E8E8);
  static const Color itemColor=Color(0xFFFFFFFF);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color blackFontColor = Color(0xFF333333);
  static const Color black = Color(0xFF000000);
  static const Color lightGreyColor = Color(0xFFDEDEDE);
  static const Color lightGrayDotColor = Color(0xFFD8D8D8);
  static const Color darkGrayColor = Color(0xFF777777);
  static const Color darkGrayLittleColor = Color(0xFF9B9B9B);
  static const Color lightGrayLittleColor = Color(0xFFDDDDDD);
  static const Color appointmentBackGroundColor=Color(0xFFFFFFFF);
  static const Color grayBackgroundColor=Color(0xF7F7F7);
  static final Color amber=Color(0xFFB892).withOpacity(1);
  static final Color red=Color(0xF81B08).withOpacity(1);
  static final Color veryLightGrayColor=Color(0xF6F6F6).withOpacity(1);
  static final Color activeColor=Color(0x28BE8C).withOpacity(1);
  static final Color appbarColor = Color(0xff011345);
  static final Color oddListColor = Color(0xfffaa50a);
  static final Color evenListColor = Color(0xffdf4344);
  static final Color rightFirstRectangleSize = Color(0xfff8d68e);
  static final Color rightAllRectangleSize = Color(0xfff2b1af);
  static final Color transparentCircle = Color(0xffce8101);
  static final Color transparentCircleAll = Color(0xffb23032);

  static const Color greenLigthColorMarkerCircle1=Color.fromRGBO(39, 187, 139, 0.09);
  static const Color greenLigthColorMarkerCircle2= Color.fromRGBO(39, 187, 139, 0.06);
  static const Color greenLigthColorMarkerCircle3= Color.fromRGBO(39, 187, 139, 0.04);
  static const Color firstItemColor=Color(0xFFEFEFFF);
  static const Color secondItemColor=Color(0xFFFFF1F1);
  static const Color thirdItemColor=Color(0xFFFAFAFA);
  static const Color expansionColor=Color(0xFFFAFAFA);
  static const Color blue=Color(0xFF0070C3);
  static const expandedColor=Color(0xFFFFFFFF);
  static const Color darkBlue=Color(0xFF10163C);

  static const Color green=Color(0xFF3BBDA3);
  static final loginTopColor=Color(0x909CF2).withOpacity(1);
  static final errorContainerColor=Color(0xFFE8C8C6);
  static Color loginBottomColor=Color(0xFFF7F7F7);
  static Color loginTextBacground=Color(0xFFE3E0E0);
  static Color loginButtonColor=Color(0xFF3BBDA3);
  static  LinearGradient logInLinearGradient=LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [ 0.0, .5],
    colors: [
      loginTopColor,
      Color(0x19365A).withOpacity(.95),
    ],
  );

  static Color statusColor(String status){
    if(status==AppStrings.booked){
      return Colors.grey;
    }else if(status==AppStrings.EnRoute){
      return Colors.blue;
    }else if(status==AppStrings.onSite){
      return Colors.yellow;
    }else if(status==AppStrings.started){
      return Colors.orangeAccent;
    }else if(status==AppStrings.completed){
      return Colors.green;
    }else if(status==AppStrings.aborted){
      return Colors.red;
    }else if(status==AppStrings.scheduled){
      return Colors.grey;
    }else if(status==AppStrings.unScheduled){
      return Colors.grey;
    }else if(status==AppStrings.cancelled){
      return Colors.red;
    }else{
      return Colors.orangeAccent;
    }
  }

}




