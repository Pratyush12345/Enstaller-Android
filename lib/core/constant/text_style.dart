import 'package:enstaller/core/constant/size_config.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

//Styles are sorted by color
class AppStyles {

  static TextStyle loginTitle=TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: SizeConfig.screenHeight*.032,color: AppColors.black,
  );

  static TextStyle LightStyleText(BuildContext context)=>TextStyle(
    shadows: [
      Shadow(
        blurRadius: 10.0,
        color: Colors.grey[800],
        offset: Offset(5.0, 5.0),
      ),
    ],
    letterSpacing: 2,
    fontWeight: FontWeight.w300,
    fontSize: SizeConfig.screenHeight*.032,color: AppColors.whiteColor,
  );
  static TextStyle WhiteLightThemeTextStyle(BuildContext context)=>TextStyle(fontSize: SizeConfig.screenHeight*.022,color:Colors.grey[400],letterSpacing: 1.5,);
  static TextStyle blueLightThemeTextStyle(BuildContext context)=>TextStyle(fontSize: SizeConfig.screenHeight*.021,color:AppColors.blue,letterSpacing: 1.5,fontWeight: FontWeight.w800);

  //Green color
  static TextStyle GreenStyleWithBold900_Font40(BuildContext context)=> TextStyle(color:Theme.of(context).primaryColor,fontSize: SizeConfig.fontSizeLargeExtraLarge,fontWeight:FontWeight.w900);
  static TextStyle GreenStyleWithBold800_Font16(BuildContext context)=> TextStyle(color:Theme.of(context).primaryColor, fontSize: SizeConfig.fontSizeSmall, fontWeight: FontWeight.w800);
  static TextStyle GreenStyleWithBold600_Font16(BuildContext context)=> TextStyle(color:Theme.of(context).primaryColor, fontSize: SizeConfig.fontSizeSmall, fontWeight: FontWeight.w600);
  static TextStyle GreenStyleWith_Font16(BuildContext context)=> TextStyle(color:Theme.of(context).primaryColor, fontSize: SizeConfig.fontSizeSmall);
  static TextStyle GreenStyleWithBold800_Font20(BuildContext context)=> TextStyle(color:Theme.of(context).primaryColor, fontSize: SizeConfig.fontSizeMedium, fontWeight: FontWeight.w800);
  static TextStyle GreenStyleWithBold800_Font26(BuildContext context)=> TextStyle(color:Theme.of(context).primaryColor, fontSize: SizeConfig.fontSizeMedium, fontWeight: FontWeight.w800);
  static TextStyle GreenStyleWithBold900Font_36(BuildContext context)=>TextStyle(color: Theme.of(context).primaryColor,fontSize:SizeConfig.fontSizeLargeVeryLarge,fontWeight:FontWeight.w900);
  static TextStyle GreenStyleWithBold700Font_36(BuildContext context)=>TextStyle(color: Theme.of(context).primaryColor,fontSize:SizeConfig.fontSizeLargeVeryLarge,fontWeight:FontWeight.w700);
  static TextStyle GreenStyle_Font10(BuildContext context)=> TextStyle(color:Theme.of(context).primaryColor, fontSize: SizeConfig.fontSizeVerySmall);
  static TextStyle GreenStyle_Font20(BuildContext context)=> TextStyle(color:Theme.of(context).primaryColor, fontSize: SizeConfig.fontSizeMedium,);
  static TextStyle GreenStyle_FontW50014(BuildContext context)=> TextStyle(color:Theme.of(context).primaryColor,fontSize: SizeConfig.fontSizeSmallVeryMedium,fontWeight: FontWeight.w500);
  static TextStyle GreenStyleWithBoldFont_24(BuildContext context)=>TextStyle(fontSize: SizeConfig.fontSizeLarger, fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor);
  static TextStyle GreenStyleWithw500Font_24(BuildContext context)=>TextStyle(fontSize: SizeConfig.fontSizeLarger, fontWeight: FontWeight.w500,color: Theme.of(context).primaryColor);

  static TextStyle GreenStyleWithNormalFont_24(BuildContext context)=>TextStyle(fontSize: SizeConfig.fontSizeMedium, fontWeight: FontWeight.w300,color:Theme.of(context).primaryColor);
  static TextStyle GreenStyleWithBoldFont_C20(BuildContext context)=>TextStyle(fontSize: SizeConfig.forntSize20, fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor);

  static TextStyle GreenStyleWithBold800_Font40(BuildContext context)=>TextStyle(color:Theme.of(context).primaryColor,fontSize:SizeConfig.fontSizeLargeExtraLarge,fontWeight:FontWeight.w800);




//black color
  static TextStyle BlackStyle_Font12(BuildContext context)=>TextStyle(color: Theme.of(context).focusColor, fontSize: 12);
  static TextStyle BlackStyleWithBold700_Font40(BuildContext context) =>TextStyle(color: Theme.of(context).focusColor,fontSize: SizeConfig.fontSizeLargeExtraLarge,fontWeight:FontWeight.w700);
  static TextStyle BlackStyleWithBold900_Font40(BuildContext context) =>TextStyle(color: Theme.of(context).focusColor,fontSize: SizeConfig.fontSizeLargeExtraLarge,fontWeight:FontWeight.w900);
  static TextStyle BlackStyleWithBold700_C30(BuildContext context) =>TextStyle(color: Theme.of(context).focusColor,fontSize: 30,fontWeight:FontWeight.w700);
  static TextStyle BlackStyleWithBold800Font_16(BuildContext context) =>TextStyle(fontSize:SizeConfig.fontSizeSmall, fontWeight: FontWeight.w800,color: Theme.of(context).focusColor);
  static TextStyle BlackStyleWithBold600Font_16(BuildContext context) =>TextStyle(fontSize:SizeConfig.fontSizeSmall, fontWeight: FontWeight.w600,color: Theme.of(context).focusColor);
  static TextStyle BlackStyleWithBold800Font_12(BuildContext context) =>TextStyle(fontSize:SizeConfig.fontSizeSmallVeryMedium, fontWeight: FontWeight.w700,color: Theme.of(context).focusColor);
  static  BlackStyleWithBold700Font_18(BuildContext context)=>TextStyle(fontWeight: FontWeight.w700,fontSize: 12 ,
      color: Theme.of(context).focusColor);
  static TextStyle BlackStyleWithBold800Font_20(BuildContext context)=>TextStyle(fontSize: SizeConfig.fontSizeMedium, fontWeight: FontWeight.w800,
      color: Theme.of(context).focusColor);

  static TextStyle BlackStyleWithBold500Font_10(BuildContext context)=>TextStyle(fontSize: SizeConfig.fontSizeMedium, fontWeight: FontWeight.w500,
      color: Theme.of(context).focusColor);
  static TextStyle BlackStyleWithBold600Font_20(BuildContext context)=>TextStyle(fontSize: SizeConfig.fontSizeMedium, fontWeight: FontWeight.w600,
      color: Theme.of(context).focusColor);
  static TextStyle BlackStyleWithBold700Font_14(BuildContext context)=>TextStyle(fontSize: SizeConfig.fontSizeSmallVeryMedium, fontWeight: FontWeight.w700,
      color: Theme.of(context).focusColor);
  static TextStyle BlackStyleWithBold500Font_14(BuildContext context)=>TextStyle(fontSize: SizeConfig.fontSizeSmallVeryMedium, fontWeight: FontWeight.w500,
      color: Theme.of(context).focusColor);
  static TextStyle BlackStyleWithFont_15(BuildContext context)=>TextStyle(fontSize: 13, fontWeight: FontWeight.normal,
      color: Theme.of(context).focusColor);
  static TextStyle BlackStyleWithBoldW700Font_15(BuildContext context)=>TextStyle(fontSize: 13, fontWeight: FontWeight.w500,color: Theme.of(context).focusColor);
  static TextStyle BlackStyleWithBold900Font_20(BuildContext context)=>TextStyle(color: Theme.of(context).focusColor,
      fontSize:SizeConfig.fontSizeMedium,fontWeight:FontWeight.w900);
  static TextStyle BlackStyleWithBold700Font_16(BuildContext context) =>TextStyle(fontSize:SizeConfig.fontSizeSmall, fontWeight: FontWeight.w700,color: Theme.of(context).focusColor);
  static TextStyle BlackStyleFont_16(BuildContext context) =>TextStyle(fontSize:SizeConfig.fontSizeSmall,color: Theme.of(context).focusColor);
  static TextStyle BlackUnderlineStyleFont_16(BuildContext context) =>TextStyle(fontSize:SizeConfig.fontSizeSmall,fontWeight: FontWeight.w500,
      color: Theme.of(context).focusColor,decoration: TextDecoration.underline);
  static TextStyle BlackStyleFontW600_12(BuildContext context) =>TextStyle(fontSize:12,color: Theme.of(context).focusColor,fontWeight: FontWeight.w600);
  static TextStyle BlackStyleW500Font_16(BuildContext context) =>TextStyle(fontSize:SizeConfig.fontSizeSmall,color: Theme.of(context).focusColor,
      fontWeight: FontWeight.w500);
  static TextStyle BlackStyleW500FontC16(BuildContext context) =>TextStyle(fontSize:16,color: Theme.of(context).focusColor,
      fontWeight: FontWeight.w500);
  static TextStyle  BlackStyleFont_20(BuildContext context) =>TextStyle(fontSize:SizeConfig.fontSizeMedium,color: Theme.of(context).focusColor);
  static TextStyle  BlackStyleFontw600_c13(BuildContext context) =>TextStyle(fontSize:SizeConfig.fontSizeMedium,color: Theme.of(context).focusColor,fontWeight: FontWeight.w600);
  static TextStyle  BlackStyleFontWeightSmall_20(BuildContext context) =>TextStyle(fontSize:SizeConfig.fontSizeMedium,color: Theme.of(context).focusColor, fontWeight: FontWeight.w400);
  static TextStyle  BlackStyleFontWeightSmall_24(BuildContext context) =>TextStyle(fontSize:SizeConfig.fontSizeLarge,color: Theme.of(context).focusColor, fontWeight: FontWeight.w300);
  static TextStyle BlackStyleFont_14(BuildContext context) =>TextStyle(fontSize:SizeConfig.fontSizeSmallVeryMedium,color: Theme.of(context).focusColor);
  static TextStyle BlackStyleWithBold500_Font16(BuildContext context)=>TextStyle(color: Theme.of(context).focusColor, fontSize: SizeConfig.fontSizeSmall, fontWeight: FontWeight.w500);
  static TextStyle BlackStyleWithBold800Font_24(BuildContext context)=>TextStyle(fontSize: SizeConfig.fontSizeLarge, fontWeight: FontWeight.w800,color: Theme.of(context).focusColor);
  static TextStyle BlackStyleWithBoldFont_24(BuildContext context)=>TextStyle(fontSize: SizeConfig.fontSizeLarge, fontWeight: FontWeight.bold,color: Theme.of(context).focusColor);
  static TextStyle BlackStyleWithBold600Font_24(BuildContext context)=>TextStyle(fontSize: SizeConfig.fontSizeLarge, fontWeight: FontWeight.w600,color:Theme.of(context).focusColor);
  static TextStyle BlackStyleWithBold_Font36(BuildContext context) =>TextStyle(color:Theme.of(context).focusColor,fontSize: SizeConfig.fontSizeLargeVeryLarge,fontWeight:FontWeight.bold);
  static TextStyle BlackStyleWithBold_FontC20(BuildContext context) =>TextStyle(color: Theme.of(context).focusColor,fontSize: SizeConfig.forntSize20,fontWeight:FontWeight.bold);
  static TextStyle BlackStyleWithNormal_Font36(BuildContext context) =>TextStyle(color: Theme.of(context).focusColor,
      fontSize: SizeConfig.fontSizeLargest,fontWeight:FontWeight.w300);
  static TextStyle BlackStyleWithBold_Font30(BuildContext context) =>TextStyle(color: Theme.of(context).focusColor,fontSize: SizeConfig.fontSizeLargest,fontWeight:FontWeight.bold);
  static TextStyle BlackStyle_Font10(BuildContext context)=> TextStyle(color:Theme.of(context).focusColor, fontSize: SizeConfig.fontSizeVerySmall);
  static TextStyle  BlackStyleFontWeight500_24(BuildContext context) =>TextStyle(fontSize:SizeConfig.fontSizeLarge,color: Theme.of(context).focusColor,
      fontWeight: FontWeight.w500);
  static TextStyle BlackStyleFont300_16(BuildContext context) =>TextStyle(fontSize:SizeConfig.fontSizeSmall,color: Theme.of(context).focusColor,fontWeight: FontWeight.w500);
  static TextStyle  BlackStyleFontw300_20(BuildContext context) =>TextStyle(fontSize:SizeConfig.fontSizeMedium,color: Theme.of(context).focusColor,fontWeight: FontWeight.w300);

  static TextStyle  BlackStyleFontWeight500_13(BuildContext context) =>TextStyle(fontSize:13,color: Theme.of(context).focusColor, fontWeight: FontWeight.w500);
  static TextStyle  BlackStyleFontWeightSmall_12(BuildContext context) =>TextStyle(fontSize:12,color: Theme.of(context).focusColor, fontWeight: FontWeight.w400);
  static TextStyle  BlackStyleFontWeightSmall_15(BuildContext context) =>TextStyle(fontSize:15,color: Theme.of(context).focusColor, fontWeight: FontWeight.w300);
  static TextStyle  BlackStyleFontWeightSmall_17(BuildContext context) =>TextStyle(fontSize:17,color: Theme.of(context).focusColor, fontWeight: FontWeight.w300);
  static TextStyle BlackStyleFont_12(BuildContext context) =>TextStyle(fontSize:10,color: Theme.of(context).focusColor);
  static TextStyle BlackStyleW600Font_12(BuildContext context) =>TextStyle(fontSize:10,color: Theme.of(context).focusColor,fontWeight: FontWeight.w600);
  static TextStyle  BlackStyleFont_c16(BuildContext context) =>TextStyle(fontSize:SizeConfig.fontSizeLarge,color: Theme.of(context).focusColor);
  static TextStyle BlackStyleWithw500_FontC18(BuildContext context) =>TextStyle(color: Theme.of(context).focusColor,fontSize: SizeConfig.fontSizeLarger,fontWeight:FontWeight.w500);
  static TextStyle BlackStyleWithBold_FontC18(BuildContext context) =>TextStyle(color: Theme.of(context).focusColor,fontSize: SizeConfig.fontSizeLarger,fontWeight:FontWeight.bold);
  static TextStyle BlackStyleNormal_FontC18(BuildContext context) =>TextStyle(color:Theme.of(context).focusColor,fontSize: SizeConfig.fontSizeLarger);


//white color
  static TextStyle WhiteStyle_Font16=TextStyle(fontSize:SizeConfig.fontSizeSmall,color: Colors.white);
  static TextStyle WhiteStyle_Font20=TextStyle(fontSize: SizeConfig.fontSizeMedium,color:Colors.white,);
  static TextStyle WhiteStyle_WithBold900_Font20=TextStyle(fontSize: SizeConfig.fontSizeMedium,color:Colors.white,fontWeight: FontWeight.w900,);
  static TextStyle WhiteStyle_WithBold700_Font20=TextStyle(fontSize: SizeConfig.fontSizeMedium,color:Colors.white,fontWeight: FontWeight.w700,);
  static TextStyle WhiteStyleWithBold600_Font16= TextStyle(color:AppColors.whiteColor, fontSize: SizeConfig.fontSizeSmall, fontWeight: FontWeight.w600);
  static TextStyle WhiteStyleWithBold800_Font16= TextStyle(color:AppColors.whiteColor, fontSize: SizeConfig.fontSizeSmall, fontWeight: FontWeight.w800);
  //gray color
  static TextStyle GrayStyleWithBold500_Font16(BuildContext context)=>TextStyle(color: AppColors.lightGreyColor, fontSize: SizeConfig.fontSizeSmall, fontWeight: FontWeight.w500);
  static TextStyle GrayStyle_Font16(BuildContext context)=>TextStyle(color: AppColors.lightGreyColor, fontSize: SizeConfig.fontSizeSmall);
  static TextStyle GrayStyle_Font9(BuildContext context)=>TextStyle(color:AppColors.lightGreyColor, fontSize: 9);
  static TextStyle GrayStyle_Font24(BuildContext context)=>TextStyle(color: AppColors.lightGreyColor, fontSize: SizeConfig.fontSizeLarge);
  static TextStyle GrayStyle_Font12(BuildContext context)=>TextStyle(color:AppColors.lightGreyColor, fontSize: 12);
  static TextStyle GrayStyle_FontC12W600(BuildContext context)=>TextStyle(color: AppColors.lightGreyColor, fontSize: 12,fontWeight: FontWeight.w600);
  static TextStyle GrayStyle_Font10(BuildContext context)=>TextStyle(color: AppColors.lightGreyColor, fontSize: 10);

  //dark gray
  static TextStyle darkGrayStyle_Font16=TextStyle(color: AppColors.darkGrayColor, fontSize: SizeConfig.fontSizeSmall);
  static TextStyle GrayStyle_Font20= TextStyle(color:AppColors.darkGrayColor, fontSize: SizeConfig.fontSizeMedium,);


  //dark gray little
  static TextStyle darkGrayLittleStyle_Font10=TextStyle(color: AppColors.darkGrayLittleColor, fontSize: SizeConfig.fontSizeVerySmall);


  //dynamic
  static TextStyle GreenStyleWithw500Font_d24(BuildContext context)=>TextStyle(fontSize: SizeConfig.screenHeight*.022, fontWeight: FontWeight.w500,color: Theme.of(context).primaryColor);
  static TextStyle  BlackStyleFontWeight500_d24(BuildContext context) =>TextStyle(fontSize:SizeConfig.screenHeight*.022,color: Theme.of(context).focusColor, fontWeight: FontWeight.w500);
  static TextStyle  grayStyleFontWeight300_d02 =TextStyle(fontSize:SizeConfig.screenHeight*.02,color: AppColors.lightGreyColor, fontWeight: FontWeight.w300);
  static TextStyle BlackStyleWithBold700_D30(BuildContext context) =>TextStyle(color: Theme.of(context).focusColor,fontSize: SizeConfig.screenHeight*.04,fontWeight:FontWeight.w700);
  static TextStyle GreenStyleWithw500Font_d20(BuildContext context)=>TextStyle(fontSize: SizeConfig.screenHeight*.024, fontWeight: FontWeight.w500,color: Theme.of(context).primaryColor);
  static TextStyle BlackStyleWithw500_Fontd18(BuildContext context) =>TextStyle(color: Theme.of(context).focusColor,fontSize: SizeConfig.screenHeight*.024,fontWeight:FontWeight.w500);


  //green

  static TextStyle GreenStyle_Font=TextStyle(fontSize:SizeConfig.fontSizeLarge,color: AppColors.green);

}