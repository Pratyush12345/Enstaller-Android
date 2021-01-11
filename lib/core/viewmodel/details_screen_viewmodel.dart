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
import 'package:geocoder/geocoder.dart';


class DetailsScreenViewModel extends BaseModel{
  String pincode;
  ApiService _apiService=ApiService();
  List<Appointment>appointMentList=[];
  List<ActivityDetailsModel>activityDetailsList=[];
  AppointmentDetails appointmentDetails;
  List<ElectricAndGasMeterModel>electricGasMeterList=[];
  CustomerDetails customerDetails;
  String selectedStatus;
  UserModel user;
  List<String>statusList=[AppStrings.enRoute,AppStrings.onSite_,AppStrings.unScheduled,
    AppStrings.started,AppStrings.cancelled,AppStrings.aborted,AppStrings.completed];
  void onSelectStatus(String value){
    setState(ViewState.Busy);
    selectedStatus=value;

    setState(ViewState.Idle);
  }

//  Future getAppointmentList(UserModel user)async{
//    setState(ViewState.Busy);
//    appointMentList =await _apiService.getAppointmentList('4');
//    setState(ViewState.Idle);
//  }
  void getActivityDetailsList(String appointmentID)async{
    setState(ViewState.Busy);
    print('appId=${appointmentID}');
    activityDetailsList=await _apiService.getActivityLogsAppointmentId(appointmentID);
    setState(ViewState.Idle);
  }
  void initializeData(String appointmentID,String customerID)async{
    setState(ViewState.Busy);
    activityDetailsList=await _apiService.getActivityLogsAppointmentId(appointmentID);
    appointmentDetails=await _apiService.getAppointmentDetails(appointmentID);
    electricGasMeterList=await _apiService.getCustomerMeterListByCustomer(customerID);
    customerDetails =await _apiService.getCustomerById(customerID);
    user=await Prefs.getUser();
    if(statusList.contains(appointmentDetails.appointment.appointmentEventType)){
      selectedStatus=appointmentDetails.appointment.appointmentEventType;
    }else{
      if(appointmentDetails.appointment.appointmentEventType==AppStrings.onSite){
        selectedStatus=AppStrings.onSite_;
      }

    }



    setState(ViewState.Idle);
  }

  void onUpdateStatus(BuildContext context,String appointmentID)async{
   
    setState(ViewState.Busy);
    if(selectedStatus!=null){
      ResponseModel response=await _apiService.updateAppointmentStatus(AppointmentStatusUpdateCredentials(
          strStatus: selectedStatus!=AppStrings.enRoute?selectedStatus:AppStrings.onRoute,intBookedBy: user.intEngineerId.toString(),
          intEngineerId: user.intEngineerId.toString(),
          intId: appointmentDetails.appointment.intId.toString()
      ));
      if(response.statusCode==1){
        appointmentDetails=await _apiService.getAppointmentDetails(appointmentID);
        Navigator.pop(context);
      }else{
        AppConstants.showFailToast(context, response.response);
      }
    }else{
      AppConstants.showFailToast(context,'Please select status');
    }

    setState(ViewState.Idle);
  }
}