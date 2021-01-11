import 'dart:io';

import 'dart:typed_data';

import 'package:flutter/material.dart';

class SurveyQuestion {
  int intId;
  String strQuestionRef;
  int intSectionID;
  String strSectionName;
  String strQuestionText;
  String strQuestiontype;
  String strListname;
  String isMandatoryOptional;
  int intQuestionNo;
  var strEnableQuestions;
  var strDisableQuestions;
  var strEnableSections;
  var strDisableSections;
  String strAbandonJobOn;
  var strRequireExplanation;
  var strShowIf;
  var strMinvalue;
  var strMaxvalue;
  var strDefaultvalue;
  var strActionValue;
  var strMinFieldSize;
  var strMaxFieldSize;
  var strFormat;
  var strExportColumn;
  bool bisAlive;
  String listOutput;
  int intJobTypeId;
  String strSurvey;
  bool yesNoPressedVal;
  String dropDownValue;
  File image;
  ByteData signatureImage;
  TextEditingController textEditingController;
  String barCodeScanVal;

  SurveyQuestion(
      {this.intId,
        this.strQuestionRef,
        this.intSectionID,
        this.strSectionName,
        this.strQuestionText,
        this.strQuestiontype,
        this.strListname,
        this.isMandatoryOptional,
        this.intQuestionNo,
        this.strEnableQuestions,
        this.strDisableQuestions,
        this.strEnableSections,
        this.strDisableSections,
        this.strAbandonJobOn,
        this.strRequireExplanation,
        this.strShowIf,
        this.strMinvalue,
        this.strMaxvalue,
        this.strDefaultvalue,
        this.strActionValue,
        this.strMinFieldSize,
        this.strMaxFieldSize,
        this.strFormat,
        this.strExportColumn,
        this.bisAlive,
        this.listOutput,
        this.intJobTypeId,
        this.yesNoPressedVal,
        this.strSurvey,this.dropDownValue});

  SurveyQuestion.fromJson(Map<String, dynamic> json) {
    intId = json['intId'];
    strQuestionRef = json['strQuestionRef'];
    intSectionID = json['intSectionID'];
    strSectionName = json['strSectionName'];
    strQuestionText = json['strQuestionText'];
    strQuestiontype = json['strQuestiontype'];
    strListname = json['strListname'];
    isMandatoryOptional = json['isMandatoryOptional'];
    intQuestionNo = json['intQuestionNo'];
    strEnableQuestions = json['strEnableQuestions'];
    strDisableQuestions = json['strDisableQuestions'];
    strEnableSections = json['strEnableSections'];
    strDisableSections = json['strDisableSections'];
    strAbandonJobOn = json['strAbandonJobOn'];
    strRequireExplanation = json['strRequireExplanation'];
    strShowIf = json['strShowIf'];
    strMinvalue = json['strMinvalue'];
    strMaxvalue = json['strMaxvalue'];
    strDefaultvalue = json['strDefaultvalue'];
    strActionValue = json['strActionValue'];
    strMinFieldSize = json['strMinFieldSize'];
    strMaxFieldSize = json['strMaxFieldSize'];
    strFormat = json['strFormat'];
    strExportColumn = json['strExportColumn'];
    bisAlive = json['bisAlive'];
    listOutput = json['listOutput'];
    intJobTypeId = json['intJobTypeId'];
    strSurvey = json['strSurvey'];
    yesNoPressedVal= json["yesNoPressedVal"] == null ? false : json["yesNoPressedVal"] ;
    dropDownValue= json["dropDownValue"] == null ? "Choose Option" :  json["dropDownValue"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intId'] = this.intId;
    data['strQuestionRef'] = this.strQuestionRef;
    data['intSectionID'] = this.intSectionID;
    data['strSectionName'] = this.strSectionName;
    data['strQuestionText'] = this.strQuestionText;
    data['strQuestiontype'] = this.strQuestiontype;
    data['strListname'] = this.strListname;
    data['isMandatoryOptional'] = this.isMandatoryOptional;
    data['intQuestionNo'] = this.intQuestionNo;
    data['strEnableQuestions'] = this.strEnableQuestions;
    data['strDisableQuestions'] = this.strDisableQuestions;
    data['strEnableSections'] = this.strEnableSections;
    data['strDisableSections'] = this.strDisableSections;
    data['strAbandonJobOn'] = this.strAbandonJobOn;
    data['strRequireExplanation'] = this.strRequireExplanation;
    data['strShowIf'] = this.strShowIf;
    data['strMinvalue'] = this.strMinvalue;
    data['strMaxvalue'] = this.strMaxvalue;
    data['strDefaultvalue'] = this.strDefaultvalue;
    data['strActionValue'] = this.strActionValue;
    data['strMinFieldSize'] = this.strMinFieldSize;
    data['strMaxFieldSize'] = this.strMaxFieldSize;
    data['strFormat'] = this.strFormat;
    data['strExportColumn'] = this.strExportColumn;
    data['bisAlive'] = this.bisAlive;
    data['listOutput'] = this.listOutput;
    data['intJobTypeId'] = this.intJobTypeId;
    data['strSurvey'] = this.strSurvey;
    data["dropDownValue"]=this.dropDownValue;
    data['yesNoPressedVal']= this.yesNoPressedVal;
    return data;
  }
}