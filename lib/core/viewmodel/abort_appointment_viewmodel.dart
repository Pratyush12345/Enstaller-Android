import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/abort_appointment_model.dart';
import 'package:enstaller/core/model/comment_model.dart';
import 'package:enstaller/core/model/response_model.dart';
import 'package:enstaller/core/model/send/appointmentStatusUpdateCredential.dart';
import 'package:enstaller/core/model/send/comment_credential.dart';
import 'package:enstaller/core/model/user_model.dart';
import 'package:enstaller/core/provider/base_model.dart';
import 'package:enstaller/core/service/api_service.dart';
import 'package:enstaller/core/service/pref_service.dart';
import 'package:enstaller/ui/screen/widget/abort_appointment_widget.dart';
import 'package:flutter/cupertino.dart';
 
class AbortAppointmentViewModel extends BaseModel{
  ApiService _apiService=ApiService();
  List<AbortAppointmentModel>abortlist=[];
  List<String> listofReason = [];
  UserModel user;
  
  
  void getAbortAppointmentList()async{
    setState(ViewState.Busy);
    UserModel user =await Prefs.getUser();
    abortlist=await _apiService.getAbortAppointmentList('0');
    abortlist.forEach((element) {
      
      listofReason.add(element.strName);
    });
    setState(ViewState.Idle);
  }

  void onConfirmPressed(BuildContext context , ConfirmAbortAppointment confirmAbortAppointment) async {
      setState(ViewState.Busy);
      ResponseModel response = await _apiService.confirmAbortAppointment(confirmAbortAppointment);
      setState(ViewState.Idle);
      if (response.statusCode == 1) {
        AppConstants.showFailToast(context, "Abort Appointment Successfull");
      } else {
        AppConstants.showSuccessToast(context, "Abort Appointment failed");
      }
       Navigator.of(context).pop();

    setState(ViewState.Idle);
  }
  
  
}