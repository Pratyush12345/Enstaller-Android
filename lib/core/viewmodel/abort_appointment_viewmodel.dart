import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/comment_model.dart';
import 'package:enstaller/core/model/response_model.dart';
import 'package:enstaller/core/model/send/appointmentStatusUpdateCredential.dart';
import 'package:enstaller/core/model/send/comment_credential.dart';
import 'package:enstaller/core/model/user_model.dart';
import 'package:enstaller/core/provider/base_model.dart';
import 'package:enstaller/core/service/api_service.dart';
import 'package:enstaller/core/service/pref_service.dart';
import 'package:flutter/cupertino.dart';

class AbortAppointmentViewModel extends BaseModel{
  ApiService _apiService=ApiService();
  List<CommentModel>comments=[];
  UserModel user;
  TextEditingController commentController=TextEditingController();

  
  void getAbortAppointmentCode(String appointmentID)async{
    setState(ViewState.Busy);
    // comments=await _apiService.getAbortAppointmentCode(AppointmentStatusUpdateCredentials(
    //       strStatus: selectedStatus!=AppStrings.enRoute?selectedStatus:AppStrings.onRoute,intBookedBy: user.intEngineerId.toString(),
    //       intEngineerId: user.intEngineerId.toString(),
    //       intId: appointmentDetails.appointment.intId.toString()
    //   ));
    setState(ViewState.Idle);
  }
  
  
}