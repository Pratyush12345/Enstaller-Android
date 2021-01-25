import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/comment_model.dart';
import 'package:enstaller/core/model/response_model.dart';
import 'package:enstaller/core/model/send/comment_credential.dart';
import 'package:enstaller/core/model/user_model.dart';
import 'package:enstaller/core/provider/base_model.dart';
import 'package:enstaller/core/service/api_service.dart';
import 'package:enstaller/core/service/pref_service.dart';
import 'package:flutter/cupertino.dart';
 
class CommentDialogViewModel extends BaseModel{ 
  ApiService _apiService=ApiService();
  List<CommentModel>comments=[];
  TextEditingController commentController=TextEditingController();
  
  
  void getComments(String appointmentID)async{
    setState(ViewState.Busy);
    comments=await _apiService.getAppointmentCommentsByAppointment(appointmentID);
    setState(ViewState.Idle);
  }
  void onSubmitComment(String appointmentID)async{
    setState(ViewState.Busy);
    UserModel userModel=await  Prefs.getUser();
    print('usedId${userModel.id}');
    ResponseModel responseModel=await _apiService.submitComment(CommentCredential(
      strcomments: commentController.text,
      intappintmentid: appointmentID,
      intCreatedBy: userModel.id.toString()
    ));
    if(responseModel.statusCode==1){
      commentController.clear();
      comments=await _apiService.getAppointmentCommentsByAppointment(appointmentID);
    }
    setState(ViewState.Idle);
  }

}