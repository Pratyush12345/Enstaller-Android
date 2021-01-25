import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/contract_order_model.dart';
import 'package:enstaller/core/model/item_oder_model.dart';
import 'package:enstaller/core/model/order_line_detail_model.dart';
import 'package:enstaller/core/model/response_model.dart';
import 'package:enstaller/core/model/save_order.dart';
import 'package:enstaller/core/model/save_order_line.dart';
import 'package:enstaller/core/model/user_model.dart';
import 'package:enstaller/core/provider/base_model.dart';
import 'package:enstaller/core/service/api_service.dart'; 
import 'package:enstaller/core/service/pref_service.dart';
import 'package:enstaller/ui/screen/widget/order/order_item.dart';
import 'package:enstaller/ui/util/common_utils.dart';
import 'package:flutter/cupertino.dart';

class AddOrderScreenViewModel extends BaseModel {
  List<Map<String, dynamic>> itemList = [];
  List<Map<String, dynamic>> contractList = [];
  bool isSaving = false;
  int intOrderId;

  ApiService _apiService = ApiService();
  List<OrderItem> orderItems = [];
  List<ItemOrder> orders = [];
  List<OrderLineDetailModel> orderLineDetailModelList = [];
  List<SaveOrderLine> saveOrderOnlineList = [];

  void initializeData(int intId) async {
    setState(ViewState.Busy);
    //Fetch from api
    UserModel user = await Prefs.getUser();
    List<ItemOrder> iList =
        await _apiService.getItemsForOrder(user.id.toString());
    itemList.clear();
    itemList = iList
        .map((ItemOrder itemOrder) => {
              'label': itemOrder.strName,
              'value': itemOrder.intId.toString(),
              'intContractId': itemOrder.intContractId.toString()
            })
        .toList();
    List<ContractOrder> cList =
        await _apiService.getContractsForOrder(user.id.toString());
    contractList.clear();
    contractList = cList
        .map((ContractOrder contractOrder) => {
              'label': contractOrder.strName,
              'value': contractOrder.intId.toString()
            })
        .toList();
    if (intId != null) {
      intOrderId = intId;
      //fetch orders
      orderLineDetailModelList = await _apiService
          .getStockOrderLineItemsByOrderId(this.intOrderId.toString());
      orderLineDetailModelList.forEach((element) {
        SaveOrderLine saveOrderLine = SaveOrderLine(
            intId: element.intId,
            intOrderId: element.intOrderId,
            intCreatedBy: element.intCreatedBy,
            bisAlive: element.bisAlive,
            decQty: element.decQty.toInt(),
            intContractId: element.intContractId,
            intItemId: element.intItemId);

        orderItems.add(OrderItem(
            key: GlobalKey(),
            itemList: itemList,
            contractList: contractList,
            saveOrderLine: saveOrderLine,
            onDelete: () => onDelete(saveOrderLine)));
      });
    } else {
      addOrderItem();
    }

    setState(ViewState.Idle);
  }

  void addOrderItem() {
    setState(ViewState.Busy);
    SaveOrderLine saveOrderLine = SaveOrderLine();

    orderItems.add(OrderItem(
        key: GlobalKey(),
        itemList: itemList,
        contractList: contractList,
        saveOrderLine: saveOrderLine,
        onDelete: () => onDelete(saveOrderLine)));
    setState(ViewState.Idle);
  }

  void onDelete(SaveOrderLine saveOrderLine) {
    setState(ViewState.Busy);
    var find = orderItems.firstWhere(
      (it) => it.saveOrderLine == saveOrderLine,
      orElse: () => null,
    );
    if (find != null) orderItems.removeAt(orderItems.indexOf(find));

    setState(ViewState.Idle);
  }

  Future<void> onSave(BuildContext context) async {
    setState(ViewState.Busy);
    isSaving = true;

    //check length of items
    if (orderItems.length < 1) {
      AppConstants.showFailToast(context, "Add items first.");
      setState(ViewState.Idle);
      return;
    }

    //validate and save forms
    var isValid = true;
    orderItems.forEach((element) {
      isValid = element.isValid() && isValid;
    });

    if (isValid) {
      OrderItem element = orderItems[0];
      UserModel user = await Prefs.getUser();
      final SaveOrder saveOrder = SaveOrder(
          intUserId: int.parse(user.id),
          bisBulkUpload: false,
          intCreatedBy: int.parse(user.id),
          dteCollectionDate:
              CommonUtils.commonUtilsInstance.formatDate2(DateTime.now()),
          bisAlive: true,
          intRegionId: 1,
          strThirdParty: "a",
          intContractId: element.saveOrderLine.intContractId,
          intWarehouseId: 1,
          isMerged: false,
          strMarshallingLane: "a",
          intModifiedBy: int.parse(user.id));

      //post saveOrder

      try {
        if(intOrderId == null) {
          ResponseModel responseModel = await _apiService.saveOrder(saveOrder);
          if (responseModel.statusCode == 1) {
            intOrderId = int.parse(responseModel.response);
            print('order id: ${responseModel.response}');
          }else {
            AppConstants.showFailToast(context, AppStrings.UNABLE_TO_SAVE);
            setState(ViewState.Idle);
            return;
          }
        }

        for (OrderItem orderItem in orderItems) {
          final SaveOrderLine saveOrderLine = SaveOrderLine(
              intId: orderItem.saveOrderLine.intId,
              intCreatedBy: int.parse(user.id),
              intOrderId: intOrderId,
              intItemId: orderItem.saveOrderLine.intItemId,
              intContractId: orderItem.saveOrderLine.intContractId,
              decQty: orderItem.saveOrderLine.decQty,
              bisAlive: true);
          orderLineDetailModelList.removeWhere((element) => element.intId == saveOrderLine.intId);
          saveOrderOnlineList.add(saveOrderLine);
        }

        orderLineDetailModelList.forEach((element) {
          SaveOrderLine saveOrderLine = SaveOrderLine(
              intId: element.intId,
              intOrderId: element.intOrderId,
              intCreatedBy: element.intCreatedBy,
              bisAlive: false,
              decQty: element.decQty.toInt(),
              intContractId: element.intContractId,
              intItemId: element.intItemId);
          saveOrderOnlineList.add(saveOrderLine);
        });

          for (SaveOrderLine saveOrderLine in saveOrderOnlineList) {

            //post saveOrderOnline
            try {
              ResponseModel responseModelLine =
                  await _apiService.saveOrderLine(saveOrderLine);
              if (responseModelLine.statusCode == 1 &&
                  responseModelLine.response.toLowerCase() == 'true') {
                //saved successfully
              } else {
                AppConstants.showFailToast(context, AppStrings.UNABLE_TO_SAVE);
                setState(ViewState.Idle);
                return;
              }
            } catch (e) {
              print(e);
              AppConstants.showFailToast(context, AppStrings.UNABLE_TO_SAVE);
              setState(ViewState.Idle);
              return;
            }
          }

      } catch (e) {
        AppConstants.showFailToast(context, AppStrings.UNABLE_TO_SAVE);
        setState(ViewState.Idle);
        return;
      }
    } else {
      isSaving = false;
      setState(ViewState.Idle);
      return;
    }

    AppConstants.showSuccessToast(context, AppStrings.SAVED_SUCCESSFULLY);
    isSaving = false;
    Navigator.of(context).pop();
    setState(ViewState.Idle);
  }
}
