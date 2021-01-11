import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/app_table.dart';
import 'package:enstaller/core/model/appointment_model.dart';
import 'package:enstaller/core/model/user_model.dart';
import 'package:enstaller/core/provider/base_model.dart';
import 'package:enstaller/core/service/api_service.dart';
import 'package:enstaller/core/service/pref_service.dart';

class HomeScreenViewModel extends BaseModel{
  ApiService _apiService=ApiService();
  List<Appointment>appointMentList=[];

  bool dateSelected=false;
  List<AppTable>tables=[];
  int selectedIndex;
  void onSelectIndex(int value){
    setState(ViewState.Busy); 
    if(selectedIndex!=value){
      selectedIndex=value;
    }else{
      selectedIndex=null;
    }

    setState(ViewState.Idle);
  }
  void onToggleDateSelected(){
    setState(ViewState.Busy);
    dateSelected=!dateSelected;
    setState(ViewState.Idle);
  }

  Future getAppointmentList(UserModel user)async{
    setState(ViewState.Busy);
    appointMentList =await _apiService.getAppointmentList('4');
    setState(ViewState.Idle);

  }

  void getTable(String date)async{
    setState(ViewState.Busy);
    print('date===$date');
    UserModel user=await Prefs.getUser();
    print('eid==${user.intEngineerId}   ${date}');
    tables=await _apiService.getEngineerAppointments(user.intEngineerId.toString(), date);
    print('tablelength===${tables.length}');
    setState(ViewState.Idle);
  }


}