import 'dart:convert';
import 'package:enstaller/core/constant/api_urls.dart';
import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/model/abort_appointment_model.dart';
import 'package:enstaller/core/model/activity_details_model.dart';
import 'package:enstaller/core/model/app_table.dart';
import 'package:enstaller/core/model/contract_order_model.dart';
import 'package:enstaller/core/model/document_pdfopen_model.dart';
import 'package:enstaller/core/model/appointmentDetailsModel.dart';
import 'package:enstaller/core/model/comment_model.dart';
import 'package:enstaller/core/model/item_oder_model.dart';
import 'package:enstaller/core/model/order_detail_model.dart';
import 'package:enstaller/core/model/order_line_detail_model.dart';
import 'package:enstaller/core/model/order_model.dart';
import 'package:enstaller/core/model/save_order.dart';
import 'package:enstaller/core/model/save_order_line.dart';
import 'package:enstaller/core/model/serial_model.dart';
import 'package:enstaller/core/model/sms_notification_model.dart';
import 'package:enstaller/core/model/email_notification_model.dart';
import 'package:enstaller/core/model/customer_details.dart';
import 'package:enstaller/core/model/document_model.dart';
import 'package:enstaller/core/model/electric_and_gas_metter_model.dart';
import 'package:enstaller/core/model/login_credentials.dart';
import 'package:enstaller/core/model/login_responsemodel.dart';
import 'package:enstaller/core/model/question_answer_model.dart';
import 'package:enstaller/core/model/response_model.dart';
import 'package:enstaller/core/model/send/answer_credential.dart';
import 'package:enstaller/core/model/send/appointmentStatusUpdateCredential.dart';
import 'package:enstaller/core/model/send/comment_credential.dart';
import 'package:enstaller/core/model/stock_check_model.dart';
import 'package:enstaller/core/model/stock_request_reply_model.dart';
import 'package:enstaller/core/model/update_status_model.dart';
import 'package:enstaller/core/model/user_model.dart';
import 'package:enstaller/core/service/base_api.dart';
import 'package:enstaller/core/model/survey_response_model.dart';

class ApiService extends BaseApi{


  Future<dynamic> loginWithUserNamePassword(LoginCredential loginCredential){
    return postRequest(ApiUrls.logInUrl, (r) {
      final responseError = json.decode(r.body)['error_description'];
      if (responseError != null) {
        return LoginResponseModel(errorMessage: responseError);
      }else{
        return LoginResponseModel(
          errorMessage: null,
            userDetails: UserModel.fromJson(json.decode(r.body))
        );
      }
    },loginCredential.toJson());
  }
  Future <dynamic> getAppointmentList(String userID){
   return getRequestWithParam(ApiUrls.getappointmenttodaytomorrow,
           (response) {
     print(response.body);
     return (json.decode(response.body) as List).map((e) => Appointment.fromJson(e)).toList();

   }, 'id=$userID') ;
  }

  Future <dynamic> getAbortAppointmentList(String userID){
   return getRequestWithParam(ApiUrls.getReasonUserList,
           (response) {
     print(response.body);
     return (json.decode(response.body) as List).map((e) => AbortAppointmentModel.fromJson(e)).toList();

   }, 'UserId=$userID&type=Abort') ;
  }

  Future <dynamic> getEmailNotificationList(String userID){ 
   return getRequestWithParam(ApiUrls.getEmailTemplateSenderHistoryUserWise,
           (response) {
     print(response.body);
     return (json.decode(response.body) as List).map((e) => EmailNotificationModel.fromJson(e)).toList();

   }, 'intUserId=$userID') ;
  }
  Future <dynamic> getSMSNotificationList(String userID){
   return getRequestWithParam(ApiUrls.getSMSClickSendNotificationUserWise,
           (response) {
     print(response.body);
     return (json.decode(response.body) as List).map((e) => SMSNotificationModel.fromJson(e)).toList();

   }, 'intUserId=$userID') ;
  }



  Future <dynamic> getActivityLogsAppointmentId(String appointmentID){
    return getRequestWithParam(ApiUrls.getActivityLogsAppointmentIdUrl,
            (response) {
          print(response.body);
          return (json.decode(response.body) as List).map((e) => ActivityDetailsModel.fromJson(e)).toList();

        }, 'intId=$appointmentID') ;
  }
  Future <dynamic> getAppointmentDetails(String appointmentID){
    return getRequest(ApiUrls.getAppointmentDetailsUrl,
            (response) {
          print(response.body);
          return AppointmentDetails.fromJson(json.decode(response.body));

        }, '/$appointmentID') ;
  }
  Future <dynamic> getAppointmentCommentsByAppointment(String appointmentID){
    return getRequestWithParam(ApiUrls.getAppointmentCommentsByAppointmentUrl,
            (response) {
          print(response.body);
          return (json.decode(response.body) as List).map((e) => CommentModel.fromJson(e)).toList();

        }, 'intappintmentid=$appointmentID') ;
  }
  Future<dynamic> getAbortAppointmentCode(AppointmentStatusUpdateCredentials credentials){
    print(credentials.toJson());
    return postRequest(ApiUrls.updateAppointmentStatusUrl, (r) {
      final response = json.decode(r.body);
      if (response) {
        return ResponseModel(
            statusCode: 1,
            response: 'Successfully Updated'
        );
      }else{
        return ResponseModel(
            statusCode: 0,
            response: 'Please try again'
        );
      }
    },credentials.toJson());
  }
  Future<dynamic> getDocumentList(DocumentModel documentModel){
    print(documentModel.toJson());
    return postRequest(ApiUrls.getSupplierDocument, (r) {
      print(json.decode(r.body));
       return (json.decode(r.body) as List).map((e) => DocumentResponseModel.fromJson(e)).toList();
    
    },documentModel.toJson());
  }
  
  Future <dynamic> getCustomerMeterListByCustomer(String customerID){
    return getRequestWithParam(ApiUrls.getCustomerMeterListByCustomerUrl,
            (response) {
          print(response.body);
          return (json.decode(response.body) as List).map((e) => ElectricAndGasMeterModel.fromJson(e)).toList();

        }, 'intCustomerId=$customerID') ;
  }
  Future<dynamic> submitComment(CommentCredential commentCredential){
    return postRequest(ApiUrls.saveAppointmentComments, (r) {
      final response = json.decode(r.body);
      if (response) {
        return ResponseModel(
          statusCode: 1,
          response: 'Successfully Submited'
        );
      }else{
        return ResponseModel(
          statusCode: 0,
          response: 'Please try again'
        );
      }
    },commentCredential.toJson());
  }
  Future <dynamic> appointmentDataEventsbyEngineer(String engineerID){
    return getRequestWithParam(ApiUrls.appointmentDataEventsbyEngineerUrl,
            (response) {
          print(response.body);
          return (json.decode(response.body) as List).map((e) => StatusModel.fromJson(e)).toList();

        }, 'intId=$engineerID') ;
  }
  Future<dynamic> updateAppointmentStatus(AppointmentStatusUpdateCredentials credentials){
    print(credentials.toJson());
    return postRequest(ApiUrls.updateAppointmentStatusUrl, (r) {
      final response = json.decode(r.body);
      if (response) {
        
        return ResponseModel(
            statusCode: 1,
            response: 'Successfully Updated'
        );
      }else{
        return ResponseModel(
            statusCode: 0,
            response: 'Please try again'
        );
      }
    },credentials.toJson());
  }
  Future<dynamic> confirmAbortAppointment(ConfirmAbortAppointment credentials){
    print(credentials.toJson());

    return postRequest(ApiUrls.updateAbortAppointment, (r) {
      final response = json.decode(r.body);
      if (response) {
        
        return ResponseModel(
            statusCode: 1,
            response: 'Successfully Updated'
        );
      }else{
        return ResponseModel(
            statusCode: 0,
            response: 'Please try again'
        );
      }
    },credentials.toJson());
  }
  Future <dynamic> getSurveyQuestionAppointmentWise(String appointmentID){
    return getRequestWithParam(ApiUrls.getSurveyQuestionAppointmentWiseUrl,
            (response) {
          print(response.body);
          return (json.decode(response.body) as List).map((e) => SurveyResponseModel.fromJson(e)).toList();

        }, 'intappointmentId=$appointmentID') ;
  }
  Future <dynamic> getSurveyQuestionAnswerDetail(String appointmentID){
    return getRequestWithParam(ApiUrls.getSurveyQuestionAnswerDetailUrl,
            (response) {
          print(response.body);
          return (json.decode(response.body) as List).map((e) => QuestionAnswer.fromJson(e)).toList();

        }, 'intappointmentId=$appointmentID') ;
  }
  Future<dynamic> submitSurveyAnswer(AnswerCredential credentials){

    return postRequest(ApiUrls.addSurveyQuestionAnswerDetailUrl, (r) {
      final response = json.decode(r.body);
      print('response$response');
      return ResponseModel(
          statusCode: 1,
          response: 'Successfully Updated'
      );
    },credentials.toJson());



  }

  Future<dynamic> onclickpdf( PDFOpenModel pdFopenModel){

    return postRequest(ApiUrls.supplierDocumentUpdateEngineerRead, (r) {
      final response = json.decode(r.body);
      print('response$response');
      return ResponseModel(
          statusCode: 1,
          response: 'Successfully opened'
      );
    },pdFopenModel.toJson());
  }

  Future<dynamic> submitListSurveyAnswer(List<AnswerCredential> credentials){
    return postRequestList(ApiUrls.addSurveyQuestionAnswerDetailUrl, (r) {
      final response = json.decode(r.body);
      print('response$response');
      return ResponseModel(
          statusCode: 1,
          response: 'Successfully Updated'
      );
    },json.encoder.convert(credentials));
  }

  Future <dynamic> getCustomerById(String customerID){
    return getRequestWithParam(ApiUrls.getCustomerByIdUrl,
            (response) {
          print(response.body);
          return CustomerDetails.fromJson(json.decode(response.body));

        }, 'intCustomerId=$customerID') ;
  }
  Future <dynamic> getEngineerAppointments(String engeenerID,String date){
    return getRequestWithParam(ApiUrls.getEngineerAppointmentsUrl,
            (response) {
          print(response.body);
          return (json.decode(response.body)['table'] as List).map((e) => AppTable.fromJson(e)).toList();


        }, 'today=$date'+'&intId=$engeenerID') ;
  }
  Future <dynamic> getTodaysAppointments(String engeenerID,String date){
    return getRequestWithParam(ApiUrls.getEngineerAppointmentsUrl,
            (response) {
          print(response.body);
          return (json.decode(response.body)['table'] as List).map((e) => Appointment.fromJson(e)).toList();

        }, 'today=$date'+'&intId=$engeenerID') ;
  }

  Future<dynamic> getMAICheckProcess(String customerID, String processId ){
    return getRequestWithParam(ApiUrls.getMAICheckProcess,
            (r) {
      final response = json.decode(r.body);
      if (response.toString().toLowerCase() == 'true' ) {
        return ResponseModel(
            statusCode: 1,
            response: 'Successfully Updated'
        );
      }else{
        return ResponseModel(
            statusCode: 0,
            response: 'Please try again'
        );
      }
        }, 'intcustomerid=$customerID'+'&strProcessid=$processId') ;
  }

  Future <dynamic> getItemsForOrder(String userID){
    print(userID);
    return getRequestWithParam(ApiUrls.getItemsForOrder,
            (response) {
          print(response.body);
          return (json.decode(response.body) as List).map((e) => ItemOrder.fromJson(e)).toList();

        }, 'intUserId=$userID') ;
  }

  Future <dynamic> getContractsForOrder(String userID){
    return getRequestWithParam(ApiUrls.getContractsForOrder,
            (response) {
          print(response.body);
          return (json.decode(response.body) as List).map((e) => ContractOrder.fromJson(e)).toList();

        }, 'intUserId=$userID') ;
  }


  Future<dynamic> saveOrder(SaveOrder saveOrder){
    return postRequest(ApiUrls.saveOrder, (r) {
      final response = json.decode(r.body);
      print(response.runtimeType);


      if (response.runtimeType== int) {
        return ResponseModel(
            statusCode: 1,
            response: response.toString()
        );
      }else{
        return ResponseModel(
            statusCode: 0,
            response: AppStrings.UNABLE_TO_SAVE
        );
      }
    },saveOrder.toJson());
  }

  Future<dynamic> saveOrderLine(SaveOrderLine saveOrderLine){
    return postRequest(ApiUrls.saveOrderLine, (r) {
      final response = json.decode(r.body);
      print(response);
      if (response) {
        return ResponseModel(
            statusCode: 1,
            response: response.toString()
        );
      }else{
        return ResponseModel(
            statusCode: 0,
            response: AppStrings.UNABLE_TO_SAVE
        );
      }
    },saveOrderLine.toJson());
  }

  Future <dynamic> getStockCheckRequestList(String intEngineerId){
    return getRequestWithParam(ApiUrls.getStockCheckRequestList,
            (response) {
          print(response.body);
          return (json.decode(response.body) as List).map((e) => StockCheckModel.fromJson(e)).toList();

        }, 'intEngineerId=$intEngineerId') ;
  }

  Future <dynamic> getSerialsByRequestId(String intRequestId){
    return getRequestWithParam(ApiUrls.getSerialsByRequestId,
            (response) {
          print(response.body);
          return (json.decode(response.body) as List).map((e) => SerialNoModel.fromJson(e)).toList();

        }, 'intRequestId=$intRequestId') ;
  }

  Future<dynamic> validateSerialsForReply(List<SerialNoModel> list){
    final Map<String, dynamic> map = new Map<String, dynamic>();
    map['listSerialModel'] = list.map((e) => e.toJson()).toList();
    print("map is: $map");
    return postRequestList(ApiUrls.validateSerialsForReply, (r) {
      final response = json.decode(r.body);
      print(response);
      if (response != null) {
        return (response as List).map((e) => SerialNoModel.fromJson1(e)).toList() ;
      }else{
        return ResponseModel(
            statusCode: 0,
            response: AppStrings.UNABLE_TO_VALIDATE
        );
      }
    },json.encode(map));
  }

  Future<dynamic> saveEngineerReply(StockRequestReplyModel stockRequestReplyModel){

    return postRequestList(ApiUrls.saveEngineerReply, (r) {
      final response = json.decode(r.body);
      print(response);
      if (response) {
        return ResponseModel(
            statusCode: 1,
            response: response.toString()
        );
      }else{
        return ResponseModel(
            statusCode: 0,
            response: AppStrings.UNABLE_TO_SAVE
        );
      }
    },json.encode(stockRequestReplyModel.toJson()));
  }

  Future <dynamic> getOrderListByEngId(String engId){
    print(engId);
    return getRequestWithParam(ApiUrls.getOrderListByEngId,
            (response) {
          print(response.body);
          return (json.decode(response.body) as List).map((e) => OrderModel.fromJson(e)).toList();

        }, 'intEngId=$engId') ;
  }

  Future <dynamic> getStockOrderById(String intId){
    print(intId);
    return getRequestWithParam(ApiUrls.getStockOrderById,
            (response) {
          print(response.body);
          return OrderDetailModel.fromJson(json.decode(response.body));

        }, 'intId=$intId') ;
  }

  Future <dynamic> getStockOrderLineDetails(String intOrderId){
    print(intOrderId);
    return getRequestWithParam(ApiUrls.getStockOrderLineDetails,
            (response) {
          print(response.body);
          return (json.decode(response.body) as List).map((e) => OrderLineDetailModel.fromJson(e)).toList();

        }, 'intOrderId=$intOrderId') ;
  }

  Future <dynamic> getStockOrderLineItemsByOrderId(String intOrderId){
    print(intOrderId);
    return getRequestWithParam(ApiUrls.getStockOrderLineItemsByOrderId,
            (response) {
          print(response.body);
          return (json.decode(response.body) as List).map((e) => OrderLineDetailModel.fromJson(e)).toList();

        }, 'intOrderId=$intOrderId') ;
  }





}