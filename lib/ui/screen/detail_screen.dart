import 'package:encrypt/encrypt.dart' as AESencrypt;
import 'package:configurable_expansion_tile/configurable_expansion_tile.dart';
import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/constant/image_file.dart';
import 'package:enstaller/core/constant/size_config.dart';
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/response_model.dart';
import 'package:enstaller/core/model/send/answer_credential.dart';
import 'package:enstaller/core/provider/base_view.dart';
import 'package:enstaller/core/service/api_service.dart';
import 'package:enstaller/core/viewmodel/details_screen_viewmodel.dart';
import 'package:enstaller/ui/screen/both_close_job.dart';
import 'package:enstaller/ui/screen/elec_close_job.dart';
import 'package:enstaller/ui/screen/gas_close_job.dart';
import 'package:enstaller/ui/screen/survey.dart';
import 'package:enstaller/ui/screen/widget/abort_appointment_widget.dart';
import 'package:enstaller/ui/screen/widget/appointment/appointment_data_row.dart';
import 'package:enstaller/ui/screen/widget/appointment_details/appointment_details_row_widget.dart';
import 'package:enstaller/ui/screen/widget/comment_dialog_widget.dart';
import 'package:enstaller/ui/screen/widget/update_status_dialog_widget.dart';
import 'package:enstaller/ui/shared/app_drawer_widget.dart';
import 'package:enstaller/ui/shared/app_image_widget.dart';
import 'package:enstaller/ui/shared/appbuttonwidget.dart';
import 'package:enstaller/ui/shared/warehouse_app_drawer.dart';
import 'package:enstaller/ui/util/MessagingService/FirebaseMessaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_maps/flutter_google_maps.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreenArguments {
  String appointmentID;
  String strBookingReference;
  String customerID;
  DetailScreenArguments({
    this.appointmentID,
    this.strBookingReference,
    this.customerID,
  });
}

class DetailScreen extends StatefulWidget {
  static const String routeName = '/detail';
  final DetailScreenArguments arguments;
  DetailScreen({this.arguments});
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isToShowBottomBar = false;
  Map<String, String> _processid = {
    "EMREM": "6",
    "GMREM": "81",
    "GICOM": "79",
    "EICOM": "1"
  };
  Map<int, String> _smest2displaybutton = {
    0: "EMREM",
    1: "GMREM",
    2: "EMREM+GMREM",
    3: "EMREM",
    4: "EICOM",
    5: "GICON",
    6: "EICOM+GICOM",
    7: "EICOM"
  };
  Map<int, String> _disablesmest2displaybutton = {
    0: "EMREM for Electricity Generated",
    1: "GMREM for Gas Generated",
    2: "EMREM for Electricity Generated+GMREM for Gas Generated",
    3: "EMREM for Electricity Generated",
    4: "EICOM for Electricity Generated",
    5: "GICON for Gas Generated",
    6: "EICOM for Electricity Generated+GICOM for Gas Generated",
    7: "EICOM for Electricity Generated"
  };
  Map<String, Map<String, int>> _appointmentandjobtype = {
    "Meter removal, Scheduled Exchange, Emergency Exchange": {
      "SMETS2 1ph Elec": 0,
      "SMETS2 Gas": 1,
      "SMETS2 Dual": 2,
      "SMETS2 3ph Elec": 3,
    },
    "New Connection": {
      "SMETS2 1ph Elec": 4,
      "SMETS2 Gas": 5,
      "SMETS2 Dual": 6,
      "SMETS2 3ph Elec": 7
    }
  };
  ApiService _apiService = ApiService();
  

  //Declaration of scaffold key
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  int selected;
 
  encryption(String value) {
    final key = AESencrypt.Key.fromUtf8('8080808080808080');
    final iv = AESencrypt.IV.fromUtf8('8080808080808080');
    final encrypter = AESencrypt.Encrypter(
        AESencrypt.AES(key, mode: AESencrypt.AESMode.cbc, padding: 'PKCS7'));
    final encrypted = encrypter.encrypt(value, iv: iv);

    return encrypted.base64
        .toString()
        .replaceAll('/', 'SLH')
        .replaceAll('+', 'PLS')
        .replaceAll('/', 'SLH')
        .replaceAll('/', 'SLH')
        .replaceAll('/', 'SLH')
        .replaceAll('/', 'SLH')
        .replaceAll('+', 'PLS')
        .replaceAll('+', 'PLS')
        .replaceAll('+', 'PLS')
        .replaceAll('+', 'PLS');
  }


  launchurl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not open the map.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<DetailsScreenViewModel>(
      onModelReady: (model) => model.initializeData(
          widget.arguments.appointmentID, widget.arguments.customerID),
      builder: (context, model, child) {
        return Scaffold(
            backgroundColor: AppColors.scafoldColor,
            key: _scaffoldKey,
            drawer: Drawer(
              child: GlobalVar.roleId == 5 ? WareHouseDrawerWidget() :  AppDrawerWidget(),
            ),
            appBar: AppBar(
              backgroundColor: AppColors.green,
              leading: Padding(
                padding: const EdgeInsets.all(18.0),
                child: InkWell(
                    onTap: () {
                      _scaffoldKey.currentState.openDrawer();
                    },
                    child: Image.asset(
                      ImageFile.menuIcon,
                      color: AppColors.whiteColor,
                    )),
              ),
              title: Text(
                "${AppStrings.APPOINTMENT_DETAILS}",
                style: TextStyle(color: AppColors.whiteColor),
              ),
              centerTitle: true,
              // actions: [
              //   Padding(
              //     padding: const EdgeInsets.all(18.0),
              //     child: Image.asset(
              //       ImageFile.notification,
              //       color: AppColors.whiteColor,
              //     ),
              //   ),
              // ],
            ),
//            floatingActionButton: (isToShowBottomBar == true)
//                ? FloatingActionButton(
//                backgroundColor: Colors.blue,
//                onPressed: () async{
//                  final url = Uri.encodeFull('https://www.google.com/maps/dir/current+location/${model.customerDetails.strPostCode}');
////                  String googleUrl = 'https://www.google.com/maps/search/?api=1&query=${model.currentLocation.latitude},${model.currentLocation.longitude}';
//                  if (await canLaunch(url)) {
//                    await launch(url);
//                  } else {
//                    throw 'Could not open the map.';
//                  }
//                },
//                tooltip: '',
//                child: RotatedBox(
//                  quarterTurns: 1,
//                  child: Icon(
//                    Icons.navigation,
//                    color: Colors.white,
//                  ),
//                ))
//                : SizedBox(),
//            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//            bottomNavigationBar: (isToShowBottomBar == true)
//                ? BottomAppBar(
//                shape: CircularNotchedRectangle(),
//                notchMargin: 10,
//                child: Container(
//                  height: 56,
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    children: <Widget>[
//                      SizedBox(width: 40), // The dummy child
//                    ],
//                  ),
//                ))
//                : SizedBox(),
            body: model.state == ViewState.Busy
                ? AppConstants.circulerProgressIndicator()
                : RefreshIndicator(
                   onRefresh: () => Future.delayed(Duration.zero)
                        .whenComplete(() => model.initializeData(
          widget.arguments.appointmentID, widget.arguments.customerID)),
                                  child: SingleChildScrollView(
                      child: Column(
                        children: [
                          _engineerInfo(model),
                          // model.appointmentDetails.appointment
                          //             .appointmentEventType !=
                          //         AppStrings.completed
                          //     ? Padding(
                          //         padding: SizeConfig.sidepadding,
                          //         child: AppButton(
                          //           height: 40,
                          //           radius: 15,
                          //           color: AppColors.green,
                          //           textStyle:
                          //               TextStyle(color: AppColors.whiteColor),
                          //           buttonText: AppStrings.updateStatusC,
                          //           onTap: () {
                          //             AppConstants.showAppDialog(
                          //                 context: context,
                          //                 child: UpdateStatusDialogWidget(
                          //                   model: model,
                          //                   appointmentID:
                          //                       widget.arguments.appointmentID,
                          //                 ));
                          //           },
                          //         ),
                          //       )
                          //     : Container(),
                          _surveyInfo(model),
                          Padding(
                            padding: SizeConfig.padding,
                            child: ListView.builder(
                                key: Key('builder ${selected.toString()}'),
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: 5,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext ctxt, int index) {
                                  return ConfigurableExpansionTile(
                                      key: Key(index.toString()),
                                      initiallyExpanded: index == selected,
                                      header: Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 20,
                                              top: 20,
                                              bottom: 10,
                                              right: 20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                _getHeaderText(index),
                                                style: getTextStyle(
                                                    color: Colors.white,
                                                    isBold: true,
                                                    fontSize: 16.0),
                                              ),
                                              Icon(
                                                Icons.add,
                                                color: AppColors.whiteColor,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      headerBackgroundColorStart: AppColors.green,
                                      headerBackgroundColorEnd: AppColors.green,
                                      onExpansionChanged: (value) {
                                        if (value) {
                                          setState(() {
                                            selected = index;
                                          });
                                          if (value == true && index == 4) {
                                            setState(() {
                                              isToShowBottomBar = true;
                                            });
                                          } else {
                                            setState(() {
                                              isToShowBottomBar = false;
                                            });
                                          }
                                        } else {
                                          setState(() {
                                            isToShowBottomBar = false;
                                            selected = -1;
                                          });
                                        }
                                      },
                                      headerExpanded: Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 20,
                                              top: 20,
                                              bottom: 10,
                                              right: 20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                _getHeaderText(index),
                                                style: getTextStyle(
                                                    color: Colors.white,
                                                    isBold: true,
                                                    fontSize: 16.0),
                                              ),
                                              RotatedBox(
                                                  quarterTurns: 2,
                                                  child: Icon(
                                                    Icons.remove,
                                                    color: AppColors.whiteColor,
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ),
                                      children: [
                                        _getChildrenWidget(selected, model)
                                      ]);
                                }),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "AVAILABLE ACTION",
                            textAlign: TextAlign.start,
                            style: TextStyle(fontWeight: FontWeight.normal),
                          ),
                          // SizedBox(
                          //   height: 10.0,
                          // ),
                          // Padding(
                          //   padding: SizeConfig.sidepadding,
                          //   child: AppButton(
                          //     height: 40,
                          //     color: AppColors.darkBlue,
                          //     buttonText: "Check Close Job",
                          //     radius: 15,
                          //     textStyle: TextStyle(color: AppColors.whiteColor),
                          //     onTap: ()  {
                          //       print("---------------------");
                          //       print("length...........${model.checkCloseJobModel.table.length}");
                                
                          //       model.checkCloseJobModel.table.forEach((element) { 
                          //         print(element.intId);
                          //       });
                          //       print("---------------------");
                          //       if(model.checkCloseJobModel.table.length ==1 && model.checkCloseJobModel.table[0].strFuel == "ELECTRICITY")
                          //       Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ElecCloseJob(list: model.checkCloseJobModel.table , fromTab: false, dsmodel: model,)));
                          //       else if(model.checkCloseJobModel.table.length ==1 && model.checkCloseJobModel.table[0].strFuel == "GAS")
                          //       Navigator.of(context).push(MaterialPageRoute(builder: (context)=>GasCloseJob(list: model.checkCloseJobModel.table, fromTab: false,dsmodel: model, )));
                          //       else if(model.checkCloseJobModel.table.length ==2 )
                          //       Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BothCloseJob(list: model.checkCloseJobModel.table, dsmodel: model,)));
                                
                          //       // SharedPreferences pref = await SharedPreferences.getInstance();
                          //       // pref.remove("saved+${widget.arguments.appointmentID.trim()}");
                          //       // pref.remove("disabled+${widget.arguments.appointmentID.trim()}");
                          //     },
                          //   ),
                          // ),
                          SizedBox(
                            height: 10.0,
                          ),
                          if(model.appointmentDetails.appointment.appointmentEventType =="Scheduled")
                          Padding(
                            padding: SizeConfig.sidepadding,
                            child: AppButton(
                              height: 40,
                              color: AppColors.darkBlue,
                              buttonText: AppStrings.forward_button,
                              radius: 15,
                              textStyle: TextStyle(color: AppColors.whiteColor),
                              onTap: ()  async{
                                ResponseModel responseModel = await _apiService.updateCallForwardAppointment(widget.arguments.appointmentID.trim());
                                print(responseModel.statusCode.toString()+"......line373");
                               if(responseModel.statusCode ==1)
                               model.initializeData(widget.arguments.appointmentID, widget.arguments.customerID);
                              }
                                ,
                            ),
                          ),
                          if(model.appointmentDetails.appointment.appointmentEventType =="Scheduled")
                          SizedBox(
                            height: 10.0,
                          ),
                          if(model.appointmentDetails.appointment.bCompleteForwardCall && model.appointmentDetails.appointment.appointmentEventType =="Scheduled")
                          Padding(
                            padding: SizeConfig.sidepadding,
                            child: AppButton(
                              height: 40,
                              color: AppColors.darkBlue,
                              buttonText: "En Route",
                              radius: 15,
                              textStyle: TextStyle(color: AppColors.whiteColor),
                              onTap: ()  async{

                                model.onUpdateStatusOnRoute(context, widget.arguments.appointmentID);
                                model.initializeData(widget.arguments.appointmentID, widget.arguments.customerID);
                              
                                 
                                },
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Padding(
                            padding: SizeConfig.sidepadding,
                            child: AppButton(
                              height: 40,
                              color: AppColors.darkBlue,
                              buttonText: AppStrings.ADD_COMMENT,
                              radius: 15,
                              textStyle: TextStyle(color: AppColors.whiteColor),
                              onTap: () {
                                AppConstants.showAppDialog(
                                    context: context,
                                    child: CommentDialogWidget(
                                      appointmentID:
                                          widget.arguments.appointmentID,
                                    ));
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          _getDisplayButton(_checkbuttonindex(model), model),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: SizeConfig.sidepadding,
                            child: Container(
                              height: 300,
                              child: GoogleMap(
                                markers: {
                                  Marker(
                                    GeoCoord(34.0469058, -118.3503948),
                                  ),
                                },
                                initialZoom: 12,
                                initialPosition:
                                    GeoCoord(34.0469058, -118.3503948),
                                // Los Angeles, CA
                                mapType: MapType.roadmap,
                                interactive: true,
                                mobilePreferences: const MobileMapPreferences(
                                  trafficEnabled: true,
                                  zoomControlsEnabled: false,
                                ),
                              ),
                            ),
                          ),
                          SizeConfig.verticalSpaceSmall(),
                          Padding(
                            padding: SizeConfig.sidepadding,
                            child: InkWell(
                              onTap: () async {
                                final url = Uri.encodeFull(
                                    'https://www.google.com/maps/dir/current+location/${model.customerDetails.strPostCode}');
//                  String googleUrl = 'https://www.google.com/maps/search/?api=1&query=${model.currentLocation.latitude},${model.currentLocation.longitude}';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not open the map.';
                                }
                              },
                              child: Container(
                                width: SizeConfig.screenWidth,
                                height: 40,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        height: SizeConfig.screenHeight * .02,
                                        width: SizeConfig.screenHeight * .02,
                                        child: Image.asset(ImageFile.direction)),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      AppStrings.GET_DIRECTIONS,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.whiteColor),
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                    color: AppColors.green,
                                    borderRadius: BorderRadius.circular(15)),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 60,
                          ),
                        ],
                      ),
                    ),
                ));
      },
    );
  }

  int _checkbuttonindex(DetailsScreenViewModel model) {
    int id;
    _appointmentandjobtype.forEach((key, value) {
      
      if (key
          .contains(model.appointmentDetails.appointment.strAppointmentType.trim())) {
            
        id = value[model.appointmentDetails.appointment.strJobType.trim()];
        
              }
    });
    
    return id;
  }

  Widget _getDisplayButton(int id, DetailsScreenViewModel model) {
    if (id != null) {
      return Column(
        children: [
          (id != 2 && id != 6)
              ? Column(
                  children: [
                    Text(
                      "SMETS2 XMREM ACTION",
                      textAlign: TextAlign.start,
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding( 
                      padding: SizeConfig.sidepadding,
                      child: AppButton(
                        height: 40,
                        color: !model.isformfilled[_smest2displaybutton[id]]
                            ? AppColors.darkBlue
                            : AppColors.disablebuttonColor,
                        buttonText: !model.isformfilled[_smest2displaybutton[id]]
                            ? "Raise "+_smest2displaybutton[id]
                            : _disablesmest2displaybutton[id],
                        radius: !model.isformfilled[_smest2displaybutton[id]]? 15 : 6,
                        textStyle: TextStyle(
                            color: !model.isformfilled[_smest2displaybutton[id]]
                                ? AppColors.whiteColor
                                : AppColors.black),
                        onTap: !model.isformfilled[_smest2displaybutton[id]]
                            ? () {
                                model.onRaiseButtonPressed(
                                    widget.arguments.customerID,
                                    _processid[_smest2displaybutton[id]]);
                              }
                            : () {},
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    Text(
                      "SMETS2 XMREM ACTION",
                      textAlign: TextAlign.start,
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: SizeConfig.sidepadding,
                      child: AppButton(
                        height: 40,
                        color: !model.isformfilled[_smest2displaybutton[id].split("+")[0]]
                            ? AppColors.darkBlue
                            : AppColors.disablebuttonColor,
                        buttonText: !model.isformfilled[_smest2displaybutton[id].split("+")[0]]
                            ? "Raise "+_smest2displaybutton[id].split("+")[0]
                            : _disablesmest2displaybutton[id].split("+")[0],
                        radius: !model.isformfilled[_smest2displaybutton[id].split("+")[0]]? 15 : 6,
                        textStyle: TextStyle(
                            color: !model.isformfilled[_smest2displaybutton[id].split("+")[0]]
                                ? AppColors.whiteColor
                                : AppColors.black),
                        onTap: !model.isformfilled[_smest2displaybutton[id].split("+")[0]]
                            ? () {
                                model.onRaiseButtonPressed(
                                    widget.arguments.customerID,
                                    _processid[_smest2displaybutton[id].split("+")[0]]
                                        );
                              }
                            : () {},
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: SizeConfig.sidepadding,
                      child: AppButton(
                        height: 40,
                        color: !model.isformfilled[_smest2displaybutton[id].split("+")[1]]
                            ? AppColors.darkBlue
                            : AppColors.disablebuttonColor,
                        buttonText: !model.isformfilled[_smest2displaybutton[id].split("+")[1]]
                            ? "Raise "+_smest2displaybutton[id].split("+")[1]
                            : _disablesmest2displaybutton[id].split("+")[1],
                        radius: !model.isformfilled[_smest2displaybutton[id].split("+")[1]]? 15 : 6,
                        textStyle: TextStyle(
                            color: !model.isformfilled[_smest2displaybutton[id].split("+")[1]]
                                ? AppColors.whiteColor
                                : AppColors.black),
                        onTap: !model.isformfilled[_smest2displaybutton[id].split("+")[1]]
                            ? () {
                                model.onRaiseButtonPressed(
                                    widget.arguments.customerID,
                                    _processid[_smest2displaybutton[id].split("+")[1]]
                                        );
                              }
                            : () {},
                      ),
                    ),
                  ],
                )
        ],
      );
    }
    return Container();
  }

  // engineer info
  Widget _engineerInfo(DetailsScreenViewModel model) {
    return Padding(
      padding: SizeConfig.padding,
      child: Container(
        decoration: BoxDecoration(color: AppColors.whiteColor),
        child: Column(
          children: [
            AppointmentDetailsRowWidget(
              firstText: AppStrings.appointmentStatus,
              secondChild: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 20,
                    width: 20,
                    child: SvgPicture.asset(
                        AppConstants.getStatusImageUrl(model.appointmentDetails
                            .appointment.appointmentEventType),
                        semanticsLabel: 'Status'),
                  ),
                  SizeConfig.horizontalSpaceSmall(),
                  Text(
                     model.appointmentDetails.appointment.appointmentEventType =="InRoute"? "EnRoute" : model.appointmentDetails.appointment.appointmentEventType ?? "",
                    style: getTextStyle(
                        color: AppColors.statusColor(model.appointmentDetails
                            .appointment.appointmentEventType),
                        isBold: true),
                  ),
                ],
              ),
            ),
            AppointmentDetailsRowWidget(
              firstText: AppStrings.assignedEngineer,
              secondText:
                  model.appointmentDetails.appointment.engineerName ?? "",
            ),
            AppointmentDetailsRowWidget(
              borderEnable: false,
              firstText: AppStrings.bookingReference,
              secondText:
                  model.appointmentDetails.appointment.strBookingReference ??
                      "",
            ),
          ],
        ),
      ),
    );
  }

  //survey info
  Widget _surveyInfo(DetailsScreenViewModel model) {
    return Padding(
      padding: SizeConfig.padding,
      child: Container(
        decoration: BoxDecoration(color: AppColors.whiteColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppointmentDetailsRowWidget(
              firstText: AppStrings.supplier,
              secondChild: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ViewAppImage(
                    imageUrl: 'https://enstaller.enpaas.com/Upload/Supplier/' +
                        model.appointmentDetails.appointment.strLogo,
                    height: 20,
                    width: 50,
                  ),
                ],
              ),
            ),
            AppointmentDetailsRowWidget(
              firstText: AppStrings.appointmentSurvey,
              secondChild: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if(model.appointmentDetails.appointment?.strJobType != "Full Day Hire" &&
                   model.appointmentDetails.appointment?.strJobType!= "Half Day Hire")
                  AppButton(
                    color: AppColors.green,
                    height: 30,
                    width: SizeConfig.screenWidth * .23,
                    buttonText: AppStrings.SURVEY,
                    textStyle: TextStyle(color: AppColors.whiteColor),
                    radius: 15,
                    onTap: () {
                      bool _isedit = model.appointmentDetails.appointment
                                          .surveyReceived ==
                                      AppStrings.yes
                                  ? true
                                  : false;
                      String _status = model.appointmentDetails.appointment.appointmentEventType??"";            
                      print(_status);
                      if(_status != "Scheduled"){
                      if(!_isedit && _status!="OnSite")
                      model.onUpdateStatusOnSite(context, widget.arguments.appointmentID);
                      
                      Navigator.of(context).pushNamed(SurveyScreen.routeName,
                          arguments: SurveyArguments(
                             customerID: widget.arguments.customerID,
                             dsmodel: model,
                              appointmentID: widget.arguments.appointmentID,
                              edit: 
                              model.appointmentDetails.appointment
                                          .surveyReceived ==
                                      AppStrings.yes
                                  ? true
                                  : false
                                  
                                  )).then((value){
                                    if(GlobalVar.isloadAppointmentDetail)
                                    {model.initializeData(
                                    widget.arguments.appointmentID, widget.arguments.customerID);
                                    GlobalVar.isloadAppointmentDetail = false;
                                    }
                                  });   
                      }             
                    },
                  ),

                  if(model.appointmentDetails.appointment?.strJobType == "Full Day Hire" ||
                   model.appointmentDetails.appointment?.strJobType == "Half Day Hire")
                  AppButton(
                    color: AppColors.green,
                    height: 30,
                    width: SizeConfig.screenWidth * .23,
                    buttonText: "Close Job",
                    textStyle: TextStyle(color: AppColors.whiteColor),
                    radius: 15,
                    onTap: () {
                                if(model.checkCloseJobModel.table.length ==1 && model.checkCloseJobModel.table[0].strFuel == "ELECTRICITY")
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ElecCloseJob(list: model.checkCloseJobModel.table , fromTab: false, dsmodel: model,)))
                                .then((value){
                                    if(GlobalVar.isloadAppointmentDetail)
                                    {model.initializeData(
                                    widget.arguments.appointmentID, widget.arguments.customerID);
                                    GlobalVar.isloadAppointmentDetail = false;
                                    }
                                  });
                                else if(model.checkCloseJobModel.table.length ==1 && model.checkCloseJobModel.table[0].strFuel == "GAS")
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>GasCloseJob(list: model.checkCloseJobModel.table, fromTab: false,dsmodel: model, )))
                                .then((value){
                                    if(GlobalVar.isloadAppointmentDetail)
                                    {model.initializeData(
                                    widget.arguments.appointmentID, widget.arguments.customerID);
                                    GlobalVar.isloadAppointmentDetail = false;
                                    }
                                  });
                                else if(model.checkCloseJobModel.table.length ==2 )
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BothCloseJob(list: model.checkCloseJobModel.table, dsmodel: model,)))
                                .then((value){
                                    if(GlobalVar.isloadAppointmentDetail)
                                    {model.initializeData(
                                    widget.arguments.appointmentID, widget.arguments.customerID);
                                    GlobalVar.isloadAppointmentDetail = false;
                                    }
                                  });
                                
                                
                                
                                },
                  ),
                ],
              ),
            ),
            AppointmentDetailsRowWidget(
              firstText: AppStrings.surveyReceived,
              secondText: model.appointmentDetails.appointment.surveyReceived,
            ),
          ],
        ),
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
        return Colors.teal;
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
        return AppStrings.appointmentInformation;
        break;

      case 1:
        return AppStrings.customerDetail;
        break;

      case 2:
        return AppStrings.electricMeterInformation;
        break;

      case 3:
        return AppStrings.gasMeterInformation;
        break;

      case 4:
        return AppStrings.activityDetail;
        break;
    }
  }

  //get widgets data  as per text
  Widget _getChildrenWidget(int index, DetailsScreenViewModel model) {
    switch (index) {
      case 0:
        return _basicInfo(model);

      case 1:
        return _customerDetail(model);
      case 2:
        return _electricityInfo(model);
      case 3:
        return gasMeterData(model);
      case 4:
        return _activityData(model);
    }

    return (index == 4) ? _activityData(model) : _basicInfo(model);
  }

  //_demo data
  Widget _basicInfo(DetailsScreenViewModel model) {
    return Container(
      decoration: BoxDecoration(color: AppColors.expandedColor),
      child: Column(
        children: [
          AppointmentDataRow(
            firstText: AppStrings.date,
            secondText: AppConstants.formattedSingeDate(DateTime.parse(
                    model.appointmentDetails.appointment?.dteBookedDate)) ??
                "",
          ),
          AppointmentDataRow(
            firstText: AppStrings.timeSlot,
            secondText:
                model.appointmentDetails.appointment?.strBookedTime ?? "",
          ),
          AppointmentDataRow(
            firstText: AppStrings.workType,
            secondText:
                model.appointmentDetails.appointment.strAppointmentType +
                        ">" +
                        model.appointmentDetails.appointment?.strJobType ??
                    "",
          ),
          AppointmentDataRow(
            firstText: AppStrings.bookOn,
            secondText: AppConstants.formattedDate(DateTime.parse(
                model.appointmentDetails.appointment?.dteCreatedDate)),
          ),
          AppointmentDataRow(
            firstText: AppStrings.bookBy,
            secondText: model.appointmentDetails.appointment?.strBookedBy ?? "",
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
              style: getTextStyle(color: AppColors.darkGrayColor, isBold: true),
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
  Widget _activityData(DetailsScreenViewModel model) {
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
                  color: AppColors.green,
                  child: Center(
                      child: Text(
                    AppStrings.dateAndTime,
                    style: getTextStyle(color: Colors.white, isBold: true),
                  )),
                ),
              ),
              SizedBox(
                width: 2,
              ),
              Expanded(
                flex: 2,
                child: Container(
                  height: 60,
                  color: AppColors.green,
                  child: Center(
                      child: Text(
                    AppStrings.user,
                    style: getTextStyle(color: Colors.white, isBold: true),
                  )),
                ),
              ),
              SizedBox(
                width: 2,
              ),
              Expanded(
                flex: 3,
                child: Container(
                  height: 60,
                  color: AppColors.green,
                  child: Center(
                      child: Text(
                    AppStrings.comment,
                    style: getTextStyle(color: Colors.white, isBold: true),
                  )),
                ),
              )
            ],
          ),
        ),
        Container(
          color: Colors.transparent,
//          height: 400,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: model.activityDetailsList.length,
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
                            child: Text(
                                AppConstants.formattedDate(DateTime.parse(model
                                    .activityDetailsList[index]
                                    .dteCreatedDate)),
                                textAlign: TextAlign.center),
                          )),
                        ),
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: 60,
                          color: Colors.grey[300],
                          child: Center(
                              child: Text(
                                  model.activityDetailsList[index].strUserName,
                                  textAlign: TextAlign.center)),
                        ),
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          height: 60,
                          color: Colors.grey[300],
                          child: Row(
                            children: [
                              SizeConfig.horizontalSpaceSmall(),
                              SizedBox(
                                height: 10,
                                width: 10,
                                child: SvgPicture.asset(
                                    AppConstants.getStatusImageUrl(
                                        AppConstants.getStatusFromStrEventType(
                                            model.activityDetailsList[index]
                                                .strEventType,
                                            model.activityDetailsList[index]
                                                .strComment)),
                                    semanticsLabel: 'Status'),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Flexible(
                                child: Text(
                                  model.activityDetailsList[index].strComment,
                                  textAlign: TextAlign.center,
                                  style: getTextStyle(
                                      color: Colors.black, isBold: true),
                                ),
                              ),
                            ],
                          ),
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
      ],
    );
  }

  Widget _customerDetail(DetailsScreenViewModel model) {
    return Container(
      decoration: BoxDecoration(color: AppColors.expandedColor),
      child: Column(
        children: [
          AppointmentDataRow(
            firstText: AppStrings.name,
            secondText:
                AppStrings.mr + model.customerDetails.strContactName ?? "",
          ),
          AppointmentDataRow(
            firstText: AppStrings.contactNumber,
            secondText: model.customerDetails.strContactTelephone ?? '',
          ),
          AppointmentDataRow(
            firstText: AppStrings.email,
            secondText: model.customerDetails.strEmail != null
                ? model.customerDetails.strEmail
                : '',
          ),
          AppointmentDataRow(
            firstText: AppStrings.address,
            secondText: model.customerDetails.strAddress ?? "",
          ),
          AppointmentDataRow(
            firstText: AppStrings.postCode,
            secondText: model.customerDetails.strPostCode ?? "",
          ),
          AppointmentDataRow(
            firstText: AppStrings.accountNumber,
            secondText: model.customerDetails.strAccountNumber ?? "",
          ),
        ],
      ),
    );
  }

  Widget gasMeterData(DetailsScreenViewModel model) {
    return Container(
      decoration: BoxDecoration(color: AppColors.expandedColor),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: model.electricGasMeterList.length,
        itemBuilder: (context, i) {
          if (model.electricGasMeterList[i].strFuel == AppStrings.GAS) {
            return Column(
              children: [
                AppointmentDataRow(
                  firstText: AppStrings.meterMode,
                  secondText: model.electricGasMeterList[i].strFuel ?? "",
                ),
                AppointmentDataRow(
                  firstText: AppStrings.meterMode,
                  secondText: model.electricGasMeterList[i].strFuel ?? "",
                ),
                AppointmentDataRow(
                  firstText: AppStrings.mPRN,
                  secondText: model.electricGasMeterList[i].strMpan ?? "",
                ),
                AppointmentDataRow(
                  firstText: AppStrings.meterSerialNo,
                  secondText:
                      model.electricGasMeterList[i].strMeterSerialNo ?? "",
                ),
                AppointmentDataRow(
                  firstText: AppStrings.pressure,
                  secondText: "",
                ),
              ],
            );
          }
          if(model.electricGasMeterList.length!=2)
          return Column(
            children: [
              AppointmentDataRow(
                firstText: AppStrings.meterMode,
                secondText: '',
              ),
              AppointmentDataRow(
                firstText: AppStrings.mPRN,
                secondText: '',
              ),
              AppointmentDataRow(
                firstText: AppStrings.meterSerialNo,
                secondText: '',
              ),
              AppointmentDataRow(
                firstText: AppStrings.pressure,
                secondText: '',
              ),
            ],
          );
          else{
            return SizedBox();
          }
        },
      ),
    );
  }

  Widget _electricityInfo(DetailsScreenViewModel model) {
    return Container(
      decoration: BoxDecoration(color: AppColors.expandedColor),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: model.electricGasMeterList.length,
        itemBuilder: (context, i) {
          if (model.electricGasMeterList[i].strFuel == AppStrings.ELECTRICITY) {
            return Column(
              children: [
                AppointmentDataRow(
                  firstText: AppStrings.meterMode,
                  secondText: model.electricGasMeterList[i].strFuel ?? "",
                ),
                AppointmentDataRow(
                  firstText: AppStrings.mPAN,
                  secondText: model.electricGasMeterList[i].strMpan ?? "",
                ),
                AppointmentDataRow(
                  firstText: AppStrings.meterSerialNo,
                  secondText:
                      model.electricGasMeterList[i].strMeterSerialNo ?? "",
                ),
                AppointmentDataRow(
                  firstText: AppStrings.profileClass,
                  secondText:
                      model.electricGasMeterList[i].strProfileClass ?? "",
                ),
                AppointmentDataRow(
                  firstText: AppStrings.sSC,
                  secondText: model.electricGasMeterList[i].strSSC ?? "",
                ),
              ],
            );
          }
          
          
          if(model.electricGasMeterList.length!=2)
          return Column(
            children: [
              AppointmentDataRow(
                firstText: AppStrings.meterMode,
                secondText: '',
              ),
              AppointmentDataRow(
                firstText: AppStrings.mPAN,
                secondText: '',
              ),
              AppointmentDataRow(
                firstText: AppStrings.meterSerialNo,
                secondText: '',
              ),
              AppointmentDataRow(
                firstText: AppStrings.profileClass,
                secondText: '',
              ),
              AppointmentDataRow(
                firstText: AppStrings.sSC,
                secondText: '',
              ),
            ],
          );
          else{
            return SizedBox();
          }
        },
      ),
    );
  }
}
