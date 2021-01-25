import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/constant/image_file.dart';
import 'package:enstaller/core/constant/size_config.dart';
import 'package:enstaller/core/constant/text_style.dart';
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/provider/base_view.dart';
import 'package:enstaller/core/viewmodel/update_status_viewmodel.dart';
import 'package:enstaller/ui/screen/widget/appointment/appointment_data_row.dart';
import 'package:enstaller/ui/shared/app_drawer_widget.dart';
import 'package:enstaller/ui/shared/appbuttonwidget.dart';
import 'package:enstaller/ui/shared/custom_expanded_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter_svg/svg.dart';

class UpdateStatusScreen extends StatelessWidget {
  static const String routeName = '/updateStatusScreen';
  final _scaffoldKey = GlobalKey<ScaffoldState>();


  Widget _rowWidget({String firstText,secondText}){
    return Row(
      children: [
        Expanded(child: Text(firstText,style: TextStyle(
          color: AppColors.darkGrayColor,fontWeight: FontWeight.bold
        ),)),
        Expanded(flex: 2,child: Text(secondText,style: TextStyle(
          color: AppColors.black,fontWeight: FontWeight.bold
        ),))
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return BaseView<UpdateStatusViewModel>(
      onModelReady: (model)=>model.initializeData(),
      builder: (context,model,child){
        return Scaffold(
          backgroundColor: AppColors.scafoldColor,
          key: _scaffoldKey,
          drawer: Drawer(
            child:AppDrawerWidget(),
          ),
          appBar: AppBar(
            backgroundColor: AppColors.green,
            leading:Padding(
              padding: const EdgeInsets.all(18.0),
              child: InkWell(
                  onTap: () {
                    _scaffoldKey.currentState.openDrawer();
                  },
                  child: Image.asset(
                    ImageFile.menuIcon,color: AppColors.whiteColor,
                  )),
            ),
            title: model.search?TextField(
              decoration: InputDecoration(
                  hintText: AppStrings.searchHere
              ),
              onChanged: (val){
                model.textChange(val);
              },
            ):FittedBox(
              child: Text(AppStrings.APPOINTMENT_STATUS,style: TextStyle(
                color: AppColors.whiteColor,fontSize: 18
              ),maxLines: 1,),
            ),
            centerTitle: true,
            actions: [
              IconButton(icon:Icon(model.search?Icons.clear:Icons.search,color: AppColors.whiteColor), onPressed: (){
                model.onSearch();

              }),
              IconButton(icon:Padding(
                padding: const EdgeInsets.all(3.0),
                child: Image.asset(ImageFile.notification,color: AppColors.whiteColor,),
              ), onPressed: (){


              })
            ],
            bottom: PreferredSize(
                child:Container(
                  height: 60,
                  color: AppColors.whiteColor,
                  child: Padding(
                    padding: SizeConfig.sidepadding,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 40,
                            child: Padding(
                              padding: SizeConfig.sidepadding,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      icon: Icon(Icons.expand_more),
                                      underline: Container(),
                                      value: model.selectedStatus,
                                      items: model.statusList.map((String value) {
                                        return new DropdownMenuItem<String>(

                                          value: value,
                                          child:  Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (_) {
                                        model.onSelectStatus(_);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                              border:Border.all(color: AppColors.lightGrayDotColor),
                              borderRadius: BorderRadius.circular(2)
                            ),
                          ),
                        ),
                        SizeConfig.horizontalSpaceSmall(),
                        AppButton(
                          height: 40,
                          radius: 5,
                          width: 100,
                          color:  AppColors.darkBlue,
                          buttonText: AppStrings.UPDATE,
                          textStyle: TextStyle(
                            color: AppColors.whiteColor
                          ),
                          onTap: (){
                            model.onUpdateStatus(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                preferredSize: Size.fromHeight(60.0)),
          ),
          body: model.state==ViewState.Busy?AppConstants.circulerProgressIndicator():
          Padding(
            padding: SizeConfig.padding,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: AppColors.lightGrayDotColor,
                    blurRadius: 10
                  )
                ]
              ),
              child: ListView.builder(itemCount: model.appointmentStatusList.length,itemBuilder: (context,int index){
                return CustomExpandedTile(
                  expanded: model.appointmentStatusList[index].intId==model.expandSelectedStatus.intId,
                  firstChild: Container(
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      border: Border(
                        bottom: BorderSide(
                          color: AppColors.lightGrayDotColor
                        )
                      )
                    ),
                    child: Row(
                      children: [
                        model.appointmentStatusList[index]?.appointmentEventType==AppStrings.completed||
                            model.appointmentStatusList[index]?.appointmentEventType==AppStrings.cancelled?Opacity(opacity: 0,child: Checkbox(
                            value: model.selectedAppointments.contains(model.appointmentStatusList[index]),
                            onChanged: (val){
                            }
                        )):Checkbox(
                            value: model.selectedAppointments.contains(model.appointmentStatusList[index]),
                            onChanged: (val){
                              model.onSelectAppointment(model.appointmentStatusList[index]);
                            }
                        ),
                        Expanded(
                            flex: 3,child: Text(model.appointmentStatusList[index].customerName)),
                        SizeConfig.horizontalSpaceSmall(),
                        Expanded(
                            flex:2,child: FittedBox(
                              child: Row(
                          children: [
                              SizedBox(
                                height: 20,
                                width: 20,
                                child: SvgPicture.asset(
                                    AppConstants.getStatusImageUrl(model.appointmentStatusList[index]?.appointmentEventType),
                                    semanticsLabel: 'Status'
                                ),
                              ),
                              SizeConfig.horizontalSpaceSmall(),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(model.appointmentStatusList[index]?.appointmentEventType,
                                  textAlign: TextAlign.center,style: TextStyle(
                                      color: AppColors.statusColor(model.appointmentStatusList[index].appointmentEventType)
                                  ),),
                              ),
                          ],
                        ),
                            )),
                        SizeConfig.horizontalSpaceSmall(),
                        IconButton(icon: Icon(model.expandSelectedStatus.intId==model.appointmentStatusList[index].intId?Icons.remove:Icons.add,size: 20,color: AppColors.green,), onPressed: (){
                          model.onSelectExpand(model.appointmentStatusList[index]);
                        }),

                      ],
                    ),
                  ),
                  secondChild: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            border: Border(
                                bottom: BorderSide(
                                    color: AppColors.lightGrayDotColor
                                )
                            )
                        ),
                        child: Row(
                          children: [
                            model.appointmentStatusList[index]?.appointmentEventType==AppStrings.completed||
                                model.appointmentStatusList[index]?.appointmentEventType==AppStrings.cancelled?Opacity(opacity: 0,child: Checkbox(
                                value: model.selectedAppointments.contains(model.appointmentStatusList[index]),
                                onChanged: (val){
                                }
                            )):Checkbox(
                                value: model.selectedAppointments.contains(model.appointmentStatusList[index]),
                                onChanged: (val){
                                  model.onSelectAppointment(model.appointmentStatusList[index]);
                                }
                            ),
                            Expanded(
                                flex: 3,child: Text(model.appointmentStatusList[index].customerName)),
                            SizeConfig.horizontalSpaceSmall(),
                            Expanded(
                                flex:2,child: FittedBox(
                                  child: Row(
                              children: [
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: SvgPicture.asset(
                                        AppConstants.getStatusImageUrl(model.appointmentStatusList[index]?.appointmentEventType),
                                        semanticsLabel: 'Status'
                                    ),
                                  ),
                                  SizeConfig.horizontalSpaceSmall(),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(model.appointmentStatusList[index]?.appointmentEventType,
                                      textAlign: TextAlign.center,style: TextStyle(
                                          color: AppColors.statusColor(model.appointmentStatusList[index].appointmentEventType)
                                      ),),
                                  ),
                              ],
                            ),
                                )),
                            SizeConfig.horizontalSpaceSmall(),
                            IconButton(icon: Icon(model.expandSelectedStatus.intId==model.appointmentStatusList[index].intId?Icons.remove:Icons.add,size: 20,color: AppColors.green,), onPressed: (){
                              model.onSelectExpand(model.appointmentStatusList[index]);
                            }),

                          ],
                        ),
                      ),
                      Container(
                        color: AppColors.scafoldColor,
                        child: Column(
                          children: [
                            AppointmentDataRow(
                              firstText: AppStrings.bookingReference,
                              secondText: model.appointmentStatusList[index].strBookingReference,
                            ),
                            AppointmentDataRow(
                              firstText: AppStrings.supplier,
                              secondText: model.appointmentStatusList[index].strCompanyName,
                            ),
                            AppointmentDataRow(
                              firstText: AppStrings.subRegion,
                              secondText: model.appointmentStatusList[index].patchCode,
                            ),
                            AppointmentDataRow(
                              firstText: AppStrings.postCode,
                              secondText: model.appointmentStatusList[index].strPostCode,
                            ),
                            AppointmentDataRow(
                              firstText: AppStrings.date,
                              secondText: AppConstants.formattedSingeDate(DateTime.parse(model.appointmentStatusList[index].dteBookedDate)),
                            ),
                            AppointmentDataRow(
                              firstText: AppStrings.timeSlot,
                              secondText: model.appointmentStatusList[index].strBookedTime,
                            ),
                            AppointmentDataRow(
                              firstText: AppStrings.workType,
                              secondText: model.appointmentStatusList[index].strJobType,
                            ),
                            AppointmentDataRow(
                              firstText: AppStrings.bookOn,
                              secondText:AppConstants.formattedSingeDate(DateTime.parse(model.appointmentStatusList[index].dteBookedDate))
                            ),
                            AppointmentDataRow(
                              firstText: AppStrings.bookBy,
                              secondText: model.appointmentStatusList[index].strBookedBy,
                            ),
                            AppointmentDataRow(
                              firstText: AppStrings.status,
                              secondChild: Row(
                                children: [
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: SvgPicture.asset(
                                        AppConstants.getStatusImageUrl(model.appointmentStatusList[index].appointmentEventType),
//                                          color: AppColors.statusColor(model.appointmentStatusList[index].appointmentEventType),
                                        semanticsLabel: 'Status'
                                    ),
                                  ),
                                  SizeConfig.horizontalSpaceSmall(),
                                  Text(model.appointmentStatusList[index].appointmentEventType,
                                  style: TextStyle(
                                      color: AppColors.statusColor(model.appointmentStatusList[index].appointmentEventType)
                                  ),)
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }),
            ),
          ),
        );
      },
    );
  }
}
