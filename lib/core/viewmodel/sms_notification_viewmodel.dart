import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/sms_notification_model.dart';
import 'package:enstaller/core/model/user_model.dart';
import 'package:enstaller/core/provider/base_model.dart';
import 'package:enstaller/core/service/api_service.dart';
import 'package:enstaller/core/service/pref_service.dart';

class SMSNotificationViewModel extends BaseModel{
  ApiService _apiService=ApiService();
  List<SMSNotificationModel>smsNotificationList=[];
  List<SMSNotificationModel>_smsNotificationList=[];

  bool searchBool=false;

  void getSMSNotificationList()async{
    setState(ViewState.Busy);
    UserModel user=await Prefs.getUser();
    
    _smsNotificationList =await _apiService.getSMSNotificationList(user.id.toString());
    smsNotificationList = _smsNotificationList;  
    setState(ViewState.Idle);
  }
  void onClickSerach(){
    setState(ViewState.Busy);
    searchBool=!searchBool;
    if(!searchBool){
      smsNotificationList=_smsNotificationList;
    }
    setState(ViewState.Idle);
  }
  void onSearch(String val){
    setState(ViewState.Busy);
    smsNotificationList=[];
    // _appointmentList.forEach((element) {
    //   DateTime dt = DateTime.parse(element.dteBookedDate);
    //   if(element.strCompanyName.toLowerCase().contains(val.toLowerCase())||element.appointmentEventType.toLowerCase().contains(val.toLowerCase())||
    //   element.engineerName.toLowerCase().contains(val.toLowerCase())||element.strBookingReference.toLowerCase().contains(val.toLowerCase())){
    //     appointmentList.add(element);
    //   }
    // });
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