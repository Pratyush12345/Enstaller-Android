import 'dart:io';
 
import 'package:csv/csv.dart';

import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/order_detail_model.dart';
import 'package:enstaller/core/model/order_export_model.dart';
import 'package:enstaller/core/model/order_line_detail_model.dart';
import 'package:enstaller/core/model/user_model.dart';
import 'package:enstaller/core/provider/base_model.dart';
import 'package:enstaller/core/service/api_service.dart';
import 'package:enstaller/core/service/pref_service.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

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

  void downloadCSV(intId, context) async{
    setState(ViewState.Busy);
    //Fetch from api
    if(intId != null){
      List<OrderExportModel> exportList = await _apiService.getOrderExportCSVDetails(intId.toString());
      //Download
      List<List<String>> csvdata = [
        <String>["Reference", "Status", "Contract", "User", "Collection Date", "SKU","Item", "Qty", "Created","Modified"],
        ...exportList.map((e) => [e.strRefrence, e.strStatus, e.strContractName, e.strUserName, e.dteCollectionDate, e.strSKU, e.strItemName, e.decQty.toString(), e.dteCreatedDate, e.dteModifiedDate])
      ];
      String csv = const ListToCsvConverter().convert(csvdata);

      var storagePermission = await Permission.storage.status;

      if(!storagePermission.isGranted){
          await Permission.storage.request();
      }
      storagePermission = await Permission.storage.status;
      if(storagePermission.isGranted){
        final String dir = await ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DOWNLOADS);
        final String path = '$dir/$intId.csv';
        final File file = File(path);
        await file.writeAsString(csv);
        AppConstants.showSuccessToast(context, AppStrings.SAVED_SUCCESSFULLY);
      }else{
        AppConstants.showFailToast(context, AppStrings.UNABLE_TO_SAVE);
      }

    }


    setState(ViewState.Idle);

  }




}
