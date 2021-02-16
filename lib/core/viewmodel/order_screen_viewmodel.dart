import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/order_model.dart';
import 'package:enstaller/core/model/user_model.dart';
import 'package:enstaller/core/provider/base_model.dart';
import 'package:enstaller/core/service/api_service.dart';
import 'package:enstaller/core/service/pref_service.dart';


class OrderScreenViewModel extends BaseModel {

  List<OrderModel> list = [];

  ApiService _apiService = ApiService();

  void initializeData() async {
    list = [];
    setState(ViewState.Busy);
    //Fetch from api
    UserModel user = await Prefs.getUser();
    list = await _apiService.getOrderListByEngId(user.id.toString());
    setState(ViewState.Idle);
  }




}
