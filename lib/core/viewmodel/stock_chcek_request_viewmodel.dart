import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/serial_model.dart';
import 'package:enstaller/core/model/stock_check_model.dart';
import 'package:enstaller/core/model/user_model.dart';
import 'package:enstaller/core/provider/base_model.dart';
import 'package:enstaller/core/service/api_service.dart';
import 'package:enstaller/core/service/pref_service.dart';

class StockCheckRequestViewModel extends BaseModel{

  List<StockCheckModel> stockCheckList = [];
  ApiService _apiService = ApiService();


  void initializeData() async {
    setState(ViewState.Busy);
    //Fetch from apis
    UserModel user = await Prefs.getUser();

    stockCheckList = await _apiService.getStockCheckRequestList(user.id.toString());

    setState(ViewState.Idle);
  }

  Future<List> getSerialNos(String requestId) async{
    //Fetch from apis
    List<SerialNoModel> serialNoList =[];
    serialNoList = await _apiService.getSerialsByRequestId(requestId);
    return serialNoList;


  }

}