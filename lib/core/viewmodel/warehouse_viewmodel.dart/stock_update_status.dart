import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/response_model.dart';
import 'package:enstaller/core/model/send/answer_credential.dart';
import 'package:enstaller/core/model/stock_update_model.dart';
import 'package:enstaller/core/provider/base_model.dart';
import 'package:enstaller/core/service/api_service.dart';
import 'package:enstaller/ui/util/MessagingService/FirebaseMessaging.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;


class StockUpdateStatusViewModel extends BaseModel {
  
  List<StockLocationModel> stockLocationList = [];
  List<StockStatusModel> stockStatusList =[];
  List<StockBatchModel> stockBatchList = [];
  List<StockPalletModel> stockPalletList =[] ;
  DownLoadFormatModel downLoadFormatModel = DownLoadFormatModel();
  String lValue;
  int lid;
  String sValue;
  int sid;
  String bValue;
  String comment;
  String strType;
  int count = 1;
  
  ApiService _apiService = ApiService();
  
  initializeData() async{
    setState(ViewState.Busy);
    stockLocationList = [];
    stockStatusList = [];
    stockBatchList = []; 
    stockPalletList = [];
    print("warehouse id  ${GlobalVar.warehosueID}");
    stockLocationList = await _apiService.getStockLocation(GlobalVar.warehosueID); 
    stockStatusList = await _apiService.getStockStatus();
    stockBatchList = await _apiService.getStockBatch(GlobalVar.warehosueID);  
    setState(ViewState.Idle);
  }
   
   getPallets(int batchId) async{
     setState(ViewState.Busy);
    
    stockPalletList = [];
    stockPalletList = await _apiService.getPallet(batchId.toString());
    print("pallet length ----${stockPalletList.length}");
    setState(ViewState.Idle);
   }

   onDownloadPressed(BuildContext context) async{
     setState(ViewState.Busy);
     downLoadFormatModel = await _apiService.getDownloadFormat("GetStockDemoFilesPath");

     print(downLoadFormatModel.strKey);
     String url = downLoadFormatModel.strValue + "Upload/Demo/demo_stocks.csv";
    //  if(await canLaunch(url)){
    //    launch(url);
    //  }
    //  else{
    //    throw Exception("unable to open");
    //  }
      var request = await HttpClient().getUrl(Uri.parse(url));
        var response = await request.close();
        var bytes = await consolidateHttpClientResponseBytes(response);
          var storagePermission = await Permission.storage.status;

      if(!storagePermission.isGranted){
          await Permission.storage.request();
      }

      storagePermission = await Permission.storage.status;
      if(storagePermission.isGranted){
    
        
        final String dir = await ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DOWNLOADS);
        final String path = '$dir/${count}demoStock.csv';
        count++;
        final File file = File(path);
        await file.writeAsBytesSync(bytes);
        // final String dir = await ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DOCUMENTS);
        // path = '$dir/demoStock.csv';
        // final File file = File(path);
        // await file.writeAsBytesSync(bytes);
        
        
        AppConstants.showSuccessToast(context, AppStrings.SAVED_SUCCESSFULLY);
        FirebaseMessagingService.showNotification("File Downloaded", path);
      }else{
        AppConstants.showFailToast(context, AppStrings.UNABLE_TO_SAVE);
      }
     setState(ViewState.Idle);
    
   }

   save(BuildContext context, StockStatusSaveModel stockStatusSaveModel) async{
     setState(ViewState.Busy);
     try{
        ResponseModel responseModel = await _apiService.saveStatusUpdate(
         stockStatusSaveModel
       );
       if(responseModel.statusCode ==1)
       AppConstants.showSuccessToast(context, responseModel.response);
       else
       AppConstants.showFailToast(context, responseModel.response);
       
     }catch(e){
       AppConstants.showFailToast(context, e.toString());
       print(e);
     }
     setState(ViewState.Idle);
   }

}