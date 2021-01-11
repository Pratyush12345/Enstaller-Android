import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/constant/image_file.dart';
import 'package:enstaller/core/constant/size_config.dart';
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/appointmentDetailsModel.dart';
import 'package:enstaller/core/provider/base_view.dart';
import 'package:enstaller/core/viewmodel/today_appointment_viewmodel.dart';
import 'package:enstaller/ui/screen/detail_screen.dart';
import 'package:enstaller/ui/screen/widget/appointment/appointment_data_row.dart';
import 'package:enstaller/ui/shared/app_drawer_widget.dart';
import 'package:enstaller/ui/shared/appbuttonwidget.dart';
import 'package:enstaller/ui/util/text_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_maps/flutter_google_maps.dart';
import 'package:flutter_svg/svg.dart';

class TodayAppointmentScreen extends StatefulWidget {
  @override
  _ApppointmentScreenState createState() => _ApppointmentScreenState();
}

class _ApppointmentScreenState extends State<TodayAppointmentScreen> {


  //Declaration of scaffold key
  final _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return BaseView<TodayAppointmentViewModel>(
      onModelReady: (model)=>model.getAppoinmentList(),
      builder: (context,model,child){
        return Scaffold(
          backgroundColor: AppColors.scafoldColor,
            key: _scaffoldKey,
            drawer: Drawer(
              child:AppDrawerWidget(),
            ),
            appBar: AppBar(
              backgroundColor:AppColors.green,
              leading: Padding(
                padding: const EdgeInsets.all(18.0),
                child: InkWell(
                    onTap: () {
                      _scaffoldKey.currentState.openDrawer();
                    },
                    child: Image.asset(
                      ImageFile.menuIcon,color: AppColors.whiteColor,
                    )),
              ),
              title: Text(
                AppStrings.TODAY_APPOINTMENTS,
                style: getTextStyle(color: AppColors.whiteColor, isBold: true),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            body: model.state==ViewState.Busy?AppConstants.circulerProgressIndicator():SingleChildScrollView(
              child: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height),
                  child: (model.appointmentList.isNotEmpty == true) ? Padding(
                    padding:SizeConfig.padding.copyWith(
                        bottom: 100
                    ),
                    child: ListView.builder(
                      itemCount:model.appointmentList.length,
                      itemBuilder: (context, i) {

                        return
                          Padding(
                            padding:  SizeConfig.verticalC13Padding,
                            child: InkWell(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: AppColors.appointmentBackGroundColor,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  children: [
                                    _engineerInfo(model.appointmentList[i]),

                                  ],
                                ),
                              ),
                              onTap: (){
                                Navigator.of(context).pushNamed(DetailScreen.routeName,arguments:DetailScreenArguments(
                                    appointmentID: model.appointmentList[i].intId.toString(),
                                    strBookingReference:  model.appointmentList[i].strBookingReference,
                                    customerID:    model.appointmentList[i].intCustomerId.toString()
                                ));
                              },
                            ),
                          );
                      },
                    ),
                  ) : Center(child:Text(AppStrings.noDataFound))




              ),
            ));
      },
    );
  }

  // engineer info
  Widget _engineerInfo(Appointment appointment) {
    return Column(
      children: [
        AppointmentDataRow(
          firstText: AppStrings.bookingReference,
          secondText: appointment?.strBookingReference ?? "",
        ),
        AppointmentDataRow(
          firstText: AppStrings.supplier,
          secondText: appointment?.strCompanyName ?? "",
        ),
        AppointmentDataRow(
          firstText: AppStrings.subRegion,
          secondText: appointment?.patchCode ?? "",
        ),
        AppointmentDataRow(
          firstText: AppStrings.postCode,
          secondText: appointment?.strPostCode ?? "",
        ),
        AppointmentDataRow(
          firstText: AppStrings.date,
          secondText: appointment?.dteBookedDate!=null?AppConstants.formattedSingeDate(DateTime.parse(appointment?.dteBookedDate)) ?? "":'',
        ),
        AppointmentDataRow(
          firstText: AppStrings.timeSlot,
          secondText: appointment?.strBookedSlotType ?? "",
        ),
        AppointmentDataRow(
          firstText: AppStrings.workType,
          secondText: appointment?.strJobType ?? "",
        ),
        AppointmentDataRow(
          firstText: AppStrings.bookOn,
          secondText:appointment?.dteCreatedDate!=null?AppConstants.formattedSingeDate(DateTime.parse(appointment?.dteCreatedDate)) ?? "":"",
        ),
        AppointmentDataRow(
          firstText: AppStrings.bookBy,
          secondText:appointment?.strBookedBy ?? "",
        ),
        AppointmentDataRow(
          firstText: AppStrings.status,
          secondChild: Row(
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  appointment?.appointmentEventType??"",
                  textAlign: TextAlign.left,
                  style:
                  getTextStyle(color: AppColors.statusColor(appointment.appointmentEventType), isBold: false),
                ),
              ),
            ],
          ),
        ),

        ClipRRect(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(7),
              bottomRight:  Radius.circular(7)
          ),
          child: AppButton(
            buttonText: AppStrings.view,
            color: AppColors.green,
            textStyle: TextStyle(color: AppColors.whiteColor,fontWeight: FontWeight.bold),
            onTap: (){
              Navigator.of(context).pushNamed(DetailScreen.routeName,arguments:DetailScreenArguments(
                  appointmentID:  appointment.intId.toString(),
                  strBookingReference:  appointment.strBookingReference,
                  customerID:   appointment.intCustomerId.toString()
              ));
            },
          ),
        ),
      ],
    );
  }

  //survey info
  Widget _surveyInfo() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
              alignment: Alignment.center,
              child: RaisedButton(
                color: Colors.cyan,
                onPressed: () {},
                child: Text(AppStrings.surveys),
              )),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Text(
                    AppStrings.surveyReceived,
                    style: getTextStyle(color: Colors.grey, isBold: true),
                  )),
              Expanded(
                flex: 1,
                child: Text(
                AppStrings.no,
                  style: getTextStyle(color: Colors.black, isBold: true),
                ),
              ),
            ],
          )
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

  //get color
  Color getColor(int index) {
    switch (index) {
      case 0:
        return Colors.orange;
        break;

      case 1:
        return Colors.blue;
        break;

      case 2:
        return Colors.tealAccent;
        break;

      case 3:
        return Colors.pinkAccent;
        break;

      case 4:
        return Colors.blueGrey;
        break;
    }
  }

  // get header text
  String _getHeaderText(int index) {
    switch (index) {
      case 0:
        return "Appointment Information";
        break;

      case 1:
        return "Customer Detail";
        break;

      case 2:
        return "Electric Meter Information";
        break;

      case 3:
        return "Gas Meter Information";
        break;

      case 4:
        return "Activity Detail";
        break;
    }
  }

  //get widgets data  as per text
  Widget _getChildrenWidget(int index) {
    return (index == 4) ? _activityData() : _demoData();
  }

  //_demo data
  Widget _demoData() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 30.0, bottom: 5.0),
      child: Column(
        children: [
          _getRowData(
            AppStrings.date,
            "30-08-2020",
          ),
          SizedBox(
            height: 10,
          ),
          _getRowData(AppStrings.timeSlot, "8am - 12pm"),
          SizedBox(
            height: 10,
          ),
          _getRowData(AppStrings.workType, "New Connection > Electricity"),
          SizedBox(
            height: 10,
          ),
          _getRowData(AppStrings.bookOn, "08/09/2020 01:20 am"),
          SizedBox(
            height: 10,
          ),
          _getRowData(AppStrings.bookBy, "Demo"),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  //row data
  Widget _getRowData(String text1, String text2) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Text(
              text1,
              textAlign: TextAlign.left,
              style: getTextStyle(color: Colors.grey, isBold: true),
            )),
        Expanded(
            flex: 1,
            child: Text(
              text2,
              style: getTextStyle(color: Colors.black, isBold: true),
            )),
      ],
    );
  }

  //activity data
  Widget _activityData() {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  height: 60,
                  color: Colors.grey,
                  child: Center(
                      child: Text(
                    AppStrings.dateAndTime,
                    style: getTextStyle(color: Colors.black, isBold: true),
                  )),
                ),
              ),
              SizedBox(
                width: 2,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: 60,
                  color: Colors.grey,
                  child: Center(
                      child: Text(
                    AppStrings.user,
                    style: getTextStyle(color: Colors.black, isBold: true),
                  )),
                ),
              ),
              SizedBox(
                width: 2,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: 60,
                  color: Colors.grey,
                  child: Center(
                      child: Text(
                    AppStrings.action,
                    style: getTextStyle(color: Colors.black, isBold: true),
                  )),
                ),
              ),
              SizedBox(
                width: 2,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: 60,
                  color: Colors.grey,
                  child: Center(
                      child: Text(
                    AppStrings.comment,
                    style: getTextStyle(color: Colors.black, isBold: true),
                  )),
                ),
              )
            ],
          ),
        ),
        Container(
          color: Colors.transparent,
          height: 400,
          child: new ListView.builder(
              shrinkWrap: true,
              itemCount: 5,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext ctxt, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: 60,
                          color: Colors.grey[300],
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("07/09/2020 03:25 pm"),
                          )),
                        ),
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 60,
                          color: Colors.grey[300],
                          child: Center(child: Text("Tech")),
                        ),
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 60,
                          color: Colors.grey[300],
                          child: Center(
                              child: Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Icon(
                                    Icons.check_circle,
                                    size: 5.0,
                                  )),
                              Expanded(flex: 1, child: Text(AppStrings.started)),
                            ],
                          )),
                        ),
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 60,
                          color: Colors.grey[300],
                          child: Center(
                              child: Text(
                            AppStrings.started,
                            style:
                                getTextStyle(color: Colors.black, isBold: true),
                          )),
                        ),
                      )
                    ],
                  ),
                );
              }),
        ),
        SizedBox(
          height: 20,
        ),
        RaisedButton(
          onPressed: () {
// show the dialog
            showDialog(
                barrierDismissible: true,
                context: context,
                builder: (BuildContext context) => AlertDialog(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          new Text(AppStrings.appointmentsCommets,
                              style: getTextStyle(
                                  color: Colors.black,
                                  isBold: true,
                                  fontSize: 16.0)),
                          Icon(Icons.clear)
                        ],
                      ),
                      content: SingleChildScrollView(
                        child: Column(
                          children: [
                            commonTextFormField(
                                new TextEditingController(),
                                AppStrings.typeComment,
                                TextInputType.text,
                                null,
                                true,
                                context,
                                10,
                                false),
                            SizedBox(
                              height: 30,
                            ),
                            RaisedButton(
                              onPressed: () {
// show the dialog
                              },
                              color: Colors.cyan,
                              child: Text(AppStrings.submit),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${AppStrings.appointmentCommentDetails} :",
                              style: getTextStyle(
                                  color: Colors.black, isBold: true),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 60,
                                      color: Colors.grey,
                                      child: Center(
                                          child: Text(
                                        "Date & Time",
                                        style: getTextStyle(
                                            color: Colors.black,
                                            isBold: true,
                                            fontSize: 14.0),
                                      )),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 60,
                                      color: Colors.grey,
                                      child: Center(
                                          child: Text(
                                        "Comments",
                                        style: getTextStyle(
                                            color: Colors.black,
                                            isBold: true,
                                            fontSize: 14.0),
                                      )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              color: Colors.transparent,
                              height: 400,
                              child: new ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: 1,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (BuildContext ctxt, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              height: 60,
                                              color: Colors.grey[300],
                                              child: Center(
                                                  child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child:
                                                    Text("07/09/2020 03:25 pm"),
                                              )),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 2,
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              height: 60,
                                              color: Colors.grey[300],
                                              child:
                                                  Center(child: Text("Tech")),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 2,
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ));
          },
          color: Colors.cyan,
          child: Text("Add Comment"),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 300,
          child: GoogleMap(
            markers: {
              Marker(
                GeoCoord(34.0469058, -118.3503948),
              ),
            },
            initialZoom: 12,
            initialPosition: GeoCoord(34.0469058, -118.3503948),
            // Los Angeles, CA
            mapType: MapType.roadmap,
            interactive: true,
            mobilePreferences: const MobileMapPreferences(
              trafficEnabled: true,
              zoomControlsEnabled: false,
            ),
          ),
        ),
        SizedBox(
          height: 60,
        ),
      ],
    );
  }
}
