import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/order_detail_model.dart';
import 'package:enstaller/core/model/order_line_detail_model.dart';
import 'package:enstaller/core/model/user_model.dart';
import 'package:enstaller/core/provider/base_model.dart';
import 'package:enstaller/core/service/api_service.dart';
import 'package:enstaller/core/service/pref_service.dart';

class OrderDetailViewModel extends BaseModel {

  List<OrderLineDetailModel> list = [];
  OrderDetailModel orderDetailModel;
  int intOrderId = -1;

  ApiService _apiService = ApiService();

  void initializeData(intId) async {
    setState(ViewState.Busy);
    //Fetch from api
    UserModel user = await Prefs.getUser();
    this.intOrderId = intId;
    orderDetailModel = await _apiService.getStockOrderById(this.intOrderId.toString()) as OrderDetailModel;
    list = await _apiService.getStockOrderLineDetails(this.intOrderId.toString());
    setState(ViewState.Idle);
  }




}
