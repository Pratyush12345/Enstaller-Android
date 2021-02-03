
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/appointmentDetailsModel.dart';
import 'package:enstaller/core/model/user_model.dart';
import 'package:enstaller/core/provider/base_model.dart';
import 'package:enstaller/core/service/api_service.dart';
import 'package:enstaller/core/service/pref_service.dart';
import 'package:intl/intl.dart';

class TodayAppointmentViewModel extends BaseModel{
  ApiService _apiService=ApiService();
  List<Appointment>appointmentList=[];
  List<Appointment>_appointmentList=[];
  bool searchBool=false;

  void getAppoinmentList()async{
    setState(ViewState.Busy);
    UserModel user=await Prefs.getUser(); 
    _appointmentList =await _apiService.getAppointmentList(user.intEngineerId.toString());
    _appointmentList.forEach((element) {
      DateTime dt = DateTime.parse(element.dteBookedDate);
        
        if(dt.day == getCurrentDay(DateTime.now()) ){
        appointmentList.add(element);
        }
      
    });
    setState(ViewState.Idle);
  }
  void onClickSerach(){
    setState(ViewState.Busy);
    searchBool=!searchBool;
    if(!searchBool){
      appointmentList=_appointmentList;
    }
    setState(ViewState.Idle);
  }
  
  void onSearch(String val){
    setState(ViewState.Busy);
    appointmentList=[];
    _appointmentList.forEach((element) {
      DateTime dt = DateTime.parse(element.dteBookedDate);
      if(element.strCompanyName.toLowerCase().contains(val.toLowerCase())||element.appointmentEventType.toLowerCase().contains(val.toLowerCase())||
      element.engineerName.toLowerCase().contains(val.toLowerCase())||element.strBookingReference.toLowerCase().contains(val.toLowerCase())){
        appointmentList.add(element);
      }
    });
    setState(ViewState.Idle);
  }
  int getCurrentDay(DateTime date){
    return date.day;
  }
}