import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/email_notification_model.dart';
import 'package:enstaller/core/model/user_model.dart';
import 'package:enstaller/core/provider/base_model.dart';
import 'package:enstaller/core/service/api_service.dart';
import 'package:enstaller/core/service/pref_service.dart';
class EmailNotificationViewModel extends BaseModel{
  ApiService _apiService=ApiService();
  List<EmailNotificationModel>emailNotificationList=[];
  List<EmailNotificationModel>_emailNotificationList=[];

  bool searchBool=false;

  void getEmailNotificationList()async{
    emailNotificationList = [];
    _emailNotificationList = [];
    setState(ViewState.Busy);
    UserModel user=await Prefs.getUser();
    _emailNotificationList =await _apiService.getEmailNotificationList(user.id.toString());
    emailNotificationList = _emailNotificationList;  
  
    setState(ViewState.Idle);
  }
  void onClickSerach(){
    setState(ViewState.Busy);
    searchBool=!searchBool;
    if(!searchBool){
      emailNotificationList=_emailNotificationList;
    }
    setState(ViewState.Idle);
  }
  void onSearch(String val){
    setState(ViewState.Busy);
    emailNotificationList=[];
    _emailNotificationList.forEach((element) {
      if(element.intAppointmentId.toString().toLowerCase().contains(val.toLowerCase())||element.customerName.toLowerCase().contains(val.toLowerCase())||
      element.dteCreatedDate.toLowerCase().contains(val.toLowerCase())||element.strEmail.toLowerCase().contains(val.toLowerCase())){
        emailNotificationList.add(element);
      }
    });
    setState(ViewState.Idle);
  }
  int getCurrentDay(DateTime date){
    return date.day;
  }
  int getNextDay(DateTime date){
    final tomorrow = DateTime(date.year, date.month, date.day + 1);
    return tomorrow.day;
  }
}