import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/app_table.dart';
import 'package:enstaller/core/model/appointmentDetailsModel.dart';
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

  Future getAppointmentList()async{
    UserModel userModel = await Prefs.getUser();
    
    setState(ViewState.Busy);
    print("int engineer id-------------${userModel.intEngineerId}");
    appointMentList = await _apiService.getAppointmentList(userModel.intEngineerId.toString());
    setState(ViewState.Idle);

  }

  void getTable(int day, List<Appointment>appointMentListpassed ){
    setState(ViewState.Busy);
    print('date===$day');
    appointMentListpassed.forEach((element) { 
      DateTime _date = DateTime.parse(element.dteBookedDate);
      if(_date.day == day){
       tables.add(AppTable.fromJson(element.toJson()));
      }
    });
    print('tablelength===${tables.length}');
    setState(ViewState.Idle);
  }


}