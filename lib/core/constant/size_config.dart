

import 'package:flutter/material.dart';

class SizeConfig {
  static double screenWidth;
  static double screenHeight;
  static double appBarHeight;

  //font size
  static double fontSizeLargeExtraLarge;
  static double fontSizeMedium;

  static double fontSizeVerySmall;
  static double fontSizeSmall;
  static double fontSizeLarge;
  static double fontSizeLarger;
  static double fontSizeLargeVeryLarge;
  static double forntSize20;
  static double fontSizeSmallVeryMedium;
  static double fontSizeLargest;
  static double fontSizeLargestBig;
  static double cameraContainerSize;
  static double fileImageContainerSize;

  //radius
  static double introGetStarted_button_Radius;
  static double radiusSmall;
  static double radiusBig;
  static double borderRadius=20;

  //icon size
  static double iconSize;
  static double tabIconSize;
  static double smallIconSize;
  static double mediumIconSize;
  static double smallerIconSize;

  //distance from views to screenBorder
  static double horizontalGap;
  static double appBarIconSize;
  static double verticalGap;
  static double textFieldHeight=55;
  static double mediumIcon=30;
  static double largeIcon=40;
  static double serachAppbarheight=70;


  static sizeConfigInit(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    int orgScreenWidth = screenWidth.round();
    int orgScreenHeight = screenHeight.round();

    appBarHeight=105;

    fontSizeLargeExtraLarge = 28;
    cameraContainerSize=350;
    fileImageContainerSize=390;
    fontSizeMedium = 14;
    fontSizeSmall = 11;
    fontSizeVerySmall = 8;
    fontSizeSmallVeryMedium = 12;
    fontSizeLarge = 16;
    fontSizeLarger = 18;
    fontSizeLargeVeryLarge = 24;
    forntSize20=20;
    fontSizeLargest=22;
    fontSizeLargestBig = 28;
    smallIconSize=15;
    smallerIconSize=12;
    mediumIconSize=25;


    //radius
    introGetStarted_button_Radius = orgScreenHeight * 0.02;
    radiusSmall = orgScreenHeight * 0.01;
    radiusBig = orgScreenHeight * 0.03;
    iconSize = orgScreenWidth * 0.05;
    tabIconSize = orgScreenHeight * 0.03;

    horizontalGap = SizeConfig.screenWidth*.09;
    appBarIconSize = 24;
    verticalGap=SizeConfig.screenHeight*.015;
  }

  // Vertical spacing constants. Adjust to your liking.
  static double _VerticalSpaceSmall = screenHeight * 0.01;
  static double _VerticalSpaceSmallMedium = screenHeight * 0.02;
  static double VerticalSpaceMedium = screenHeight * 0.03;
  static double _VerticalSpaceExtraMedium = screenHeight * 0.04;
  static double _VerticalSpaceBigMedium = screenHeight * 0.05;
  static double _VerticalSpaceLarge = screenHeight * 0.07;
  static double _VerticalSpaceELarge=screenHeight*.11;
  static double _verticalSpaceLargeBig = screenHeight * 0.14;
  static double _verticalSpaceBig = screenHeight * 0.12;
  static double _verticalSpaceExtraLarge = screenHeight * 0.2;

  // Vertical spacing constants. Adjust to your liking.
  static const double _HorizontalSpaceSmall = 10.0;
  static const double _HorizontalSpaceMedium = 20.0;
  static const double HorizontalSpaceLarge = 60.0;
  static const double HorizontalSpaceBig = 40.0;
  static  double ContainerHeight_widthLarge = screenHeight*.15;

  //image height
  static const double smallerImageHeight=45;
  static const double smallImageHeight55=55;
  static const double smallImageHeight60=60;

  static const double smallImageheight=80;
  static const double orderStatusContainerheight=235;
  static const double imageheight90=90;
  static const double smallerImageheight=70;
  static const double smallerImageheight75=75;
  static const double mediumImageheight=100;
  static const double BigImageheight=120;
  static const double BigerImageheight=130;
  static const double imageHeight140=140;
  static const double buttonHeight=55;


  /// Returns a vertical space with height set to [_VerticalSpaceSmall]
  static Widget verticalSpaceSmall() {
    return verticalSpace(_VerticalSpaceSmall);
  }

  /// Returns a vertical space with height set to [_VerticalSpaceSmallMedium]
  static Widget VerticalSpaceSmallMedium() {
    return verticalSpace(_VerticalSpaceSmallMedium);
  }
  static Widget VerticalSpaceExtraLarge() {
    return verticalSpace(_VerticalSpaceELarge);
  }
  static Widget CVerticalSpaceSmallMedium() {
    return verticalSpace(10);
  }
  static Widget CVerticalSpaceSmallMediumC11() {
    return verticalSpace(11);
  }
  static Widget CVerticalSpaceSmallMediumC12() {
    return verticalSpace(12);
  }

  static Widget CVerticalSpacevMedium() {
    return verticalSpace(15);
  }
  static Widget CVerticalSpaceVarySmall() {
    return verticalSpace(5);
  }
  static Widget CVerticalSpaceMedium() {
    return verticalSpace(20);
  }
  static Widget CVerticalSpaceMedium25() {
    return verticalSpace(25);
  }
  static Widget CVerticalSpacevEMedium() {
    return verticalSpace(30);
  }

  static Widget CVerticalSpaceBig() {
    return verticalSpace(40);
  }
  static Widget CVerticalSpaceBig43() {
    return verticalSpace(43);
  }
  static Widget CVerticalSpaceBigger() {
    return verticalSpace(50);
  }
  static Widget CVerticalSpace55() {
    return verticalSpace(55);
  }
  static Widget CVerticalSpace60() {
    return verticalSpace(60);
  }
  static Widget CVerticalSpaceExtraBig() {
    return verticalSpace(70);
  }
  static Widget CVerticalSpaceExtra80() {
    return verticalSpace(80);
  }
  static Widget CVerticalSpaceExtra90() {
    return verticalSpace(90);
  }
  static Widget CVerticalSpaceExtra110() {
    return verticalSpace(110);
  }

  /// Returns a vertical space with height set to [VerticalSpaceMedium]
  static Widget verticalSpaceMedium() {
    return verticalSpace(VerticalSpaceMedium);
  }

  static Widget verticalSpaceExtraMedium() {
    return verticalSpace(_VerticalSpaceExtraMedium);
  }

  static Widget verticalSpaceBigMedium() {
    return verticalSpace(_VerticalSpaceBigMedium);
  }

  /// Returns a vertical space with height set to [_VerticalSpaceLarge]
  static Widget verticalSpaceLarge() {
    return verticalSpace(_VerticalSpaceLarge);
  }

  static Widget verticalSpaceLargeBig() {
    return verticalSpace(_verticalSpaceLargeBig);
  }
  static Widget verticalSpaceBig() {
    return verticalSpace(_verticalSpaceBig);
  }

  static Widget verticalSpaceExtraLarge() {
    return verticalSpace(_verticalSpaceExtraLarge);
  }

  /// Returns a vertical space equal to the [height] supplied
  static Widget verticalSpace(double height) {
    return Container(height: height);
  }

  /// Returns a vertical space with height set to [_HorizontalSpaceSmall]
  static Widget horizontalSpaceSmall() {
    return horizontalSpace(_HorizontalSpaceSmall);
  }

  /// Returns a vertical space with height set to [_HorizontalSpaceMedium]
  static Widget horizontalSpaceMedium() {
    return horizontalSpace(_HorizontalSpaceMedium);
  }

  static EdgeInsets get constantSidePadding=>EdgeInsets.only(
      left: 20,right:20 ) ;
  static EdgeInsets get constantPadding=>EdgeInsets.only(
      left: 20,right:20,top: 20,
      bottom:  20) ;
  static EdgeInsets get topIconPadding=>EdgeInsets.only(
      right:screenWidth * 0.04,top: screenHeight*.08) ;

  static EdgeInsets get sidepadding=>EdgeInsets.only(
      left: screenWidth * 0.04,right:screenWidth * 0.04 ) ;
  static EdgeInsets get sidelargepadding=>EdgeInsets.only(
      left: 30,right:30 ) ;
  static EdgeInsets get innersidepadding=>EdgeInsets.only(
      left: screenWidth * 0.02,right:screenWidth * 0.02 ) ;
  static EdgeInsets get innerMediumPadding=>EdgeInsets.only(
      left: screenWidth * 0.03,right:screenWidth * 0.03 ,top: screenHeight*.008,
      bottom:  screenHeight*.008) ;
  static EdgeInsets get padding=>EdgeInsets.only(
      left: screenWidth * 0.04,right:screenWidth * 0.04,top: screenHeight*.01,
      bottom:  screenHeight*.01) ;
  static EdgeInsets get paddingMediumhighSide=>EdgeInsets.only(
      left: screenWidth * 0.043,right:screenWidth * 0.043,top: screenHeight*.016,
      bottom:  screenHeight*.016) ;
  static EdgeInsets get smallpadding=>EdgeInsets.only(
      left: screenWidth * 0.02,right:screenWidth * 0.02,top: screenHeight*.005,
      bottom:  screenHeight*.005) ;
  static EdgeInsets get paddingWihLittleHeight=>EdgeInsets.only(
      left: screenWidth * 0.04,right:screenWidth * 0.04,top: screenHeight*.015,
      bottom:  screenHeight*.015) ;
  static EdgeInsets get paddingWihLittleHeight018=>EdgeInsets.only(
      left: screenWidth * 0.04,right:screenWidth * 0.04,top: screenHeight*.018,
      bottom:  screenHeight*.018) ;
  static EdgeInsets get mediumpadding=>EdgeInsets.only(
      left: screenWidth * 0.05,right:screenWidth * 0.05,top: screenHeight*.015,
      bottom:  screenHeight*.015) ;
  static EdgeInsets get innerpadding=>EdgeInsets.only(
      left: screenWidth * 0.02,right:screenWidth * 0.02,top: screenHeight*.016,
      bottom:  screenHeight*.016) ;
  static EdgeInsets get smallinnerpadding=>EdgeInsets.only(
      left: screenWidth * 0.02,right:screenWidth * 0.02,top: screenHeight*.005,
      bottom:  screenHeight*.005) ;
  static EdgeInsets get paddingHeighy02=>EdgeInsets.only(
      left: screenWidth * 0.04,right:screenWidth * 0.04,top: screenHeight*.012,
      bottom:  screenHeight*.012) ;
  static EdgeInsets get paddingHeighy01=>EdgeInsets.only(
      left: screenWidth * 0.04,right:screenWidth * 0.04,top: screenHeight*.008,
      bottom:  screenHeight*.008) ;
  static EdgeInsets get smalltpadding=>EdgeInsets.only(
      left: screenWidth * 0.04,right:screenWidth * 0.04,top: screenHeight*.005,
      bottom:  screenHeight*.007) ;

  static EdgeInsets get smallerpadding=>EdgeInsets.only(
      left: screenWidth * 0.04,right:screenWidth * 0.04,top: screenHeight*.0025,
      bottom:  screenHeight*.0025) ;
  static EdgeInsets get largePadding=>EdgeInsets.only(
      left: screenWidth * 0.12,right:screenWidth * 0.12,top: screenHeight*.01,
      bottom:  screenHeight*.01) ;
  static EdgeInsets get mediumPadding=>EdgeInsets.only(
      left: screenWidth * 0.037,right:screenWidth * 0.037,top: screenHeight*.016,
      bottom:  screenHeight*.016) ;
  static EdgeInsets get mediumCPadding=>EdgeInsets.only(
      left: screenWidth * 0.037,right:screenWidth * 0.037,top: 10,
      bottom:  10) ;
  static EdgeInsets get smallerPadding=>EdgeInsets.only(
      left: screenWidth * 0.037,right:screenWidth * 0.037,top: screenHeight*.012,
      bottom:  screenHeight*.012) ;
  static EdgeInsets get cmediumPadding=>EdgeInsets.only(
      left: screenWidth * 0.05,right:screenWidth * 0.05,top: 18,
      bottom:  18) ;
  static EdgeInsets get verticalPadding=>EdgeInsets.only(
      bottom:screenHeight * 0.005,top: screenHeight*.0005) ;
  static EdgeInsets get bottomPadding=>EdgeInsets.only(
    bottom:screenHeight * 0.015,) ;
  static EdgeInsets get bottomsmallPadding=>EdgeInsets.only(
    bottom:screenHeight * 0.005,) ;
  static EdgeInsets get verticalBigPadding=>EdgeInsets.only(
      bottom:screenHeight * 0.009,top: screenHeight*.009) ;
  static EdgeInsets get verticalLarPadding=>EdgeInsets.only(
      bottom:15,top: 15) ;
  static EdgeInsets get verticalC13Padding=>EdgeInsets.only(
      bottom:13,top: 13) ;
  static EdgeInsets get verticalC8Padding=>EdgeInsets.only(
      bottom:8,top: 8) ;
  static EdgeInsets get paddingC13=>EdgeInsets.only(
      left: 13,right: 13,
      bottom:13,top: 13) ;
  static EdgeInsets get verticalMediumPadding=>EdgeInsets.only(
      bottom:screenHeight * 0.004,top: screenHeight*.004) ;
  static EdgeInsets get sidebottompadding=>EdgeInsets.only(
      left: screenWidth * 0.04,right:screenWidth * 0.04 ,bottom: screenHeight*.015) ;
  static EdgeInsets get bigPadding=>EdgeInsets.only(
      left: screenWidth * 0.05,right:screenWidth * 0.05,top: screenHeight*.04,
      bottom:  screenHeight*.04) ;
  static EdgeInsets get csmallmediumPadding=>EdgeInsets.only(
      left: screenWidth * 0.05,right:screenWidth * 0.05,top: 10,
      bottom:  10) ;
  static EdgeInsets get smallVerticalPadding=>EdgeInsets.only(
      top: 11,
      bottom:  11) ;
  static EdgeInsets get smallerVerticalPadding=>EdgeInsets.only(
      top: 5,
      bottom:  5) ;
  static EdgeInsets get smallerVerticalPadding3=>EdgeInsets.only(
      top: 3,
      bottom:  3) ;
  static EdgeInsets get bottomsidePadding=>EdgeInsets.only(
      left: screenWidth * 0.043,right:screenWidth * 0.043,
      bottom:  50) ;


  /// Returns a vertical space with height set to [HorizontalSpaceLarge]
  static Widget horizontalSpaceLarge() {
    return horizontalSpace(HorizontalSpaceLarge);
  }
  static Widget horizontalSpaceBig() {
    return horizontalSpace(HorizontalSpaceBig);
  }

  /// Returns a vertical space equal to the [width] supplied
  static Widget horizontalSpace(double width) {
    return SizedBox(width: width);
  }
  static Widget dotWidget(Color color,height){
    return  Container(
      height: height,
      width: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color:color,

      ),
    );
  }
}
