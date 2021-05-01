import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/send/answer_credential.dart';
import 'package:enstaller/core/model/stock_update_model.dart';
import 'package:enstaller/core/provider/base_model.dart';
import 'package:enstaller/core/service/api_service.dart';


class StockUpdateStatusViewModel extends BaseModel {
  
  List<StockLocationModel> stockLocationList;
  List<StockStatusModel> stockStatusList;
  List<StockBatchModel> stockBatchList;
  List<StockPalletModel> stockPalletList;
  DownLoadFormatModel downLoadFormatModel;
  String lValue;
  String sValue;
  String bValue;
  
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
    stockPalletList = [];
    stockPalletList = await _apiService.getPallet(batchId.toString());
    print("pallet length ----${stockPalletList.length}");
    
   }

   onDownloadPressed() async{
     downLoadFormatModel = await _apiService.getDownloadFormat("GetStockDemoFilesPath");
     print(downLoadFormatModel.strKey);
   }

}