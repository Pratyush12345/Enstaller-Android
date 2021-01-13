import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/appointmentDetailsModel.dart';
import 'package:enstaller/core/model/document_model.dart';
import 'package:enstaller/core/model/response_model.dart';
import 'package:enstaller/core/model/user_model.dart';
import 'package:enstaller/core/provider/base_model.dart';
import 'package:enstaller/core/service/api_service.dart';
import 'package:enstaller/core/service/pref_service.dart';
import 'package:enstaller/core/model/document_pdfopen_model.dart';
import 'package:flutter/cupertino.dart';


class DocumnetViewModel extends BaseModel{
  ApiService _apiService=ApiService();
  List<DocumentResponseModel>documentList=[];
  List<DocumentResponseModel>_documentList=[];

  bool searchBool=false;

  void getDocumnetList()async{
    setState(ViewState.Busy);
    UserModel user=await Prefs.getUser();
     DocumentModel documentModel = DocumentModel(intCreatedBy: user.intEngineerId.toString() , intSupplierId: "0", strDocUser: "Engineer", strKey: "GetDocumentWeb");
    _documentList =await _apiService.getDocumentList(documentModel);
    documentList = _documentList;
    setState(ViewState.Idle);
  }
  void onPDFOpen(BuildContext context, String _intId)async{

      setState(ViewState.Busy);
       ResponseModel response=await _apiService.onclickpdf(PDFOpenModel(
         intID: _intId,
         bisEngineerRead: "true",
         isModeifiedBy: "20020"


       ));
         setState(ViewState.Idle);
         if(response.statusCode==1){
           AppConstants.showSuccessToast(context, response.response);
           setState(ViewState.Idle);
         }else{
           setState(ViewState.Idle);
           AppConstants.showFailToast(context, response.response);
         }
       

     
  }
  void onClickSerach(){
    setState(ViewState.Busy);
    searchBool=!searchBool;
    if(!searchBool){
      documentList=_documentList;
    }
    setState(ViewState.Idle);
  }
  void onSearch(String val){
    setState(ViewState.Busy);
    documentList=[];
    // _documentList.forEach((element) {
    //   DateTime dt = DateTime.parse(element.dteBookedDate);
    //   if(element.strCompanyName.toLowerCase().contains(val.toLowerCase())||element.appointmentEventType.toLowerCase().contains(val.toLowerCase())||
    //   element.engineerNam.toLowerCase().contains(val.toLowerCase())||element.strBookingReference.toLowerCase().contains(val.toLowerCase())){
    //     documentList.add(element);
    //   }
    // });
    setState(ViewState.Idle);
  }
  int getCurrentDay(DateTime date){
    return date.day;
  }
  int getNextDay(DateTime date){
    final tomorrow = DateTime(date.year, date.month, date.day + 1);
    return tomorrow.day;
  }
}