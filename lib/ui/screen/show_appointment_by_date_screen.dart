
import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/constant/image_file.dart';
import 'package:enstaller/core/constant/size_config.dart';
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/appointmentDetailsModel.dart';
import 'package:enstaller/core/provider/base_view.dart';
import 'package:enstaller/core/viewmodel/appointment_viewmodel.dart';
import 'package:enstaller/ui/shared/app_drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'detail_screen.dart';

class ShowAppointmentByDateScreen extends StatefulWidget {
  final String dateString;
  ShowAppointmentByDateScreen({this.dateString});

  @override
  _ShowAppointmentByDateScreenState createState() => _ShowAppointmentByDateScreenState();
}

class _ShowAppointmentByDateScreenState extends State<ShowAppointmentByDateScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BaseView<AppointmentViewModel>(
      onModelReady: (model)=>model.getAppointmentList(),
      builder: (context,model,child){
        return Scaffold(
            key: _scaffoldKey,
            drawer: Drawer(
              child:AppDrawerWidget(),
            ),
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading:Padding(
                padding: const EdgeInsets.all(18.0),
                child: InkWell(
                    onTap: () {
                      _scaffoldKey.currentState.openDrawer();
                    },
                    child: Image.asset(
                      ImageFile.menuIcon,color: AppColors.black,
                    )),
              ),
              title: model.searchBool?TextField(
                decoration: InputDecoration(
                    hintText: AppStrings.searchHere
                ),
                onChanged: (val){
                  model.onSearch(val);
                },
              ):Text(
                AppStrings.appointment,
                style: getTextStyle(color: Colors.orangeAccent, isBold: true),
              ),
              actions: [
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      model.searchBool?Icons.clear:Icons.search,
                      color: Colors.black,
                    ),
                  ),
                  onTap: (){
                    model.onClickSerach();
                  },
                )
              ],
            ),
            body: model.state==ViewState.Busy?AppConstants.circulerProgressIndicator():
            SingleChildScrollView(
              child: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height),
                  child: (model.appointmentList.isNotEmpty == true) ? ListView.builder(
                    itemCount: model.appointmentList.length,
                    itemBuilder: (context, i) {
                      return
                        Column(
                          children: [
                            _engineerInfo(model.appointmentList[i]),
                            Divider(
                              color: AppColors.darkGrayColor,
                              thickness: 1.0,
                            ),
                          ],
                        );
                    },
                  ) : Center(child:Text(AppStrings.noDataFound))




              ),
            ));
      },
    );
  }

  Widget _engineerInfo(Appointment appointment) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 30.0, bottom: 5.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Text(
                    AppStrings.bookingReference,
                    textAlign: TextAlign.left,
                    style: getTextStyle(color: AppColors.darkGrayColor, isBold: true),
                  )),
              Expanded(
                  flex: 1,
                  child: Text(
                    appointment?.strBookingReference ?? "",
                    style: getTextStyle(color: Colors.black, isBold: true),
                  )),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Text(
                    AppStrings.supplier,
                    textAlign: TextAlign.left,
                    style: getTextStyle(color: AppColors.darkGrayColor, isBold: true),
                  )),
              Expanded(
                  flex: 1,
                  child: Text(

                    appointment?.strCompanyName ?? "",
                    textAlign: TextAlign.left,
                    style: getTextStyle(color: Colors.black, isBold: true),
                  )),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Text(
                    AppStrings.subRegion,
                    textAlign: TextAlign.left,
                    style: getTextStyle(color: AppColors.darkGrayColor, isBold: true),
                  )),
              Expanded(
                  flex: 1,
                  child: Text(
                    appointment?.patchCode ?? "",
                    textAlign: TextAlign.left,
                    style: getTextStyle(color: Colors.black, isBold: true),
                  )),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Text(
                    AppStrings.postCode,
                    textAlign: TextAlign.left,
                    style: getTextStyle(color: AppColors.darkGrayColor, isBold: true),
                  )),
              Expanded(
                  flex: 1,
                  child: Text(
                    appointment.strPostCode ?? "",
                    textAlign: TextAlign.left,
                    style: getTextStyle(color: Colors.black, isBold: true),
                  )),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Text(
                    AppStrings.date,
                    textAlign: TextAlign.left,
                    style: getTextStyle(color: AppColors.darkGrayColor, isBold: true),
                  )),
              Expanded(
                  flex: 1,
                  child: Text(
                    AppConstants.formattedSingeDate(DateTime.parse(appointment?.dteBookedDate)) ?? "",
                    textAlign: TextAlign.left,
                    style: getTextStyle(color: Colors.black, isBold: true),
                  )),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Text(
                    AppStrings.timeSlot,
                    textAlign: TextAlign.left,
                    style: getTextStyle(color: AppColors.darkGrayColor, isBold: true),
                  )),
              Expanded(
                  flex: 1,
                  child: Text(
                    appointment?.strBookedSlotType ?? "",
                    textAlign: TextAlign.left,
                    style: getTextStyle(color: Colors.black, isBold: true),
                  )),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Text(
                    AppStrings.workType,
                    textAlign: TextAlign.left,
                    style: getTextStyle(color: AppColors.darkGrayColor, isBold: true),
                  )),
              Expanded(
                  flex: 1,
                  child: Text(
                    appointment?.strJobType ?? "",
                    textAlign: TextAlign.left,
                    style: getTextStyle(color: Colors.black, isBold: true),
                  )),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Text(
                    AppStrings.bookOn,
                    textAlign: TextAlign.left,
                    style: getTextStyle(color: AppColors.darkGrayColor, isBold: true),
                  )),
              Expanded(
                  flex: 1,
                  child: Text(
                    AppConstants.formattedSingeDate(DateTime.parse(appointment?.dteBookedDate)) ?? "",
                    textAlign: TextAlign.left,
                    style: getTextStyle(color: Colors.black, isBold: true),
                  )),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Text(
                    AppStrings.bookBy,
                    textAlign: TextAlign.left,
                    style: getTextStyle(color: AppColors.darkGrayColor, isBold: true),
                  )),
              Expanded(
                  flex: 1,
                  child: Text(
                    appointment?.strBookedBy ?? "",
                    textAlign: TextAlign.left,
                    style: getTextStyle(color: Colors.black, isBold: true),
                  )),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Text(AppStrings.status,
                    textAlign: TextAlign.left,
                    style: getTextStyle(color: AppColors.darkGrayColor, isBold: true),
                  )),

              Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: SvgPicture.asset(
                            AppConstants.getStatusImageUrl(appointment?.appointmentEventType),
                            semanticsLabel: 'Status'
                        ),
                      ),
                      SizeConfig.horizontalSpaceSmall(),
                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.statusColor(appointment?.appointmentEventType),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            appointment?.appointmentEventType ?? "",
                            textAlign: TextAlign.left,
                            style:
                            getTextStyle(color: Colors.black, isBold: true),
                          ),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Align(
              alignment: Alignment.center,
              child: RaisedButton(
                color: Colors.green[800],
                onPressed: () {
                  Navigator.of(context).pushNamed(DetailScreen.routeName,arguments:DetailScreenArguments(
                      appointmentID:  appointment.intId.toString(),
                      strBookingReference:  appointment.strBookingReference,
                      customerID:   appointment.intCustomerId.toString()
                  ));
                },
                child: Text(AppStrings.view),
              )),
        ],
      ),
    );
  }

  TextStyle getTextStyle({Color color, bool isBold = false, num fontSize}) {
    return TextStyle(
        color: color,
        fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
        fontSize: fontSize);
  }
}

