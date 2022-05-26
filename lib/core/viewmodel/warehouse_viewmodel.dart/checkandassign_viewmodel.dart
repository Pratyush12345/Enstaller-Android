import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/model/checkAndAssignModel.dart';
import 'package:enstaller/core/model/response_model.dart';
import 'package:enstaller/core/model/send/answer_credential.dart';
import 'package:enstaller/core/provider/base_model.dart';
import 'package:enstaller/core/service/api_service.dart';
import 'package:flutter/cupertino.dart';

class CheckAndAssignOrderVM extends BaseModel {

  static CheckAndAssignOrderVM instance = CheckAndAssignOrderVM._();
  CheckAndAssignOrderVM._();
  
  ApiService _apiService = ApiService();
  List<IsOrderAssignedModel> orderAssignedList;
  OrderByRefernceModel orderByRefernceModel;
  List<OrderLineDetail> orderLineDetailList;
  List<CheckSerialModel> checkSerialModelList;
  List<CheckSerialModel> showListView = [];
  List<CheckSerialModel> _dupshowListView = [];
  List<StockList> stockList = [];
 
  Future<bool> checkValidity(BuildContext context, String reference) async{
    orderLineDetailList = [];
    orderAssignedList = [];
    try{
    orderAssignedList =  await _apiService.getOrderAssigned(reference);
     if(orderAssignedList.isEmpty)
     { 
      await  getOrderDetails(reference);
      return false;
     
     }
     else{
     return true;
     }
    }
    catch(e){
      print(e);
      return false;
    }
  
  }
  getOrderDetails(String reference)  async{
    orderLineDetailList = [];
    try{
    orderByRefernceModel = await _apiService.getOrderByReference(reference);
    orderLineDetailList =await _apiService.getOrderLineDetail(orderByRefernceModel.intId.toString());
    }
    catch(e){
      print(e); 
    }
  }

  search({
    String text
  }) {
    text = text.toLowerCase();
    if(text.isNotEmpty){
      if(text.length==1 && _dupshowListView.isEmpty){
         _dupshowListView = List.from(showListView);
         showListView = []; 
      }
     showListView = _dupshowListView.where((element) => element.strSerialNo.toLowerCase().contains(text) ||
     element.strItemName.toLowerCase().contains(text) || element.strContainerName.toLowerCase().contains(text) ).toList(); 
    }
    else{
      showListView = List.from(_dupshowListView);
      } 
   }


  Future<bool> checkSerialValidty(BuildContext context, String serialNo, String orderID) async{
    checkSerialModelList = [];
    try{
    checkSerialModelList =  await _apiService.checkSerialNo(serialNo, orderID);
     if(checkSerialModelList.isEmpty)
     { 
      return true;
     
     }
     else{

      int index = showListView.indexWhere((element) => element.strSerialNo== checkSerialModelList[0].strSerialNo);
      if(index==-1)
      showListView.add(checkSerialModelList[0]); 
      return false;
     }
    }
    catch(e){
      print(e);
      return true;
    }
  
  }

  save( BuildContext context, int orderid) async {
    bool flag = true;
    for(int i = 0; i< orderLineDetailList.length; i++){ 
      OrderLineDetail element = orderLineDetailList[i];
      int decQty = element.decQty.toInt();
      int count  = 0;
         showListView.forEach((e) {
           if(e.intItemId == element.intItemId){
             count = count + e.decQty.toInt();
           }
      });  
      if(decQty != count){
        flag = false;
        break;
      }
    }
    if(flag){
      showListView.forEach((element) { 
        stockList.add(StockList(
          decQty: element.decQty.toInt(),
          intContainerId: element.intContainerId,
          intItemId: element.intItemId,
          intOrderLineItemId: element.intOrderLineItemId,
          intStockId: element.intStockId,
          intOrderId: orderid
        ));
      });
    try{
        ResponseModel responseModel = await _apiService.saveCheckOrder(SaveCheckOrderModel(
          intCreatedBy: int.parse(GlobalVar.warehosueID),
          stockList: stockList
        ));
        if(responseModel.statusCode == 1){
          AppConstants.showSuccessToast(context, responseModel.response);
        }else{
          AppConstants.showFailToast(context, responseModel.response);
        }
    }catch(e){
         AppConstants.showFailToast(context, e);
    }
  }
  else{
    
         AppConstants.showFailToast(context, "assigned order and selected order mismatch");
  }
  }
}