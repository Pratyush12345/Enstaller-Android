import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/activity_details_model.dart';
import 'package:enstaller/core/model/appointmentDetailsModel.dart';
import 'package:enstaller/core/model/customer_details.dart';
import 'package:enstaller/core/model/electric_and_gas_metter_model.dart';
import 'package:enstaller/core/model/response_model.dart';
import 'package:enstaller/core/model/send/appointmentStatusUpdateCredential.dart';
import 'package:enstaller/core/model/user_model.dart';
import 'package:enstaller/core/provider/base_model.dart';
import 'package:enstaller/core/service/api_service.dart';
import 'package:enstaller/core/service/pref_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:encrypt/encrypt.dart' as AESencrypt;
import 'dart:convert' as convert;
import 'package:geocoder/geocoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailsScreenViewModel extends BaseModel {
  String pincode;
  ApiService _apiService = ApiService();
  List<Appointment> appointMentList = [];
  List<ActivityDetailsModel> activityDetailsList = [];
  AppointmentDetails appointmentDetails;
  List<ElectricAndGasMeterModel> electricGasMeterList = [];
  CustomerDetails customerDetails;
  bool isformfilled = false;
  String selectedStatus;
  UserModel user;
  List<String> statusList = [
    AppStrings.enRoute,
    AppStrings.onSite_,
    AppStrings.unScheduled,
    AppStrings.started,
    AppStrings.cancelled,
    AppStrings.aborted,
    AppStrings.completed
  ];
  void onSelectStatus(String value) {
    setState(ViewState.Busy);
    selectedStatus = value;

    setState(ViewState.Idle);
  }

//  Future getAppointmentList(UserModel user)async{
//    setState(ViewState.Busy);
//    appointMentList =await _apiService.getAppointmentList('4');
//    setState(ViewState.Idle);
//  }
  void getActivityDetailsList(String appointmentID) async {
    setState(ViewState.Busy);
    print('appId=${appointmentID}');
    activityDetailsList =
        await _apiService.getActivityLogsAppointmentId(appointmentID);
    setState(ViewState.Idle);
  }

  void initializeData(String appointmentID, String customerID) async {
    setState(ViewState.Busy);
    activityDetailsList =
        await _apiService.getActivityLogsAppointmentId(appointmentID);
    appointmentDetails = await _apiService.getAppointmentDetails(appointmentID);
    electricGasMeterList =
        await _apiService.getCustomerMeterListByCustomer(customerID);
    customerDetails = await _apiService.getCustomerById(customerID);
    user = await Prefs.getUser();
    if (statusList
        .contains(appointmentDetails.appointment.appointmentEventType)) {
      selectedStatus = appointmentDetails.appointment.appointmentEventType;
    } else {
      if (appointmentDetails.appointment.appointmentEventType ==
          AppStrings.onSite) {
        selectedStatus = AppStrings.onSite_;
      }
    }

    setState(ViewState.Idle);
  }

  void onUpdateStatus(BuildContext context, String appointmentID) async {
    setState(ViewState.Busy);
    if (selectedStatus != null) {
      ResponseModel response = await _apiService.updateAppointmentStatus(
          AppointmentStatusUpdateCredentials(
              strStatus: selectedStatus != AppStrings.enRoute
                  ? selectedStatus
                  : AppStrings.onRoute,
              intBookedBy: user.intEngineerId.toString(),
              intEngineerId: user.intEngineerId.toString(),
              intId: appointmentDetails.appointment.intId.toString()));
      if (response.statusCode == 1) {
        appointmentDetails =
            await _apiService.getAppointmentDetails(appointmentID);
        Navigator.pop(context);
      } else {
        AppConstants.showFailToast(context, response.response);
      }
    } else {
      AppConstants.showFailToast(context, 'Please select status');
    }

    setState(ViewState.Idle);
  }

  void onRaiseButtonPressed(String customerid, String processId) async {
    setState(ViewState.Busy);
    UserModel userModel = await Prefs.getUser();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String ups = preferences.getString('ups');
    ResponseModel responseModel =
        await _apiService.getMAICheckProcess(customerid, processId);
    if (responseModel.statusCode == 1) {
     isformfilled = true;
    } else {
      isformfilled = false;
      if (processId == "79" || processId == "81") {
        startGasProcess(processId, userModel, ups, customerid);
      } else {
        startElecProcess(processId, userModel, ups, customerid);
      }
    }
    setState(ViewState.Idle);
  }

  startElecProcess(
      String processId, UserModel userModel, String ups, String customerID) {
    try{
    var custId = customerID;
    var DCCMAIWebUrl = 'https://mai.enpaas.com/';

    ElectricAndGasMeterModel model = electricGasMeterList
        .firstWhere((element) => element.strFuel == "ELECTRICITY");
    var mpan = model.strMpan;
    var em = userModel.email.toString();
    var sessionId = userModel.id.toString();
    if (mpan == null || mpan == '') {
    } else {
      var strUrl = '';
      var strPara = '';
      var strEncrypt;
      strPara += 'Enstaller/' +
          custId +
          '/' +
          processId +
          '/' +
          mpan +
          '/' +
          ups +
          '/' +
          sessionId +
          '/' +
          '108' +
          '/' +
          em;

      strEncrypt = encryption(strPara);
      strUrl += '' + DCCMAIWebUrl + '?returnUrl=' + strEncrypt + '';

      launchurl(strUrl);
    }
    }
      catch(err){
      print(err);
    }
    
  }

  startGasProcess(
      String processId, UserModel userModel, String ups, String customerID) {
    var custId = customerID;
    try{
      
    ElectricAndGasMeterModel model =
        electricGasMeterList.firstWhere((element) => element.strFuel == "GAS");
    var mpan = model.strMpan;
    var em = userModel.email.toString();
    var sessionId = userModel.id.toString();
    var DCCMAIWebUrl = 'https://mai.enpaas.com/';
    if (mpan == null || mpan == '') {
    } else {
      var strUrl = '';
      var strEncrypt;
      var strPara = '';
      strPara += 'Enstaller/' +
          custId +
          '/' +
          processId +
          '/' +
          mpan +
          '/' +
          ups +
          '/' +
          sessionId +
          '/' +
          '109' +
          '/' +
          em;
      strEncrypt = encryption(strPara);
      strUrl += '' + DCCMAIWebUrl + '?returnUrl=' + strEncrypt + '';
      launchurl(strUrl);
    }
      }
    catch(err){
      print(err);
    }
  }

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
}
