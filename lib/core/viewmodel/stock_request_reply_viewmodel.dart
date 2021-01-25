import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/response_model.dart';
import 'package:enstaller/core/model/serial_model.dart';
import 'package:enstaller/core/model/stock_request_reply_model.dart';
import 'package:enstaller/core/provider/base_model.dart';
import 'package:enstaller/core/service/api_service.dart';
import 'package:enstaller/ui/screen/widget/validate_list_dialog_widget.dart';
import 'package:flutter/cupertino.dart';

class StockRequestReplyViewModel extends BaseModel {
  int intRequestId;
  String comment;
  String serialNos;
  ApiService _apiService = ApiService();

  void initializeData(int intRequestId) {
    setState(ViewState.Busy);
    this.intRequestId = intRequestId;
    setState(ViewState.Idle);
  }

  void sendReply(form, context) async{
    setState(ViewState.Busy);
    var valid = form.currentState.validate();
    if(!valid){
      setState(ViewState.Idle);
      return;
    }
    if (valid) {
      form.currentState.save();
      List<SerialNoModel> list = [];

      serialNos.split(',').forEach((e) {

        list.add(SerialNoModel(strSerialNo: e));
      });



      //validate
      try{
        List<SerialNoModel> validatedList = [];
        validatedList = await _apiService.validateSerialsForReply(list);

        if(validatedList.isNotEmpty){
          setState(ViewState.Idle);
          AppConstants.showAppDialog(
              context: context,
              child: ValidatedListWidget(
                list:validatedList,
              ));

          return;
        }else{

          //save reply
          StockRequestReplyModel stockRequestReplyModel = StockRequestReplyModel(
              listSerials: list, intRequestId: intRequestId, strComments: comment);

          try{
            ResponseModel responseModel = await _apiService.saveEngineerReply(stockRequestReplyModel);
            if (responseModel.statusCode == 1 &&
                responseModel.response.toLowerCase() == 'true') {
              //saved successfully
            } else {
              AppConstants.showFailToast(context, responseModel.response);
              setState(ViewState.Idle);
              return;
            }
          }catch(e){
            print(e);
            AppConstants.showFailToast(context, AppStrings.UNABLE_TO_SAVE);
            setState(ViewState.Idle);
            return;
          }


        }





        }catch(e){
        print(e);
        AppConstants.showFailToast(context, AppStrings.UNABLE_TO_SAVE);
        setState(ViewState.Idle);
        return;
      }
      //upload
    }
    Navigator.of(context).pop();
    AppConstants.showSuccessToast(context, AppStrings.SAVED_SUCCESSFULLY);
    setState(ViewState.Idle);
  }
}
