import 'dart:convert';
import 'package:encrypt/encrypt.dart' as AESencrypt;
import 'package:connectivity/connectivity.dart';
import 'package:enstaller/core/constant/appconstant.dart';
import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/electric_and_gas_metter_model.dart';
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
  List<SurveyResponseModel> _surveyQuestion = [];
  Map<int, List<SurveyResponseModel>> sectionQuestions = {};
  Map<int, List<SurveyResponseModel>> _sectionQuestions = {};
  Map<int, List<QuestionAnswer>> sectionAnswers = {};
  Map<int, bool> sectionBools = {};
  Map<int, String> sectionNames = {};
  Map<int, List> sectionDisableQuestions = {};
  Map<int, List> sectionEnableQuestions = {};
  int selected = 0;
  int enableIndex = 0;
  Set<String> _setofUnSubmittedForm = {};
  UserModel user;
  final Connectivity _connectivity = Connectivity();
  List<AnswerCredential> answerList = [];
  
  
  void onChangeSelected(int value) {
    setState(ViewState.Busy);
    if (enableIndex >= value) {
      selected = value;
    }
    setState(ViewState.Idle);
  }

  
  bool get validationValue {
    int i = 0;

    for (int j = 0; j < sectionQuestions.keys.length; j++) {
      if (selected == i) {
        return sectionBools[sectionBools.keys.toList()[selected]];
      }
      i++;
    }
    
  }

  void closeExpand() {
    setState(ViewState.Busy);
    selected = sectionQuestions.keys.length - 1;
    setState(ViewState.Idle);
  }

  
  void initializeData(String appointmentID, bool edit) async {
    setState(ViewState.Busy);
    user = await Prefs.getUser();
    if (!edit) {
      
      _surveyQuestion =
          await _apiService.getSurveyQuestionAppointmentWise(appointmentID);
      
      _surveyQuestion.forEach((element) {
        List<SurveyResponseModel> list = [];
        List templist = [];
        List<QuestionAnswer> ansList = [];
        if (!sectionQuestions.containsKey(element.intSectionId)) {
          _sectionQuestions.putIfAbsent(element.intSectionId, () => list);
          sectionQuestions.putIfAbsent(element.intSectionId, () => list);
          sectionDisableQuestions.putIfAbsent(
              element.intSectionId, () => templist);
          
          sectionAnswers.putIfAbsent(element.intSectionId, () => ansList);
          sectionBools.putIfAbsent(element.intSectionId, () => false);
          sectionNames.putIfAbsent(
              element.intSectionId, () => element.strSectionName);
        }
  
      });
      _surveyQuestion.forEach((element) {
        if (_sectionQuestions[element.intSectionId].indexOf(element) == -1)
          _sectionQuestions[element.intSectionId].add(element);
        if (element.strQuestiontype == 'YN') {
         if (element.yesNoPressedVal == 1) {
          if (element.strDisableQuestions != null &&
              element.strDisableQuestions.isNotEmpty && element.strEnableQuestions != null &&
              element.strEnableQuestions.isNotEmpty) {
            String numberString;  
            if(element.strDisableQuestions.contains('Yes:') && !element.strDisableQuestions.contains('No:')){  
            numberString =  element.strDisableQuestions.split('Yes:')[1];
            if(numberString!=null){
            List<String> listData = numberString.trim().split(",");
            for (int i = 0; i < listData.length; i++) {
              if (!sectionDisableQuestions[element.intSectionId]
                  .contains(listData[i].trim())) {
                sectionDisableQuestions[element.intSectionId].add(listData[i].trim());
              }
            }
            }
            
            }
            else if(element.strEnableQuestions.contains("Yes:") && !element.strEnableQuestions.contains("No:")){ 
             numberString =  element.strEnableQuestions.split('Yes:')[1];
             if(numberString!=null){
            List<String> listData = numberString.trim().split(",");
            for (int i = 0; i < listData.length; i++) {
              if (sectionDisableQuestions[element.intSectionId]
                  .contains(listData[i].trim())) {
                sectionDisableQuestions[element.intSectionId].remove(listData[i].trim());
              }
            }
            }
            }

            
          }
        } else if (element.yesNoPressedVal == 0) {
          if (element.strDisableQuestions != null &&
              element.strDisableQuestions.isNotEmpty&& element.strEnableQuestions != null &&
              element.strEnableQuestions.isNotEmpty) {
            String numberString;    
            if(element.strEnableQuestions.contains('No:') && !element.strEnableQuestions.contains('Yes:')){
            numberString = element.strEnableQuestions.split('No:')[1];
            if(numberString!=null){
            List<String> listData = numberString.trim().split(",");
            for (int i = 0; i < listData.length; i++) {
              if (sectionDisableQuestions[element.intSectionId]
                  .contains(listData[i].trim())) {
                sectionDisableQuestions[element.intSectionId].remove(listData[i].trim());
              }
            }
            }
            }
            else if(element.strDisableQuestions.contains('No:') && !element.strDisableQuestions.contains('Yes:')){  
            numberString = element.strDisableQuestions.split('No:')[1];
            if(numberString!=null){
            List<String> listData = numberString.trim().split(",");
            for (int i = 0; i < listData.length; i++) {
              if (!sectionDisableQuestions[element.intSectionId]
                  .contains(listData[i].trim())) {
                sectionDisableQuestions[element.intSectionId].add(listData[i].trim());
              }
            }
            }
            
            }
          }
        }

          
        }
        else if(element.strQuestiontype == 'R'){
           element.validate = "NotNull";
        }
          if (sectionQuestions[element.intSectionId].indexOf(element) == -1)
            sectionQuestions[element.intSectionId].add(element);
          print('added${element.intQuestionNo}');
          print(_sectionQuestions[1].length.toString() + 'line 157');

        
      });
    } 
    else {
      List<QuestionAnswer> _answers =
          await _apiService.getSurveyQuestionAnswerDetail(appointmentID);
      _answers.forEach((element) {
        List<SurveyResponseModel> list = [];
        List templist = [];
        List<QuestionAnswer> ansList = [];
        if (!sectionQuestions.containsKey(element.intSectionID)) {
          _sectionQuestions.putIfAbsent(element.intSectionID, () => list);
          sectionQuestions.putIfAbsent(element.intSectionID, () => list);
          sectionDisableQuestions.putIfAbsent(
              element.intSectionID, () => templist);
          sectionAnswers.putIfAbsent(element.intSectionID, () => ansList);
          sectionBools.putIfAbsent(element.intSectionID, () => false);
          sectionNames.putIfAbsent(
              element.intSectionID, () => element.strSectionName);
        }
      });
          
      sectionAnswers.forEach((key, value) {
        sectionAnswers[key] = [];
      });

      print('objectAnswerLength===${_answers.length}');
      _answers.forEach((answer) {
        sectionAnswers[answer.intSectionID].add(answer);
        
      });
    }
    
    setState(ViewState.Idle);
  }

  
  
  void onChangeYesNo(SurveyResponseModel surveyResponseModel) {
    // setState(ViewState.Busy);
    print('surr===${surveyResponseModel.validate}');
    if (!(surveyResponseModel.intSectionId == 3)) {
      var index = _sectionQuestions[surveyResponseModel.intSectionId]
          .indexWhere((element) =>
              element.intQuestionNo == surveyResponseModel.intQuestionNo);
      _sectionQuestions[surveyResponseModel.intSectionId][index] =
          surveyResponseModel;
    } else {
      var index = _sectionQuestions[surveyResponseModel.intSectionId]
          .indexWhere((element) =>
              element.intQuestionNo == surveyResponseModel.intQuestionNo);
      _sectionQuestions[surveyResponseModel.intSectionId][index] =
          surveyResponseModel;
      if (_sectionQuestions[surveyResponseModel.intSectionId][index]
              .strQuestiontype ==
          'L') {
        print(
            '#########${_sectionQuestions[surveyResponseModel.intSectionId][index].validate}');

        if (_sectionQuestions[surveyResponseModel.intSectionId][index]
                .validate ==
            'Energised') {
          if (_sectionQuestions[surveyResponseModel.intSectionId][index]
                      .strDisableQuestions !=
                  null &&
              _sectionQuestions[surveyResponseModel.intSectionId][index]
                  .strDisableQuestions
                  .isNotEmpty) {
            String numberString =
                _sectionQuestions[surveyResponseModel.intSectionId][index]
                    .strDisableQuestions
                    .split('Energised:')[1];
            List<String> listData = numberString.trim().split(",");
            listData.forEach((listElement) {
              if (!sectionDisableQuestions[surveyResponseModel.intSectionId]
                  .contains(listElement.trim())) {
                // if (sectionDisableQuestions[surveyResponseModel.intSectionId]
                //         .indexOf(surveyResponseModel) ==
                //     -1)
                sectionDisableQuestions[surveyResponseModel.intSectionId]
                    .add(listElement.trim());
              }
            });
          }
        } else if (_sectionQuestions[surveyResponseModel.intSectionId][index]
                .validate ==
            'De-Energised') {
          if (_sectionQuestions[surveyResponseModel.intSectionId][index]
                      .strDisableQuestions !=
                  null &&
              _sectionQuestions[surveyResponseModel.intSectionId][index]
                  .strDisableQuestions
                  .isNotEmpty) {
            print(
                'object${_sectionQuestions[surveyResponseModel.intSectionId][index].strDisableQuestions}');
            String numberString =
                _sectionQuestions[surveyResponseModel.intSectionId][index]
                    .strDisableQuestions
                    .split('Energised:')[1];
            List<String> listData = numberString.trim().split(",");
            listData.forEach((listElement) {
              if (sectionDisableQuestions[surveyResponseModel.intSectionId]
                  .contains(listElement.trim())) {
                sectionDisableQuestions[surveyResponseModel.intSectionId]
                    .remove(listElement.trim());
              }
            });
          }
        }
      }
    }

    print('line 342');
    sectionQuestions.forEach((key, value) {
      sectionQuestions[key] = [];
    });
    _surveyQuestion.forEach((element) {
      if (_sectionQuestions[element.intSectionId].indexOf(element) == -1)
        _sectionQuestions[element.intSectionId].add(element);
      if (element.strQuestiontype == 'YN') {
          if (element.yesNoPressedVal == 1) {
          if ((element.strDisableQuestions != null &&
              element.strDisableQuestions.isNotEmpty) || (element.strEnableQuestions != null &&
              element.strEnableQuestions.isNotEmpty)) {
                
            String numberString;  
            if(element.strDisableQuestions.contains('Yes:') && !element.strDisableQuestions.contains('No:')){  
            numberString =  element.strDisableQuestions.split('Yes:')[1];
            
            if(numberString!=null){
            List<String> listData = numberString.trim().split(",");
            for (int i = 0; i < listData.length; i++) {
              if (!sectionDisableQuestions[element.intSectionId]
                  .contains(listData[i].trim())) {
                sectionDisableQuestions[element.intSectionId].add(listData[i].trim());
              }
            }
            }
            
            }
            else if(element.strEnableQuestions.contains("Yes:") && !element.strEnableQuestions.contains("No:")){ 
             numberString =  element.strEnableQuestions.split('Yes:')[1];
             if(numberString!=null){
            List<String> listData = numberString.trim().split(",");
            for (int i = 0; i < listData.length; i++) {
              if (sectionDisableQuestions[element.intSectionId]
                  .contains(listData[i].trim())) {
                sectionDisableQuestions[element.intSectionId].remove(listData[i].trim());
              }
            }
            }
            }

            else if(element.strEnableQuestions.contains("Yes:") && element.strDisableQuestions.contains("Yes:")){ 
             String enablenumberString, disablenumberString;
             enablenumberString =  element.strEnableQuestions.split('Yes: ')[1].split(" ")[0].trim();
             disablenumberString = element.strDisableQuestions.split('Yes: ')[1].split(" ")[0].trim();
             
             if(enablenumberString!=null && disablenumberString!=null && surveyResponseModel.intQuestionNo == 86)
             {
               if (!sectionDisableQuestions[element.intSectionId]
                  .contains("88")) {
                sectionDisableQuestions[element.intSectionId].add("88");
              }
              if (sectionDisableQuestions[element.intSectionId]
                  .contains("87")) {
                sectionDisableQuestions[element.intSectionId].remove("87");
              } 
             }
             else if(enablenumberString!=null && disablenumberString!=null)
             if(numberString!=null){
            List<String> enablelistData = enablenumberString.trim().split(",");
            for (int i = 0; i < enablelistData.length; i++) {
              if (sectionDisableQuestions[element.intSectionId]
                  .contains(enablelistData[i].trim())) {
                sectionDisableQuestions[element.intSectionId].remove(enablelistData[i].trim());
              }
            }
            List<String> disablelistData = disablenumberString.trim().split(",");
            for (int i = 0; i < disablelistData.length; i++) {
              if (!sectionDisableQuestions[element.intSectionId]
                  .contains(disablelistData[i].trim())) {
                sectionDisableQuestions[element.intSectionId].add(disablelistData[i].trim());
              }
            }
            }
            }
          }
          
          
        } 
        else if (element.yesNoPressedVal == 0) {
          if ((element.strDisableQuestions != null &&
              element.strDisableQuestions.isNotEmpty) || (element.strEnableQuestions != null &&
              element.strEnableQuestions.isNotEmpty)) {
            String numberString;    
            if(element.strEnableQuestions.contains('No:') && !element.strEnableQuestions.contains('Yes:')){
            numberString = element.strEnableQuestions.split('No:')[1];
            if(numberString!=null){
            List<String> listData = numberString.trim().split(",");
            for (int i = 0; i < listData.length; i++) {
              if (sectionDisableQuestions[element.intSectionId]
                  .contains(listData[i].trim())) {
                sectionDisableQuestions[element.intSectionId].remove(listData[i].trim());
              }
            }
            }
            }
            else if(element.strDisableQuestions.contains('No:') && !element.strDisableQuestions.contains('Yes:')){  
            numberString = element.strDisableQuestions.split('No:')[1];
            if(numberString!=null){
            List<String> listData = numberString.trim().split(",");
            for (int i = 0; i < listData.length; i++) {
              if (!sectionDisableQuestions[element.intSectionId]
                  .contains(listData[i].trim())) {
                sectionDisableQuestions[element.intSectionId].add(listData[i].trim());
              }
            }
            }
            
            }
            else if(element.strEnableQuestions.contains("No:") && element.strDisableQuestions.contains("No:")){ 
             String enablenumberString, disablenumberString;
             enablenumberString =  element.strEnableQuestions.split('No: ')[1].split(" ")[0].trim();
             disablenumberString = element.strDisableQuestions.split('No: ')[1].split(" ")[0].trim();
             
             if(enablenumberString!=null && disablenumberString!=null && surveyResponseModel.intQuestionNo == 86)
             {
               if (!sectionDisableQuestions[element.intSectionId]
                  .contains("87")) {
                sectionDisableQuestions[element.intSectionId].add("87");
              }
              if (sectionDisableQuestions[element.intSectionId]
                  .contains("88")) {
                sectionDisableQuestions[element.intSectionId].remove("88");
              } 
             }
             else if(enablenumberString!=null && disablenumberString!=null)
             if(numberString!=null){
            List<String> enablelistData = enablenumberString.trim().split(",");
            for (int i = 0; i < enablelistData.length; i++) {
              if (sectionDisableQuestions[element.intSectionId]
                  .contains(enablelistData[i].trim())) {
                sectionDisableQuestions[element.intSectionId].remove(enablelistData[i].trim());
              }
            }
            List<String> disablelistData = disablenumberString.trim().split(",");
            for (int i = 0; i < disablelistData.length; i++) {
              if (!sectionDisableQuestions[element.intSectionId]
                  .contains(disablelistData[i].trim())) {
                sectionDisableQuestions[element.intSectionId].add(disablelistData[i].trim());
              }
            }
            }
            }
          }
          else if(element.strAbandonJobOn == "No"){
            setState(ViewState.Busy);
            if (selected < sectionQuestions.keys.length - 1) {
                selected = sectionQuestions.keys.length - 1;
             }
            setState(ViewState.Idle);  
          }

        }
      } else if (element.strQuestiontype == 'L') {
        
        
        if (element.dropDownValue.trim() == 'Energised' && surveyResponseModel.intQuestionNo == 24) {
          
          String numberString =
              element.strDisableQuestions.split('Energised:')[1];
          List<String> listData = numberString.trim().split(",");
          listData.forEach((listElement) {
            if (!sectionDisableQuestions[element.intSectionId]
                .contains(listElement.trim())) {
              sectionDisableQuestions[element.intSectionId].add(listElement.trim());
            }
          });
        } else if (element.dropDownValue.trim() == 'De-Energised' && surveyResponseModel.intQuestionNo == 24) {
          String numberString =
              element.strEnableQuestions.split('De-Energised:')[1];
          List<String> listData = numberString.trim().split(",");
          listData.forEach((listElement) {
            if (sectionDisableQuestions[element.intSectionId]
                .contains(listElement.trim())) {
              sectionDisableQuestions[element.intSectionId].remove(listElement.trim());
            }
          });
        }
        else if(surveyResponseModel.intQuestionNo == 28 && element.intQuestionNo == 28){
          
          String enablenumberString, disablenumberString;
          if(element.strEnableQuestions.contains('${element.dropDownValue.trim()}: '))
          enablenumberString = element.strEnableQuestions.split('${element.dropDownValue.trim()}: ')[1]?.split(" ")[0]?.trim();
          if(element.strDisableQuestions.contains('${element.dropDownValue.trim()}: '))
          disablenumberString = element.strDisableQuestions.split('${element.dropDownValue.trim()}: ')[1]?.split(" ")[0]?.trim();
            
            if(enablenumberString!=null && disablenumberString!=null ){
            for (int i = 29; i <= 56; i++) {
              
              if(enablenumberString.contains(i.toString())) {
                if (sectionDisableQuestions[element.intSectionId]
                  .contains(i.toString())) {
                sectionDisableQuestions[element.intSectionId].remove(i.toString());
                }
              }
              else if(disablenumberString.contains(i.toString())){
                if (!sectionDisableQuestions[element.intSectionId]
                  .contains(i.toString())) {
                sectionDisableQuestions[element.intSectionId].add(i.toString());
                }
              } 
            }
          }
            
        }
        else if(surveyResponseModel.intQuestionNo == 60 && element.intQuestionNo == 60){
          
          String enablenumberString, disablenumberString;
          if(element.strEnableQuestions.contains('${element.dropDownValue.trim()}: '))
          enablenumberString = element.strEnableQuestions.split('${element.dropDownValue.trim()}: ')[1].split(" ")[0].trim();
          if(element.strDisableQuestions.contains('${element.dropDownValue.trim()}: '))
          disablenumberString = element.strDisableQuestions.split('${element.dropDownValue.trim()}: ')[1].split(" ")[0].trim();
            
            if(enablenumberString!=null && disablenumberString!=null ){
            for (int i = 61; i <= 84; i++) {
              
              if(enablenumberString.contains(i.toString())) {
                if (sectionDisableQuestions[element.intSectionId]
                  .contains(i.toString())) {
                sectionDisableQuestions[element.intSectionId].remove(i.toString());
                }
              }
              else if(disablenumberString.contains(i.toString())){
                if (!sectionDisableQuestions[element.intSectionId]
                  .contains(i.toString())) {
                sectionDisableQuestions[element.intSectionId].add(i.toString());
                }
              } 
            }
          }
            
        }
        else if(surveyResponseModel.intQuestionNo == 22 && element.intQuestionNo == 22){
          String enablenumberString, disablenumberString;
          if(element.strEnableQuestions.contains('${element.dropDownValue.trim()}: '))
          enablenumberString = element.strEnableQuestions.split('${element.dropDownValue.trim()}: ')[1].split(" ")[0].trim();
          if(element.strDisableQuestions.contains('${element.dropDownValue.trim()}: '))
          disablenumberString = element.strDisableQuestions.split('${element.dropDownValue.trim()}: ')[1].split(" ")[0].trim();
            
            if(enablenumberString!=null && disablenumberString == null){
                if (sectionDisableQuestions[element.intSectionId]
                  .contains("23")) {
                sectionDisableQuestions[element.intSectionId].remove("23");
                }
               
          }
          else{
            if (!sectionDisableQuestions[element.intSectionId]
                  .contains("23")) {
                sectionDisableQuestions[element.intSectionId].add("23");
                }
          }
          
        }
        else if(surveyResponseModel.intQuestionNo == 205 && element.intQuestionNo == 205){
          GlobalVar.abortReason = element.dropDownValue.trim();
          String disablenumberString;
          if(element.strDisableQuestions.contains('${element.dropDownValue.trim()}: '))
          disablenumberString = element.strDisableQuestions.split('${element.dropDownValue.trim()}: ')[1].split(" ")[0].trim();
            
            if(disablenumberString != null){
                if (!sectionDisableQuestions[element.intSectionId]
                  .contains("206")) {
                sectionDisableQuestions[element.intSectionId].add("206");
                }
               
          }
          
        }
        
      }
      // if (!sectionDisableQuestions[element.intSectionId]
      //     .contains('${element.intQuestionNo}')) {
        if (sectionQuestions[element.intSectionId].indexOf(element) == -1)
          sectionQuestions[element.intSectionId].add(element);
        print('added${element.intQuestionNo}');
      
    });

    // setState(ViewState.Idle);
  }

  
  void clearAnswer() {
    setState(ViewState.Busy);
    answerList = [];
    setState(ViewState.Idle);
  }

  
  
  void onAddAnswer(AnswerCredential credential) {
    setState(ViewState.Busy);

    answerList.add(credential);
    setState(ViewState.Idle);
  }

  
  
  void incrementCounter(bool isedit) {
    setState(ViewState.Busy);
    if(isedit){
     if (selected < sectionQuestions.keys.length - 1) {
      selected++;
    }
    }else{
    if (selected < sectionQuestions.keys.length - 2) {
      selected++;
    }
    }
    setState(ViewState.Idle);
  }
  
  
  void onSubmit(int selected, String appointmentid, BuildContext context,
      DetailsScreenViewModel dsmodel, String sectionname) async {
    setState(ViewState.Busy);

    print(selected.toString() + 'line 1130');
    
    print("^^^^^^^^^^^^^^^^^^^^^^^^^^");
    print(selected);
    print(sectionQuestions.keys.length - 1);
    print("^^^^^^^^^^^^^^^^^^^^^^^^^^");
    if (selected <= sectionQuestions.keys.length - 2) {
      selected++;
      enableIndex++;
    } 
    
    if(sectionname.trim() == "Abort"){
      try {
        ConnectivityResult result = await _connectivity.checkConnectivity();
        String status = _updateConnectionStatus(result);
        if (status != "NONE") {
          ResponseModel responseModel =
              await _apiService.submitListSurveyAnswer(answerList);
          ResponseModel abortreasonmodel = await _apiService.abortappointmentbyreason(
            AbortAppointmentReasonModel(
              intId: int.parse( appointmentid),
              isabort: 0,
              strCancellationReason: GlobalVar.abortReason
            )
          );    
          print(responseModel.response);
          if (responseModel.statusCode == 1) {
            AppConstants.showFailToast(context, "Survey Aborted");
            GlobalVar.isloadAppointmentDetail = true;
            Navigator.of(context).pop("Abort");
            
          }
        } else {
          print("********online*****");
          SharedPreferences preferences = await SharedPreferences.getInstance();
          List<String> _list = [];
          answerList.forEach((element) {
            _list.add(jsonEncode(element.toJson()));
          });
          if (preferences.getStringList("listOfUnSubmittedForm") != null) {
            _setofUnSubmittedForm =
                preferences.getStringList("listOfUnSubmittedForm").toSet();
          }
          _setofUnSubmittedForm.add(appointmentid);

          preferences.setStringList(
              "listOfUnSubmittedForm", _setofUnSubmittedForm.toList());
          preferences.setStringList(
              "key+$appointmentid", _list);
          openJumboTab(dsmodel, appointmentid);
          
          AppConstants.showSuccessToast(context, "Submitted Offline");
        }
      } on PlatformException catch (e) {
        print(e.toString());
      }
      selected = -1;
    }
    else if(sectionname.trim() == "Sign Off") {
      try {
        ConnectivityResult result = await _connectivity.checkConnectivity();
        String status = _updateConnectionStatus(result);
        if (status != "NONE") {
          ResponseModel responseModel =
              await _apiService.submitListSurveyAnswer(answerList);
          dsmodel.onUpdateStatusOnCompleted(context, appointmentid);    
          print(responseModel.response);
          if (responseModel.statusCode == 1) {
            AppConstants.showSuccessToast(context, "Survey Submitted");
            //Navigator.of(context).pop("Sign Off");
            openJumboTab(dsmodel, appointmentid);
            
          }
        } else {
          print("********online*****");
          SharedPreferences preferences = await SharedPreferences.getInstance();
          List<String> _list = [];
          answerList.forEach((element) {
            _list.add(jsonEncode(element.toJson()));
          });
          if (preferences.getStringList("listOfUnSubmittedForm") != null) {
            _setofUnSubmittedForm =
                preferences.getStringList("listOfUnSubmittedForm").toSet();
          }
          _setofUnSubmittedForm.add(appointmentid);

          preferences.setStringList(
              "listOfUnSubmittedForm", _setofUnSubmittedForm.toList());
          preferences.setStringList(
              "key+$appointmentid", _list);
          openJumboTab(dsmodel, appointmentid);
          
          AppConstants.showFailToast(context, "Submitted Offline");
        }
      } on PlatformException catch (e) {
        print(e.toString());
      }
      selected = -1;
    }

    setState(ViewState.Idle);
  }


  openJumboTab(DetailsScreenViewModel dsmodel, String appointmentid) async {
    var AppointmentType =
        dsmodel.appointmentDetails.appointment.strAppointmentType.trim();
    if (AppointmentType == "Scheduled Exchange" ||
        AppointmentType == "Emergency Exchange" ||
        AppointmentType == "New Connection" ||
        AppointmentType == "Meter Removal") {
      var appointId = encryption(appointmentid);
      var url =
          'https://enstaller.enpaas.com/jmbCloseJob/AddCloseJob?intAppointmentId=' +
              appointId;
      print(url);
      launchurl(url);
      
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


  void onValidation() {
    setState(ViewState.Busy);
    int i = 0;
    sectionBools.forEach((key, value) {
      if (selected == i) {
        sectionBools[key] = true;
      }
      i++;
    });
    
    setState(ViewState.Idle);
  }



  String _updateConnectionStatus(ConnectivityResult result) {
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



  void onSubmitOffline(String appointmentid,
      List<AnswerCredential> _listofanswer) async {
    print("**********offline********");
    try {
      ConnectivityResult result = await _connectivity.checkConnectivity();
      String status = _updateConnectionStatus(result);
      if (status != "NONE") {
        ResponseModel responseModel =
            await _apiService.submitListSurveyAnswer(_listofanswer);
        print(responseModel.response);
      } else {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        List<String> _list = [];
        _listofanswer.forEach((element) {
          _list.add(jsonEncode(element.toJson()));
        });
        if (preferences.getStringList("listOfUnSubmittedForm") != null) {
          _setofUnSubmittedForm =
              preferences.getStringList("listOfUnSubmittedForm").toSet();
        }
        _setofUnSubmittedForm.add(appointmentid);

        preferences.setStringList(
            "listOfUnSubmittedForm", _setofUnSubmittedForm.toList());
        preferences.setStringList(
            "key+$appointmentid", _list);
      }
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }


  String checkXCANC(List<ElectricAndGasMeterModel> electricGasMeterList){
    //setState(ViewState.Busy);
    String mpan = "none", mprn = "none", msg = "none";
    try{
      ElectricAndGasMeterModel model = electricGasMeterList
        .firstWhere((element) => element.strFuel == "ELECTRICITY");
      if(model.strMpan!=null && model.strMpan!=''){
        mpan = "mpan";
      }
    }
    catch(e){
       
    }

    try{
      ElectricAndGasMeterModel model = electricGasMeterList
        .firstWhere((element) => element.strFuel == "GAS");
      if(model.strMpan!=null && model.strMpan!=''){
        mprn = "mprn";
      }
    }
    catch(e){
      mprn = "none";
    }
    if(mprn!="none" && mpan!="none" ){
      msg = "both";
    }
    else if(mprn=="none" && mpan!="none"){
      msg = "mpan";
    }
    else if(mprn!="none" && mpan=="none"){
      msg = "mprn";
    }
    else{
      msg = "none";
    }
    return msg;
  }



  void onRaiseButtonPressed(String customerid, String processId, List<ElectricAndGasMeterModel> electricGasMeterList) async {
    setState(ViewState.Busy);
    UserModel userModel = await Prefs.getUser();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String ups = preferences.getString('ups');
    
      if (processId == "79" || processId == "81" || processId == "94" ) {
        startGasProcess(processId, userModel, ups, customerid, electricGasMeterList);
      } else {
        startElecProcess(processId, userModel, ups, customerid, electricGasMeterList);
      }
    setState(ViewState.Idle);
  }



  startElecProcess(
      String processId, UserModel userModel, String ups, String customerID,List<ElectricAndGasMeterModel> electricGasMeterList) {
    try{
    var custId = customerID;
    var DCCMAIWebUrl = 'https://mai.enpaas.com/';

    ElectricAndGasMeterModel model = electricGasMeterList
        .firstWhere((element) => element.strFuel == "ELECTRICITY");
    var mpan = model.strMpan;
    var em = userModel.email.toString();
    var sessionId = userModel.id.toString();
    if (mpan == null || mpan == '') {
    } else {
      var strUrl = '';
      var strPara = '';
      var strEncrypt;
      strPara += 'Enstaller/' +
          custId +
          '/' +
          processId +
          '/' +
          mpan +
          '/' +
          ups +
          '/' +
          sessionId +
          '/' +
          '108' +
          '/' +
          em;

      strEncrypt = encryption(strPara);
      strUrl += '' + DCCMAIWebUrl + '?returnUrl=' + strEncrypt + '';

      launchurl(strUrl);
    }
    }
      catch(err){
      print(err);
    }
    
  }



  startGasProcess(
      String processId, UserModel userModel, String ups, String customerID, List<ElectricAndGasMeterModel> electricGasMeterList) {
    var custId = customerID;
    try{
      
    ElectricAndGasMeterModel model =
        electricGasMeterList.firstWhere((element) => element.strFuel == "GAS");
    var mpan = model.strMpan;
    var em = userModel.email.toString();
    var sessionId = userModel.id.toString();
    var DCCMAIWebUrl = 'https://mai.enpaas.com/';
    if (mpan == null || mpan == '') {
    } else {
      var strUrl = '';
      var strEncrypt;
      var strPara = '';
      strPara += 'Enstaller/' +
          custId +
          '/' +
          processId +
          '/' +
          mpan +
          '/' +
          ups +
          '/' +
          sessionId +
          '/' +
          '109' +
          '/' +
          em;
      strEncrypt = encryption(strPara);
      strUrl += '' + DCCMAIWebUrl + '?returnUrl=' + strEncrypt + '';
      launchurl(strUrl);
    }
      }
    catch(err){
      print(err);
    }
  } 
}
