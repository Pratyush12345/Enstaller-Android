import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/constant/image_file.dart';
import 'package:enstaller/core/constant/size_config.dart';
import 'package:enstaller/core/constant/text_style.dart';
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/provider/base_view.dart';
import 'package:enstaller/core/service/pref_service.dart';
import 'package:enstaller/core/viewmodel/get_user_details_viewmodel.dart';
import 'package:enstaller/ui/screen/appointments.dart';
import 'package:enstaller/ui/screen/email_notification.dart';
import 'package:enstaller/ui/screen/sms_notification.dart';
import 'package:enstaller/ui/screen/document.dart';
import 'package:enstaller/ui/screen/home_screen.dart';
import 'package:enstaller/ui/screen/profile_screen.dart';
import 'package:enstaller/ui/screen/today_appointments.dart';
import 'package:enstaller/ui/screen/update_status_screen.dart';
import 'package:enstaller/ui/screen/widget/drawer_row_widget.dart';
import 'package:flutter/material.dart';


class AppDrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        DrawerHeader(child: BaseView<GetUserDetailsViewModel>(
          onModelReady: (model)=>model.getUserDetails(),
          builder: (context,model,child){
            if(model.state==ViewState.Busy){
              return AppConstants.circulerProgressIndicator();
            }else{
              return Row(
                children: [
                  InkWell(
                    child: Container(
                      height: 50,
                      width: 50,
                      child: Center(
                        child: Text(AppConstants.nameTitle(model.user.username),
                        style: AppStyles.GreenStyle_Font,),
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.whiteColor
                      ),
                    ),
                    onTap: (){
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (context) => ProfilePage()));
                    },
                  ),
                  SizeConfig.horizontalSpaceSmall(),
                  Expanded(
                    child: InkWell(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(model.user.username,style: AppStyles.WhiteStyle_Font20.copyWith(
                            fontWeight: FontWeight.bold
                          ),),
                          Text(model.user.email,style: AppStyles.WhiteStyle_Font20,)
                        ],
                      ),
                      onTap: (){
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (context) => ProfilePage()));
                      },
                    ),
                  ),

                  InkWell(
                    child: SizedBox(
                      height: 20,
                        child: Image.asset(ImageFile.downArrow,color: AppColors.whiteColor,)),
                    onTap: (){
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (context) => HomeScreen()));
                    },
                  ),


                ],
              );
            }
          },
        ),decoration: BoxDecoration(
          color: AppColors.green
        ),),
        Expanded(
          child: Column(
            children: [
              DrawerRowWidget(
                title: 'Dashboard',
                assetPath: ImageFile.dashboard,
                onTap: (){
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => HomeScreen()));
                },
              ),
              DrawerRowWidget(
                title: 'Today',
                assetPath: ImageFile.today,
                onTap: (){
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => TodayAppointmentScreen()));
                },
              ),
              DrawerRowWidget(
                title: 'Appointments',
                assetPath: ImageFile.appointment,
                onTap: (){
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => AppointmentScreen()));
                },
              ),
              DrawerRowWidget(
                title: 'Document',
                assetPath: ImageFile.appointment,
                onTap: (){
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => DocumentScreen()));
                },
              ),
              // DrawerRowWidget(
              //   title: 'Update Status',
              //   assetPath: ImageFile.updateStatus,
              //   onTap: (){
              //     Navigator.of(context).pushNamed(UpdateStatusScreen.routeName);
              //   },
              // ),
              DrawerRowWidget(
                title: 'My Profile',
                assetPath: ImageFile.myProfile,
                onTap: (){
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => ProfilePage()));
                },
              ),
              DrawerRowWidget(
                title: 'Email Notification',
                assetPath: ImageFile.notification,
                onTap: (){
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => EmailNotificationScreen()));
                },
              ),
              DrawerRowWidget(
                title: 'SMS Notification',
                assetPath: ImageFile.notification,
                onTap: (){
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => SMSNotificationScreen()));
                },
              ),
              DrawerRowWidget(
                title: 'Logout',
                assetPath: ImageFile.logout,
                onTap: ()async{
                  await Prefs.logOut();
                  Navigator.of(context).pushNamedAndRemoveUntil("/login",(Route<dynamic> route) => false);
                },
              ),


            ],
          ),
        )
      ],
    );
  }
}
