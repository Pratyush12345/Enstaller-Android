
import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/constant/image_file.dart';
import 'package:enstaller/core/constant/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

class AppConstants{
  static String faceBookClientID = "2355582358071365";
  static bool darkMode=false;


//current location
  static double currentLatitude=0.0;
  static double currentLogitute=0.0;

//font size
  static const double fontSizeVeryLarge = 40;
  static const double fontSizeMedium = 20;
  static const double fontSizeSmall = 16;
  static const double fontSizeLarge = 24;




//radius
  static const double introGetStarted_button_Radius= 20.0;
  static const double backArrowContainreRightRadius = 25;
  static const double RadiusMedium = 20;
  static const double ContainerRoundCorner_Radius = 10;

  static const double ContainerMediumRoundCorner_Radius = 20;
  static const double button_Radius= 15.0;
  static const double appBar_Radius=40;
  static const double radius= 3;
  static const double radiusSmall= 6;


//icon size
  static const double  signUpDropDown_IconSize= 24;
  static const double  mainTab_IconSize= 28;
  static const double iconHeightWidth = 350;
  static const double smallIconheight=13;

  //signin page
  static const double  RoundViewButtonRadius= 30;
  static const double  EmailPasswordWidgetRadius= 20;

  //signup page
  static const double backArrowContainreHeight = 50;
  static const double backArrowContainreWidth = 60;
  static const double backArrowContainrheight = 70;

  static const double RoundSignupButton_ContainerHeight = 60;
  static const double ShadowBox_SpreadRadius = 5;
  static const double ShadowBox_BlurRadius = 10;
  static const double ShadowBox_WithOpacity = 0.1;
  static const double ShadowBox_Offset = 3;

  //DecideUserType Screen item widget
  static const double Image_height = 100;
  static const double Card_Height = 240;

  //margin -padding
  static const double Card_margin = 10;
  static const double TextField_Contentpading = 10.0;
  static const double TextField_Contentpading_top = 10.0;
  static const double marginMedium = 30.0;
  static const double marginsmall = 10.0;
  static const double marginSmallLarge = 12.0;
  static const double marginLarge = 80;
  static const double marginVerySmall = 2;
  static const double marginVerySmall1 = 5;
  static const double marginVeryVerySmall = 1;
  static const double margin15=15;



  //height-width
  static const double imageHeight_width_Very_small = 15;
  static const double imageHeight_width_small = 20;
  static const double imageHeight_width = 25;
  static const double ContainerHeight_width = 30;
  static const double ContainerHeight_widthLarge = 100;
  static const double ContainerHeight_widthLargeSmall = 100;
  static const double ContainerHeight_widthVeryLarg = 170;
  static const double ContainerHeight_widthVeryLarg1 = 130;
  static const double ContsinerHeight_WidthC140=140;
  static const double ContainerHeight_widthMedium=55;
  static const double ContainerHeight_widthMediumlarge=85;





  //signup round button
  static const double ShadowBox_SpreadRadius_medium = 7;
  static const double ShadowBox_BlurRadius_Medium = 7;
  static const double ShadowBox_WithOpacityMedium = 0.2;

  //listview
  static const double List_itemExtent= 360;

  //rattingbar
  static const int RatingBar_opacity=50;
  static const int Ratingbar_item_count= 5;
  static const double Ratingbar_itemSize= 13.0;

  //dash line
  static const double dash_width=7;
  static const double empty_width=6;

  static Widget circulerProgressIndicator(){
    return Center(
      child: CircularProgressIndicator(),
    );

  }
  var _formatter = DateFormat.yMMMMd('en_US');

  String pickDate(DateTime picked) {
    if (picked != null) {
      String formatted = _formatter.format(picked);
      return formatted;
    }return '';
  }


  static String formattedDate(date) => DateFormat('dd/MM/yyyy KK:MMaa').format(date);
  static String formattedSingeDate(date) => DateFormat('dd/MM/yyyy').format(date);

  String _formattedDate(date) => DateFormat('kk:mm').format(date);



  static String getTimeString(DateTime date){
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);

    final aDate = DateTime(date.year, date.month, date.day);

    if(aDate == today) {
      return 'Today at ${DateFormat('kk:mm').format(date)}';
    } else if(aDate == yesterday) {
      return 'yesterday at ${DateFormat('kk:mm').format(date)}';
    } else if(aDate == tomorrow) {
      return 'tomorrow at ${DateFormat('kk:mm').format(date)}';
    }else{
      return '${aDate.day}/${aDate.month}/${aDate.year} at ${DateFormat('kk:mm').format(date)}';
    }
  }
  static String _getday(date)=>DateFormat('EE').format(date).toUpperCase();
  static Widget dateColumnWidget(String dateValue){
    DateTime _dateTime=DateTime.parse(dateValue);
    return Column(
      children: [
        Text(_getday(_dateTime)),
        Text('${_dateTime.day}'),
      ],
    );

  }

  static String getMonth(int month){
    if(month==1){
      return 'January';
    }else if(month==2){
      return 'February';
    }else if(month==3){
      return 'March';
    }else if(month==4){
      return 'April';
    }else if(month==5){
      return 'May';
    }else if(month==6){
      return 'Jun';
    }else if(month==7){
      return 'July';
    }else if(month==8){
      return 'August';
    }else if(month==9){
      return 'September';
    }else if(month==10){
      return 'October';
    }else if(month==11){
      return 'November';
    }else if(month==12){
      return 'December';
    }else{
      return '';
    }
  }
  static  void showSuccessToast(BuildContext context,String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: 5,backgroundColor: Colors.green);
  }
  static  void showFailToast(BuildContext context,String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: 5,backgroundColor: AppColors.red);
  }

  static double getExpandedListHeight(bool emprtyTable,int langth){
    print(emprtyTable);
    print('$langth');
    if(langth>0){
      return SizeConfig.screenHeight*.15*langth;
    }else{
      return SizeConfig.screenHeight*.15;
    }
  }
  static Future<dynamic> showAppDialog({BuildContext context,String title,Widget child}){
    FocusScope.of(context).requestFocus(FocusNode());
    return showDialog(context: context,child:Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(7.0))),
      child: child,

    ));
  }
  static String getStatusImageUrl(String status){
    if(status==AppStrings.aborted){
      return ImageFile.aborted;
    }else if(status ==AppStrings.booked){
      return ImageFile.booked;
    }else if(status==AppStrings.cancelled){
      return ImageFile.cancelled;
    }else if(status==AppStrings.completed){
      return ImageFile.completed;
    }else if(status==AppStrings.EnRoute){
      return ImageFile.inRoute;
    }else if(status==AppStrings.onSite){
      return ImageFile.onSite;
    }else if(status==AppStrings.reScheduled){
      return ImageFile.rescheduled;
    }else if(status==AppStrings.scheduled){
      return ImageFile.scheduled;
    }else if(status==AppStrings.started){
      return ImageFile.started;
    }else if(status==AppStrings.unScheduled){
      return ImageFile.unscheduled;
    }else{
      return ImageFile.started;
    }
  }

  static String getStatusFromStrEventType(String value,String comment){
    if(value =='AppointmentEvent'){
      if (comment.contains('Booked')) {
        return "Booked";
    }else if (comment.contains('Unscheduled')) {
        return 'Unscheduled';
      }
      else if (comment.contains('InRoute')) {
        return AppStrings.EnRoute;
    }
      else if (comment.contains('OnSite')) {
        return AppStrings.onSite;
      }
      else if (comment.contains('Started')) {
        return AppStrings.started;
      }
      else if (comment.contains('Completed')) {
        return AppStrings.completed;
      }
      else if (comment.contains('Cancelled')) {
        return AppStrings.cancelled;
      }
      else if (comment.contains('Aborted')) {
        return AppStrings.aborted;
      }
      else if (comment.contains('Scheduled')) {
        return AppStrings.scheduled;

    }else{
        return '';
      }
    }else{
      return '';
    }
  }

  static int get toDate{
    DateTime date=DateTime.now();
    if(date.month==1){
      return 31;
    }else if(date.month==2){
      if(date.year % 4 == 0 || date.year % 100 == 0 && date.year % 400 == 0){
        return 29;
      }else{
        return 28;
      }

    }else if(date.month==3){
      return 31;
    }else if(date.month==4){
      return 30;
    }else if(date.month==5){
      return 31;
    }else if(date.month==6){
      return 30;
    }else if(date.month==7){
      return 31;
    }else if(date.month==8){
      return 31;
    }else if(date.month==9){
      return 30;
    }else if(date.month==10){
      return 31;
    }else if(date.month==11){
      return 30;
    }else if(date.month==12){
      return 31;
    }else{
      return 31;
    }
  }
  static String nameTitle(String value){
    List<String>list=value.split(' ');
    if(list.length>1){
      return list[0][0]+list[1][0];
    }else{
      return list[0][0];
    }

  }

}