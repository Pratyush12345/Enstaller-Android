import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/serial_item_model.dart';
import 'package:enstaller/core/model/user_model.dart';
import 'package:enstaller/core/provider/base_model.dart';
import 'package:enstaller/core/service/api_service.dart';
import 'package:enstaller/core/service/pref_service.dart';
import 'package:enstaller/ui/screen/widget/appointment/appointment_data_row.dart';

class CheckRequestViewModel extends BaseModel{
  List<SerialItemModel> serialList = [];
  List<AppointmentDataRow> list = [];

  ApiService _apiService = ApiService();


  void initializeData() async {
    setState(ViewState.Busy);
    //Fetch from apis
    UserModel user = await Prefs.getUser();

    serialList = await _apiService.getSerialListByEmployeeId(user.id.toString());

    if(serialList.isNotEmpty){
      list.add(AppointmentDataRow(
        firstText: AppStrings.SERIAL_NUMBER,
        secondText: AppStrings.ITEM_NAME,
      ),);
      list.addAll(serialList.map((e) => AppointmentDataRow(
        firstText: e?.strSerialNo ?? "",
        secondText: e?.strItemName ?? "",
      ),).toList());
    }

    setState(ViewState.Idle);
  }
}