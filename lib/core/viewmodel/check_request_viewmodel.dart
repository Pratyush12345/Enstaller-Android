import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/serial_item_model.dart';
import 'package:enstaller/core/model/user_model.dart';
import 'package:enstaller/core/provider/base_model.dart';
import 'package:enstaller/core/service/api_service.dart';
import 'package:enstaller/core/service/pref_service.dart';

class CheckRequestViewModel extends BaseModel{
  List<SerialItemModel> serialList = [];

  ApiService _apiService = ApiService();


  void initializeData() async {
    setState(ViewState.Busy);
    //Fetch from apis
    UserModel user = await Prefs.getUser();

    serialList = await _apiService.getSerialListByEmployeeId(user.id.toString());

    setState(ViewState.Idle);
  }
}