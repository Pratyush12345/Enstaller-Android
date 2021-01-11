
import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/response_model.dart';
import 'package:enstaller/core/model/send/appointmentStatusUpdateCredential.dart';
import 'package:enstaller/core/model/update_status_model.dart';
import 'package:enstaller/core/model/user_model.dart';
import 'package:enstaller/core/provider/base_model.dart';
import 'package:enstaller/core/service/api_service.dart';
import 'package:enstaller/core/service/pref_service.dart';
import 'package:flutter/cupertino.dart';

class UpdateStatusViewModel extends BaseModel{

  UserModel user;
  ApiService _apiService=ApiService();

  String selectedStatus=AppStrings.started;
  List<String>statusList=[AppStrings.enRoute,AppStrings.onSite_,AppStrings.unScheduled,
    AppStrings.started,AppStrings.cancelled,AppStrings.aborted,AppStrings.completed];

  List<StatusModel>appointmentStatusList=[];
  List<StatusModel>_appointmentStatusList=[];
  StatusModel selectedAppointment=StatusModel();
  StatusModel expandSelectedStatus=StatusModel();
  List<StatusModel>selectedAppointments=[];
  bool search=false;
  void onSearch(){
    setState(ViewState.Busy);
    search=!search;
    if(!search){
      appointmentStatusList=_appointmentStatusList;
    }

    setState(ViewState.Idle);
  }
  void textChange(String val){
    setState(ViewState.Busy);
    appointmentStatusList=[];
    _appointmentStatusList.forEach((element) {
     if(element.customerName.toLowerCase().contains(val.toLowerCase())||element.strBookingReference.toLowerCase().contains(val.toLowerCase())||element.strCompanyName.toLowerCase().contains(val.toLowerCase())){
       appointmentStatusList.add(element);
     }
    });

    setState(ViewState.Idle);

  }

  void initializeData()async{
    setState(ViewState.Busy);
    user =await Prefs.getUser();
    _appointmentStatusList=await _apiService.appointmentDataEventsbyEngineer(user.intEngineerId.toString());
    appointmentStatusList=_appointmentStatusList;

    setState(ViewState.Idle);

  }
  void onSelectStatus(String value){
    setState(ViewState.Busy);
    selectedStatus=value;

    setState(ViewState.Idle);
  }
  void onSelectExpand(StatusModel statusModel){
    setState(ViewState.Busy);
    if(expandSelectedStatus.intId==statusModel.intId){
      expandSelectedStatus=StatusModel();
    }else{
      expandSelectedStatus =statusModel;
    }

    setState(ViewState.Idle);
  }
  void onSelectAppointment(StatusModel value){
    setState(ViewState.Busy);
    selectedAppointment=value;
    if(selectedAppointments.contains(value)){
      selectedAppointments.remove(value);
    }else{
      selectedAppointments.add(value);
    }


    setState(ViewState.Idle);
  }
  void onUpdateStatus(BuildContext context)async{

    if(selectedAppointments.length>0){
      setState(ViewState.Busy);
     for (int i=0;i<selectedAppointments.length;i++){
       ResponseModel response=await _apiService.updateAppointmentStatus(AppointmentStatusUpdateCredentials(
           strStatus: selectedStatus!=AppStrings.enRoute?selectedStatus:AppStrings.onRoute,intBookedBy: selectedAppointment.intBookedBy.toString(),
           intEngineerId: user.intEngineerId.toString(),
           intId: selectedAppointment.intId.toString()
       ));
       if(i==selectedAppointments.length-1){
         setState(ViewState.Idle);
         if(response.statusCode==1){
           AppConstants.showSuccessToast(context, response.response);
           appointmentStatusList=await _apiService.appointmentDataEventsbyEngineer(user.intEngineerId.toString());
           setState(ViewState.Idle);
         }else{
           setState(ViewState.Idle);
           AppConstants.showFailToast(context, response.response);
         }
       }

     }


    }else {
      AppConstants.showFailToast(context, 'Please select appointment');
    }
  }
}