
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

  void getAppoinmentList()async{
    setState(ViewState.Busy);
    UserModel user=await Prefs.getUser();
    String currentDate  =DateFormat("yyyy-MM-dd").format(DateTime.now());
    _appointmentList=await _apiService.getTodaysAppointments(user.intEngineerId.toString(), currentDate);
    appointmentList=_appointmentList;

    setState(ViewState.Idle);
  }
  void onSearch(val){
    setState(ViewState.Busy);
    _appointmentList.forEach((element) {
      if(element.engineerName.toLowerCase().contains(val.toLowerCase())||element.strCompanyName.toLowerCase().contains(val.toLowerCase())||
          element.strBookingReference.toLowerCase().contains(val.toLowerCase())){
        appointmentList.add(element);
      }
    });
    setState(ViewState.Idle);
  }
}