
import 'dart:convert';
import 'package:encrypt/encrypt.dart' as AESencrypt;
import 'package:connectivity/connectivity.dart';
import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/question_answer_model.dart';
import 'package:enstaller/core/model/response_model.dart';
import 'package:enstaller/core/model/send/answer_credential.dart';
import 'package:enstaller/core/model/user_model.dart';
import 'package:enstaller/core/provider/base_model.dart';
import 'package:enstaller/core/service/api_service.dart';
import 'package:enstaller/core/service/pref_service.dart';
import 'package:enstaller/core/model/survey_response_model.dart';
import 'package:enstaller/core/viewmodel/details_screen_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SurveyScreenViewModel extends BaseModel {
  ApiService _apiService = ApiService();
  List<SurveyResponseModel>_surveyQuestion = [];
  List<SurveyResponseModel>firstQuestions = [];
  List<SurveyResponseModel>secondQuestions = [];
  List<SurveyResponseModel>thirdQuestions = [];
  List<SurveyResponseModel>_firstQuestions=[];
  List<SurveyResponseModel>_secondQuestions=[];
  List<SurveyResponseModel>_thirdQuestions=[];
  List<QuestionAnswer>firstAnswers=[];
  List<QuestionAnswer>secondAnswers=[];
  List<QuestionAnswer>thirdAnswers=[];
  bool submitFirstBool=false;
  bool submitSecondBool=false;
  bool submitThirdBool=false;
  int selected=0;
  int enableIndex=0;
  Set<String> _setofUnSubmittedForm = {};
  UserModel user;
  final Connectivity _connectivity = Connectivity();
  List<AnswerCredential>answerList=[];
  List disableQuestions=[];
  List enableQuestions=[];

  void onChangeSelected(int value) {
    setState(ViewState.Busy);
    if(enableIndex>=value){
      selected = value;

    }
    setState(ViewState.Idle);
  }

  bool get validationValue{
    if(selected==0){
      return submitFirstBool;
    }else if(selected==1){
      return submitSecondBool;
    }else{
      return submitThirdBool;
    }
  }
  void closeExpand(){
    setState(ViewState.Busy);
    selected=3;
    setState(ViewState.Idle);
  }

  void initializeData(String appointmentID,bool edit) async {
    setState(ViewState.Busy);
    user=await Prefs.getUser();
    if(!edit){
      firstQuestions=[];


      _surveyQuestion =
      await _apiService.getSurveyQuestionAppointmentWise(appointmentID);


      _surveyQuestion.forEach((element) {

        if (element.intSectionId == 1) {
          _firstQuestions.add(element);

          if(element.strQuestiontype=='YN'){
            if(element.yesNoPressedVal==1){
              if(element.strDisableQuestions!=null){
                String numberString=element.strDisableQuestions.split('Yes:')[1];
                List listData=numberString.split(",");
                for(int i=0;i<listData.length;i++){
                  if(!disableQuestions.contains(listData[i])){
                    disableQuestions.add(listData[i]);
                  }

                }
              }
              if(element.strEnableQuestions!=null){
                String numberString=element.strEnableQuestions.split('No:')[1];
                List listData=numberString.split(",");
                for(int i=0;i<listData.length;i++){
                  if(!enableQuestions.contains(listData[i])){
                    enableQuestions.add(listData[i]);
                  }

                }
              }

            }

          }
          if(!disableQuestions.contains('${element.intQuestionNo}')){
            firstQuestions.add(element);
            print('added${element.intQuestionNo}');
          }
          print('length${firstQuestions.length}');



        } else if (element.intSectionId == 2) {

          _secondQuestions.add(element);
          if(element.strQuestiontype=='YN'){
            if(element.yesNoPressedVal==1){
              if(element.strDisableQuestions!=null){
                String numberString=element.strDisableQuestions.split('Yes:')[1];
                List listData=numberString.split(",");
                for(int i=0;i<listData.length;i++){
                  if(!disableQuestions.contains(listData[i])){
                    disableQuestions.add(listData[i]);
                  }

                }
              }


            }else if(element.yesNoPressedVal==0){
              if(element.strEnableQuestions!=null){
                String numberString=element.strEnableQuestions.split('No:')[1];
                List listData=numberString.split(",");
                for(int i=0;i<listData.length;i++){
                  if(!enableQuestions.contains(listData[i])){
                    enableQuestions.add(listData[i]);
                  }

                }
              }
            }

          }
          if(!disableQuestions.contains('${element.intQuestionNo}')){
            secondQuestions.add(element);
            print('added${element.intId}');
          }
        } else if (element.intSectionId == 3) {
          _thirdQuestions.add(element);
          if(element.strQuestiontype=='YN'){
            if(element.yesNoPressedVal==1){
              if(element.strDisableQuestions!=null){
                String numberString=element.strDisableQuestions.split('Yes:')[1];
                List listData=numberString.split(",");
                for(int i=0;i<listData.length;i++){
                  if(!disableQuestions.contains(listData[i])){
                    disableQuestions.add(listData[i]);
                  }

                }
              }

            }

          }
          print(disableQuestions.contains('${element.intQuestionNo}'));

          if(!disableQuestions.contains('${element.intQuestionNo}')){
            thirdQuestions.add(element);
          }
        }
      });

    }else{
      List<QuestionAnswer>_answers=await _apiService.getSurveyQuestionAnswerDetail(appointmentID);

      print('objectAnswerLength===${_answers.length}');
      firstAnswers=[];
      secondAnswers=[];
      thirdAnswers=[];
      _answers.forEach((answer) {
        if(answer.intSectionID==1){
          firstAnswers.add(answer);

          print('${firstAnswers.length}');
        }else if(answer.intSectionID==2){
          secondAnswers.add(answer);
        }else if(answer.intSectionID==3){
          thirdAnswers.add(answer);
        }
      });
    }


    setState(ViewState.Idle);
  }
  void onChangeYesNo(SurveyResponseModel surveyResponseModel){
    setState(ViewState.Busy);
    print('surr===${surveyResponseModel.validate}');
    for (int i=0;i<_firstQuestions.length;i++){
      if(_firstQuestions[i].intQuestionNo==surveyResponseModel.intQuestionNo){
        _firstQuestions[i]=surveyResponseModel;

      }

    }
    for (int i=0;i<_secondQuestions.length;i++){
      if(_secondQuestions[i].intQuestionNo==surveyResponseModel.intQuestionNo){
        _secondQuestions[i]=surveyResponseModel;
      }

    }
    for (int i=0;i<_thirdQuestions.length;i++){
      if(_thirdQuestions[i].intQuestionNo==surveyResponseModel.intQuestionNo){
        _thirdQuestions[i]=surveyResponseModel;
        print('_firstQuestions[i].validate${_thirdQuestions[i].validate}');
        if(_thirdQuestions[i].strQuestiontype=='L'){
          print('#########${_thirdQuestions[i].validate}');

          if(_thirdQuestions[i].validate=='Energised'){
            if(_thirdQuestions[i].strDisableQuestions!=null){
              String numberString=_thirdQuestions[i].strDisableQuestions.split('Energised:')[1];
              List listData=numberString.split(",");
              listData.forEach((listElement) {
                if(!disableQuestions.contains(listElement)){
                  disableQuestions.add(listElement);
                }
              });
            }

          }else if(_thirdQuestions[i].validate=='De-Energised'){
            if(_thirdQuestions[i].strDisableQuestions!=null){
              print('object${_thirdQuestions[i].strDisableQuestions}');
              String numberString=_thirdQuestions[i].strDisableQuestions.split('Energised:')[1];
              List listData=numberString.split(",");
              listData.forEach((listElement) {
                if(disableQuestions.contains(listElement)){
                  disableQuestions.remove(listElement);
                }
              });
            }

          }
        }
      }

    }
    firstQuestions=[];
    secondQuestions=[];
    thirdQuestions=[];
    _surveyQuestion.forEach((element) {
      if (element.intSectionId == 1) {
        _firstQuestions.add(element);
        if(element.strQuestiontype=='YN'){
          if(element.yesNoPressedVal==1){
            if(element.strDisableQuestions!=null){
              String numberString=element.strDisableQuestions.split('Yes:')[1];
              List listData=numberString.split(",");
              listData.forEach((listElement) {
                if(!disableQuestions.contains(listElement)){
                  disableQuestions.add(listElement);
                }
              });

            }


          }else if(element.yesNoPressedVal==0){
            print('EnableQuestions${element.strEnableQuestions}');
            if(element.strEnableQuestions!=null){
              print('EnableQuestions${element.strEnableQuestions}');
              String numberString=element.strEnableQuestions.split('No:')[1];
              List listData=numberString.split(",");
              listData.forEach((listElement) {
                print(listElement);
                if(disableQuestions.contains(listElement)){
                  disableQuestions.remove(listElement);
                }
              });
            }
          }

        }

        print(disableQuestions);
        print(element.intQuestionNo.toString());
        if(!disableQuestions.contains('${element.intQuestionNo}')){
          firstQuestions.add(element);
          print('added${element.intQuestionNo}');
        }
        print('length${firstQuestions.length}');



      } else if (element.intSectionId == 2) {
        _secondQuestions.add(element);
        if(element.strQuestiontype=='YN'){
          if(element.yesNoPressedVal==1){
            if(element.strDisableQuestions!=null){
              String numberString=element.strDisableQuestions.split('No:')[1];
              List listData=numberString.split(",");
              listData.forEach((listElement) {
                if(!disableQuestions.contains(listElement)){
                  disableQuestions.add(listElement);
                }
              });

            }


          }else if(element.yesNoPressedVal==0){
            print('EnableQuestions${element.strEnableQuestions}');
            if(element.strEnableQuestions!=null){
              print('EnableQuestions${element.strEnableQuestions}');
              String numberString=element.strEnableQuestions.split('Yes:')[1];
              List listData=numberString.split(",");
              listData.forEach((listElement) {
                print(listElement);
                if(disableQuestions.contains(listElement)){
                  disableQuestions.remove(listElement);
                }
              });
            }
          }

        }else if(element.strQuestiontype=='M'){
          if(element.dropDownValue=='Energised'){
            String numberString=element.strDisableQuestions.split('Energised:')[1];
            List listData=numberString.split(",");
            listData.forEach((listElement) {
              if(!disableQuestions.contains(listElement)){
                disableQuestions.add(listElement);
              }
            });
          }else if(element.dropDownValue=='De-Energised'){
            String numberString=element.strDisableQuestions.split('De-Energised:')[1];
            List listData=numberString.split(",");
            listData.forEach((listElement) {
              if(!disableQuestions.contains(listElement)){
                disableQuestions.add(listElement);
              }
            });
          }
        }
        print(disableQuestions);
        print(element.intQuestionNo.toString());
        if(!disableQuestions.contains('${element.intQuestionNo}')){
          secondQuestions.add(element);
        }
      } else if (element.intSectionId == 3) {
        _thirdQuestions.add(element);
        if(element.strQuestiontype=='YN'){
          if(element.yesNoPressedVal==1){
            if(element.strDisableQuestions!=null){
              String numberString=element.strDisableQuestions.split('Yes:')[1];
              List listData=numberString.split(",");
              listData.forEach((listElement) {
                if(!disableQuestions.contains(listElement)){
                  disableQuestions.add(listElement);
                }
              });

            }


          }else if(element.yesNoPressedVal==0){
            print('EnableQuestions${element.strEnableQuestions}');
            if(element.strEnableQuestions!=null){
              print('EnableQuestions${element.strEnableQuestions}');
              String numberString=element.strEnableQuestions.split('No:')[1];
              List listData=numberString.split(",");
              listData.forEach((listElement) {
                print(listElement);
                if(disableQuestions.contains(listElement)){
                  disableQuestions.remove(listElement);
                }
              });
            }
          }

        }
        if(element.strQuestiontype=='M'){
          print('object${surveyResponseModel.validate}');
          if(surveyResponseModel.validate=='Energised'){
            String numberString=element.strDisableQuestions.split('Energised:')[1];
            List listData=numberString.split(",");
            listData.forEach((listElement) {
              if(!disableQuestions.contains(listElement)){
                disableQuestions.add(listElement);
              }
            });
          }else if(surveyResponseModel.validate=='De-Energised'){
            String numberString=element.strDisableQuestions.split('De-Energised:')[1];
            List listData=numberString.split(",");
            listData.forEach((listElement) {
              if(!disableQuestions.contains(listElement)){
                disableQuestions.add(listElement);
              }
            });
          }
        }
        if(!disableQuestions.contains('${element.intQuestionNo}')){
          thirdQuestions.add(element);
          print('added${element.intQuestionNo}');
        }

      }
    });

    setState(ViewState.Idle);

  }
  void clearAnswer(){
    setState(ViewState.Busy);
    answerList=[];
    setState(ViewState.Idle);
  }
  void onAddAnswer(AnswerCredential credential){
    setState(ViewState.Busy);
    
    answerList.add(credential);
    setState(ViewState.Idle);
  }

  void incrementCounter(){
    setState(ViewState.Busy);
    if(selected<2){
      selected++;
    }
    setState(ViewState.Idle);
  }
  void onSubmit(int selected, String appointmentid, BuildContext context, DetailsScreenViewModel dsmodel) async{
    setState(ViewState.Busy);
//    for (int i=0;i<answerList.length;i++){
//      ResponseModel responseModel=await _apiService.submitSurveyAnswer(answerList[i]);
//      if(i==answerList.length-1){
//        if(responseModel.statusCode==1){
//          setState(ViewState.Idle);
//          if (selected < 2) {
//            selected++;
//            enableIndex++;
//          }else {
//            selected=-1;
//          }
//        }
//      }
//
//    }
     try {
      ConnectivityResult  result = await _connectivity.checkConnectivity();
      String status = _updateConnectionStatus(result);
      if(status!="NONE"){
       ResponseModel responseModel=await _apiService.submitListSurveyAnswer(answerList);
       print(responseModel.response);
       if(responseModel.statusCode==1){
       setState(ViewState.Idle);
          if (selected < 2) {
            selected++;
            enableIndex++;
          }else {
            selected=-1;
            _openJumboTab(dsmodel, appointmentid);
          }
        }
      }
      else{
        print("********online*****");
        SharedPreferences preferences = await SharedPreferences.getInstance();
        List<String> _list = [];
        answerList.forEach((element) { 
          _list.add(jsonEncode(element.toJson()));
        });
        if(preferences.getStringList("listOfUnSubmittedForm")!=null)
        {
          _setofUnSubmittedForm = preferences.getStringList("listOfUnSubmittedForm").toSet();
        }
        _setofUnSubmittedForm.add(appointmentid);

        preferences.setStringList("listOfUnSubmittedForm", _setofUnSubmittedForm.toList());
        preferences.setStringList("key${selected.toString()}+$appointmentid", _list);
        setState(ViewState.Idle);
        if (selected < 2) {
            selected++;
            enableIndex++;
          }else {
            selected=-1;
             _openJumboTab(dsmodel, appointmentid);
          }
        AppConstants.showFailToast(context, "Submitted Offline");
       
      }
    } on PlatformException catch (e) {
      print(e.toString());
    }

    
    setState(ViewState.Idle);
  }
  _openJumboTab(DetailsScreenViewModel dsmodel, String appointmentid) async{
   var AppointmentType = dsmodel.appointmentDetails.appointment.strAppointmentType.trim();
   var MPAN;
   var MPRN;
   
   if(dsmodel.electricGasMeterList.isEmpty){
     MPRN = "";
     MPAN = "";
   }
   else{
     dsmodel.electricGasMeterList.forEach((element) {
       if(element.strFuel=="ELECTRICITY"){
         MPAN = element.strMpan;
         MPRN = "";
       }
       else if(element.strFuel=="GAS"){
         MPRN = element.strMpan;
         MPAN = "";
       }
      });
   }
   if (AppointmentType == "Scheduled Exchange" || AppointmentType == "Emergency Exchange" || AppointmentType == "New Connection" || AppointmentType == "Meter Removal") {
       if (MPAN != "" &&  MPRN != "") {
           //alert(MPAN + '-' + MPRN);
           
       }
       else if ( MPAN != "" &&  MPRN == "") {
           var appointId = encryption(appointmentid);
           var url = 'https://enstaller.enpaas.com/jmbCloseJob/AddElectricityCloseJob?intAppointmentId=' + appointId;
           launchurl(url);
       }
       else if ( MPRN != "" &&  MPAN == "") {
           var appointId = encryption(appointmentid);
           var url = 'https://enstaller.enpaas.com/jmbCloseJob/AddGasCloseJob?intAppointmentId=' + appointId;
           launchurl(url);
       }
   }
  }

  encryption(String value) {
    final key = AESencrypt.Key.fromUtf8('8080808080808080');
    final iv = AESencrypt.IV.fromUtf8('8080808080808080');
    final encrypter = AESencrypt.Encrypter(
        AESencrypt.AES(key, mode: AESencrypt.AESMode.cbc, padding: 'PKCS7'));

    final encrypted = encrypter.encrypt(value, iv: iv);

    return encrypted.base64
        .toString()
        .replaceAll('/', 'SLH')
        .replaceAll('+', 'PLS')
        .replaceAll('/', 'SLH')
        .replaceAll('/', 'SLH')
        .replaceAll('/', 'SLH')
        .replaceAll('/', 'SLH')
        .replaceAll('+', 'PLS')
        .replaceAll('+', 'PLS')
        .replaceAll('+', 'PLS')
        .replaceAll('+', 'PLS');
  }

  launchurl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not open the map.';
    }
  }
  void onValidation(){
    setState(ViewState.Busy);
    if(selected==0){
      submitFirstBool=true;
    }else if(selected==1){
      submitSecondBool=true;
    }else{
      submitThirdBool=true;
    }
    setState(ViewState.Idle);
  }

String _updateConnectionStatus(ConnectivityResult result)  {
    switch (result) {
      case ConnectivityResult.wifi:
        return "WIFI";
        break;
      case ConnectivityResult.mobile:
        return "MOBILE";
        break;
      case ConnectivityResult.none:
        return "NONE";
        break;
      default:
        return "NO RECORD";
        break;
    }
  }

  void onSubmitOffline(int selected, String appointmentid, List<AnswerCredential> _listofanswer) async{
    print("**********offline********");
     try {
      ConnectivityResult  result = await _connectivity.checkConnectivity();
      String status = _updateConnectionStatus(result);
      if(status!="NONE"){
       ResponseModel responseModel=await _apiService.submitListSurveyAnswer(_listofanswer);
       print(responseModel.response);
       
      }
      else{
        SharedPreferences preferences = await SharedPreferences.getInstance();
        List<String> _list = [];
        _listofanswer.forEach((element) { 
          _list.add(jsonEncode(element.toJson()));
        });
        if(preferences.getStringList("listOfUnSubmittedForm")!=null)
        {
          _setofUnSubmittedForm = preferences.getStringList("listOfUnSubmittedForm").toSet();
        }
        _setofUnSubmittedForm.add(appointmentid);

        preferences.setStringList("listOfUnSubmittedForm", _setofUnSubmittedForm.toList());
        preferences.setStringList("key${selected.toString()}+$appointmentid", _list);
      }
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }


}