import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/constant/image_file.dart';
import 'package:enstaller/core/constant/size_config.dart';
import 'package:enstaller/core/model/app_table.dart';
import 'package:enstaller/ui/screen/detail_screen.dart';
import 'package:enstaller/ui/util/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter_svg/svg.dart';

class ViewAppointmentListWidget extends StatelessWidget {
  final List<AppTable>tables;
  ViewAppointmentListWidget({this.tables});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics:
      NeverScrollableScrollPhysics(),
      itemCount:tables.length,
      padding:
      EdgeInsets.all(0),
      itemBuilder: (context,
          childrenIndex) {
        return InkWell(
          onTap:
              () {

            Navigator.of(context).pushNamed(DetailScreen.routeName,arguments:DetailScreenArguments(
                appointmentID: tables[childrenIndex].intId.toString(),
                strBookingReference:  tables[childrenIndex].strBookingReference,
                customerID:  tables[childrenIndex].intCustomerId.toString()
            )).then((value) {
              FlutterStatusbarcolor.setStatusBarColor(AppColors.green);
            });

          },
          child:
          Container(
            height: SizeConfig.screenHeight*.15,
            decoration: BoxDecoration(
                color:
                Colors.white,
              borderRadius: BorderRadius.circular(7),
//              border: childrenIndex!=tables.length-1?Border.all(color: AppColors.lightGrayDotColor):Border.all(color: Colors.transparent)
                border: Border.all(color: AppColors.lightGrayDotColor)
            ),

            padding:
            EdgeInsets.all(0),
            width:
            double.infinity,
            child:
            FittedBox(
              child: Padding(
                padding:
                const EdgeInsets.all(8.0),
                child:
                Row(
                  children: [

                    Container(
                      height: 50,
                      width: 50,
                      child: Center(child: Text(AppConstants.nameTitle(tables[childrenIndex].strContactName),
                      style: TextStyle(fontWeight: FontWeight.bold),)),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: childrenIndex%3==0?AppColors.thirdItemColor:childrenIndex%2==0?AppColors.secondItemColor:AppColors.firstItemColor
                      ),
                    ),
                    SizeConfig.horizontalSpaceSmall(),

                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              tables[childrenIndex].strContactName,
                              style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              "${AppStrings.bookingReference} : ",
                              style: TextStyle(color: Colors.black, fontSize: 12,fontWeight: FontWeight.w300),
                            ),
                            Text(
                              tables[childrenIndex].strBookingReference,
                              style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
//                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [

                                SizedBox(
                                  height: 15,
                                    child: Image.asset(ImageFile.time)),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "${AppStrings.time} : ",
                                  style: TextStyle(color: AppColors.green, fontWeight: FontWeight.w500,fontSize: 12),
                                ),
                                Text(
                                  tables[childrenIndex].strBookedTime,
                                  style: TextStyle(color:  AppColors.green, fontWeight: FontWeight.w500,fontSize: 12),
                                ),
                              ],
                            ),

                            Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  height: 15,
                                  width: 15,
                                  child: SvgPicture.asset(
                                      AppConstants.getStatusImageUrl(tables[childrenIndex].appointmentEventType),
                                      semanticsLabel: 'Status'
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "${AppStrings.status} : ",
                                  style: TextStyle(color: AppColors.statusColor(tables[childrenIndex].appointmentEventType),fontSize: 12,fontWeight: FontWeight.w500 ),
                                ),


                                Text(
                                  tables[childrenIndex].appointmentEventType ?? "",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(color:AppColors.statusColor(tables[childrenIndex].appointmentEventType),fontSize: 12,fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),


                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
