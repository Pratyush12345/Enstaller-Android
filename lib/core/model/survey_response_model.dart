// To parse this JSON data, do
//
//     final surveyResponseModel = surveyResponseModelFromJson(jsonString);

import 'dart:convert';

import 'dart:io';

import 'dart:typed_data';

import 'package:flutter/material.dart';

List<SurveyResponseModel> surveyResponseModelFromJson(String str) => List<SurveyResponseModel>.from(json.decode(str).map((x) => SurveyResponseModel.fromJson(x)));

String surveyResponseModelToJson(List<SurveyResponseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SurveyResponseModel {
  SurveyResponseModel({
    this.intId,
    this.strQuestionRef,
    this.intSectionId,
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
    this.strSurvey,
    this.dropDownValue,
    this.yesNoPressedVal,
    this.image,
    this.signatureImage,
    this.textEditingController,
    this.barCodeScanVal,
    this.validate,
    this.enable:true

  });
  String validate;
  int intId;
  bool enable;
  String strQuestionRef;
  int intSectionId;
  String strSectionName;
  String strQuestionText;
  String strQuestiontype;
  String strListname;
  String isMandatoryOptional;
  int intQuestionNo;
  String strEnableQuestions;
  String strDisableQuestions;
  dynamic strEnableSections;
  dynamic strDisableSections;
  String strAbandonJobOn;
  String strRequireExplanation;
  String strShowIf;
  dynamic strMinvalue;
  dynamic strMaxvalue;
  String strDefaultvalue;
  String strActionValue;
  dynamic strMinFieldSize;
  dynamic strMaxFieldSize;
  dynamic strFormat;
  dynamic strExportColumn;
  bool bisAlive;
  String listOutput;
  int intJobTypeId;
  String strSurvey;
  String dropDownValue;
  int yesNoPressedVal;
  File image;
  ByteData signatureImage;
  TextEditingController textEditingController;
  String barCodeScanVal;

  factory SurveyResponseModel.fromJson(Map<String, dynamic> json) => SurveyResponseModel(
    intId: json["intId"],
    strQuestionRef: json["strQuestionRef"],
    intSectionId: json["intSectionID"],
    strSectionName: json["strSectionName"],
    strQuestionText: json["strQuestionText"],
    strQuestiontype: json["strQuestiontype"],
    strListname: json["strListname"] == null ? null : json["strListname"],
    isMandatoryOptional: json["isMandatoryOptional"],
    intQuestionNo: json["intQuestionNo"],
    strEnableQuestions: json["strEnableQuestions"] == null ? null : json["strEnableQuestions"],
    strDisableQuestions: json["strDisableQuestions"] == null ? null : json["strDisableQuestions"],
    strEnableSections: json["strEnableSections"],
    strDisableSections: json["strDisableSections"],
    strAbandonJobOn: json["strAbandonJobOn"] == null ? null : json["strAbandonJobOn"],
    strRequireExplanation: json["strRequireExplanation"] == null ? null : json["strRequireExplanation"],
    strShowIf: json["strShowIf"] == null ? null : json["strShowIf"],
    strMinvalue: json["strMinvalue"],
    strMaxvalue: json["strMaxvalue"],
    strDefaultvalue: json["strDefaultvalue"] == null ? null : json["strDefaultvalue"],
    strActionValue: json["strActionValue"] == null ? null : json["strActionValue"],
    strMinFieldSize: json["strMinFieldSize"],
    strMaxFieldSize: json["strMaxFieldSize"],
    strFormat: json["strFormat"],
    strExportColumn: json["strExportColumn"],
    bisAlive: json["bisAlive"],
    listOutput: json["listOutput"] == null ? null : json["listOutput"],
    intJobTypeId: json["intJobTypeId"],
    strSurvey: json["strSurvey"],
    dropDownValue: json["dropDownValue"] == null ? "Choose Option" :  json["dropDownValue"],
    yesNoPressedVal: json["yesNoPressedVal"] == null ? 2 : json["yesNoPressedVal"] ,
    image: json["image"] == null ? null : json["image"] ,
    signatureImage: json["signatureImage"] == null ? null : json["signatureImage"] ,
    textEditingController: json["textEditingController"] == null ? null : json["textEditingController"] ,
    barCodeScanVal: json["barCodeScanVal"] == null ? "" : json["barCodeScanVal"] ,
  );

  Map<String, dynamic> toJson() => {
    "intId": intId,
    "strQuestionRef": strQuestionRef,
    "intSectionID": intSectionId,
    "strSectionName": strSectionName,
    "strQuestionText": strQuestionText,
    "strQuestiontype": strQuestiontype,
    "strListname": strListname == null ? null : strListname,
    "isMandatoryOptional": isMandatoryOptional,
    "intQuestionNo": intQuestionNo,
    "strEnableQuestions": strEnableQuestions == null ? null : strEnableQuestions,
    "strDisableQuestions": strDisableQuestions == null ? null : strDisableQuestions,
    "strEnableSections": strEnableSections,
    "strDisableSections": strDisableSections,
    "strAbandonJobOn": strAbandonJobOn == null ? null : strAbandonJobOn,
    "strRequireExplanation": strRequireExplanation == null ? null : strRequireExplanation,
    "strShowIf": strShowIf == null ? null : strShowIf,
    "strMinvalue": strMinvalue,
    "strMaxvalue": strMaxvalue,
    "strDefaultvalue": strDefaultvalue == null ? null : strDefaultvalue,
    "strActionValue": strActionValue == null ? null : strActionValue,
    "strMinFieldSize": strMinFieldSize,
    "strMaxFieldSize": strMaxFieldSize,
    "strFormat": strFormat,
    "strExportColumn": strExportColumn,
    "bisAlive": bisAlive,
    "listOutput": listOutput == null ? null : listOutput,
    "intJobTypeId": intJobTypeId,
    "strSurvey": strSurvey,
    "dropDownValue": dropDownValue,
    "yesNoPressedVal": yesNoPressedVal,
    "image": image,
    "signatureImage": signatureImage,
    "textEditingController": textEditingController,
    "barCodeScanVal": barCodeScanVal,
  };
}


