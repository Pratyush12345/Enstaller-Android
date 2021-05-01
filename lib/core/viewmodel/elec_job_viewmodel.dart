import 'package:enstaller/core/model/elec_closejob_model.dart';
import 'package:flutter/cupertino.dart';

class ElecJobViewModel {
  ElecJobViewModel.meterList(){
   initmeterList();
  }
  ElecJobViewModel.codeOfPractiseMList(){
    initCodePractiseMList();
  }
  ElecJobViewModel.registerList(){
    initregisterList();
  }
  ElecJobViewModel.readingList(){
    initreadingList();
  }
  ElecJobViewModel.regimesList(){
    initregimesList();
  }

  ElecJobViewModel.outStationList(){
    initOutStationList();
  }
  ElecJobViewModel.codeOfPractiseOSList(){
    initCodeOfPractiseOSList();
  }
  ElecJobViewModel.commsList(){
    initCommsList();
  }
  ElecJobViewModel.passwordList(){
    initPasswordList();
  }
  ElecJobViewModel.usernameList(){
    initUserNameList();
  }


  static ElecJobViewModel instance = ElecJobViewModel._();
  ElecJobViewModel._();
  Map<String, dynamic> elecjobJson ={};
  List<CloseJobQuestionModel> addElecCloseJobList = [];
  List<CloseJobQuestionModel> meterList = [];
  int meterCount;
  List<CloseJobQuestionModel> codePractiseList = [];
  List<CloseJobQuestionModel> registerList = [];
  List<CloseJobQuestionModel> readingList = [];
  List<CloseJobQuestionModel> regimesList = [];
  List<CloseJobQuestionModel> outStationList = [];
  int outStationCount;
  List<CloseJobQuestionModel> codeOfPractiseOSList = [];
  List<CloseJobQuestionModel> commsList = [];
  List<CloseJobQuestionModel> passwordList = [];
  List<CloseJobQuestionModel> usernameList = [];
  List<CloseJobQuestionModel> siteVisitList = [];
  List<CloseJobQuestionModel> supplyList = [];
  
 

  initialize(CheckTable checkTable ){
    initaddCLoseJob(checkTable);
    meterCount = 0;
    initmeterList();
    initCodePractiseMList();
    initregisterList();
    initreadingList();
    initregimesList();
    outStationCount = 0;
    initOutStationList();
    initCodeOfPractiseOSList();
    initCommsList();
    initPasswordList();
    initUserNameList();
    initSiteVisitList();
    initSupplyList();
  }

  initaddCLoseJob(CheckTable checkTable){
   addElecCloseJobList = [
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: null, 
      strQuestion: "Add Electricity Close Job", textController: null,
      type: "header", isMandatory: false 
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strExternalJobReference", 
      strQuestion: "External Job Reference", textController: TextEditingController(),
      type: "text", isMandatory: false 
    ),
      CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strJumboId", 
      strQuestion: "Jumbo Id", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
      CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strMPAN", 
      strQuestion: "MPAN", textController: TextEditingController()..text = checkTable.strMpan??"",
      type: "text" , isMandatory: true
    ),
      CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strJumboJobType", 
      strQuestion: "Jumbo Job Type", textController: TextEditingController(),
      type: "text", isMandatory: false 
    ),
      CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strAdditionalInformation", 
      strQuestion: "Additional Information", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
      CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strAssetCondition", 
      strQuestion: "Asset Condition", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
      CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strAssetConditionReportDate", 
      strQuestion: "Asset Condition Report Date", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
      CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strMSNSFC", 
      strQuestion: "MSNSFC", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
      CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strMaxPowerRequirement", 
      strQuestion: "MaxPower Requirement", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
      CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strMeasurementClassId", 
      strQuestion: "Measurement Class Id", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
      CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strReasonNotResolved", 
      strQuestion: "Reason Not Resolved", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
      CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strRemoteDisableEnableCapability", 
      strQuestion: "Remote Disable Enable Capability", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
      CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strSSC", 
      strQuestion: "SSC", textController: TextEditingController()..text = checkTable.strSSC??"",
      type: "text" , isMandatory: false
    ),
      CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strServiceLocation", 
      strQuestion: "Service Location", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
      CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strSmartMeterInstallation", 
      strQuestion: "SmartMeter Installation", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
      CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strSpecialAccess", 
      strQuestion: "Special Access", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
      CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strTariffCode", 
      strQuestion: "Tariff Code", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
      CloseJobQuestionModel(
      checkBoxVal: false, jsonfield: "bitMeters", 
      strQuestion: "Meters", textController: null,
      type: "checkBox" , isMandatory: false
    ),
      CloseJobQuestionModel(
      checkBoxVal: false, jsonfield: "bitOutStations", 
      strQuestion: "Out Stations", textController: null,
      type: "checkBox" , isMandatory: false
    ),
      
      CloseJobQuestionModel(
      checkBoxVal: false, jsonfield: "bitSiteVisit", 
      strQuestion: "Site Visit", textController: null,
      type: "checkBox" , isMandatory: false
    ),
      
      CloseJobQuestionModel(
      checkBoxVal: false, jsonfield: "bitSupply", 
      strQuestion: "Supply", textController: null,
      type: "checkBox" , isMandatory: false
    ),
  ];
  }
  initmeterList(){
  meterList = [
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: null, 
      strQuestion: "Meter", textController: null,
      type: "header" , isMandatory: true
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strSerialNumberM", 
      strQuestion: "Serial Number", textController: TextEditingController(),
      type: "text" , isMandatory: true
    ),
      CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strCTRatioM", 
      strQuestion: "CT Ratio", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strCertificationDateM", 
      strQuestion: "Certification Date", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strCertificationExpiryDateM", 
      strQuestion: "Certification ExpiryDate", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "bitCodeOfPracticeM", 
      strQuestion: "Code Of Practice", textController: null,
      type: "header" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strCreditBalanceM", 
      strQuestion: "Credit Balance", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strCurrentBalanceM", 
      strQuestion: "Current Balance", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strCurrentRatingM", 
      strQuestion: "Current Rating", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strDebtRecoveryRateM", 
      strQuestion: "Debt Recovery Rate", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strEmergencyCreditM", 
      strQuestion: "Emergency Credit", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strEmergencyCreditOverrideM", 
      strQuestion: "Emergency Credit Override", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strEmergencyCreditStatusM", 
      strQuestion: "Emergency Credit Status", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strInitialCreditM", 
      strQuestion: "Initial Credit", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strLocationM", 
      strQuestion: "Location", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strMainOrCheckM", 
      strQuestion: "Main Or Check", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strManufacturerAndModelM", 
      strQuestion: "Manufacturer And Model", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strRemovedM", 
      strQuestion: "Removed", textController: TextEditingController(),
      type: "text" , isMandatory: true
    ),CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strRetrievalMethodM", 
      strQuestion: "Retrieval Method", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strRetrievalMethodEffectiveDateM", 
      strQuestion: "Retrieval Method Effective Date", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strStandingChargeM", 
      strQuestion: "Standing Charge", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strStandingChargeOverrideM", 
      strQuestion: "Standing Charge Override", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strTimingDeviceSerialNumberM", 
      strQuestion: "Timing Device Serial Number", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strTotalCreditAcceptedM", 
      strQuestion: "Total Credit Accepted", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strTotalDebtM", 
      strQuestion: "Total Debt", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strTotalDebtOutstandingM", 
      strQuestion: "Total Debt Outstanding", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strTotalTokensInsertedM", 
      strQuestion: "Total Tokens Inserted", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strTypeM", 
      strQuestion: "Type", textController: TextEditingController(),
      type: "text" , isMandatory: true
    ),CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strVTRatioM", 
      strQuestion: "VT Ratio", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: true, jsonfield: null, 
      strQuestion: "Register", textController: null,
      type: "checkBox" , isMandatory: true
    ),

  ];
  }

  initCodePractiseMList(){

  codePractiseList = [
    
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strCodeOfPracticeCodeM", 
      strQuestion: "Code", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strCodeOfPracticeDispensationM", 
      strQuestion: "Dispensation", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strCodeOfPracticeIssueNumberM", 
      strQuestion: "Issue Number", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
  ];
  }

  initregisterList(){

  registerList = [
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: null, 
      strQuestion: "Register", textController: null,
      type: "header", isMandatory: true 
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strIdR", 
      strQuestion: "Id", textController: TextEditingController(),
      type: "text" , isMandatory: true
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strRemovedR", 
      strQuestion: "Removed", textController: TextEditingController(),
      type: "text" , isMandatory: true
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strAssociatedMeterIdR", 
      strQuestion: "AssociatedMeter Id", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strAssociatedRegisterIdR", 
      strQuestion: "Associated Register Id", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strChannelNumberR", 
      strQuestion: "Channel Number", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strDescriptionR", 
      strQuestion: "Description", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strMeasurementQuantityIdR", 
      strQuestion: "Measurement Quantity Id", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strMeterMemoryLocationR", 
      strQuestion: "Meter Memory Location", textController: TextEditingController(),
      type: "text" , isMandatory: true
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strMeterMemoryLocationTypeR", 
      strQuestion: "Meter Memory Location Type", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strMultiplierR", 
      strQuestion: "Multiplier", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strNumberOfDigitsR", 
      strQuestion: "Number Of Digits", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strPulseMultiplierR", 
      strQuestion: "Pulse Multiplier", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strPrepayUnitRateR", 
      strQuestion: "Prepay Unit Rate", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strTimestampMeterMemoryLocationR", 
      strQuestion: "Timestamp Meter Memory Location", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strTypeR", 
      strQuestion: "Type", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: false, jsonfield: "bitReading", 
      strQuestion: "Reading", textController: null,
      type: "checkBox" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: false, jsonfield: "bitRegimes", 
      strQuestion: "Time Pattern Regimes", textController: null,
      type: "checkBox" , isMandatory: false
    ),
  ];
  }  

  initreadingList(){
  readingList = [
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: null, 
      strQuestion: "Reading", textController: null,
      type: "header", isMandatory: false 
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strReadingFlagR", 
      strQuestion: "Flag", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strReadingTypeR", 
      strQuestion: "Type", textController: TextEditingController(),
      type: "text" , isMandatory: true
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strReadingValueR", 
      strQuestion: "Value", textController: TextEditingController(),
      type: "text" , isMandatory: true
    ),
  ];
  }

  initregimesList(){

  regimesList = [
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: null, 
      strQuestion: "Time pattern Regimes", textController: null,
      type: "header", isMandatory: false 
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strTimePatternRegimeCode1R", 
      strQuestion: "Code1", textController: TextEditingController(),
      type: "text" , isMandatory: true
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strTimePatternRegimeCode2R", 
      strQuestion: "Code2", textController: TextEditingController(),
      type: "text" , isMandatory: true
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strRegisterMappingCoefficient1R", 
      strQuestion: "Register Mapping Coefficient1", textController: TextEditingController(),
      type: "text" , isMandatory: true
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strRegisterMappingCoefficient2R", 
      strQuestion: "Register Mapping Coefficient2", textController: TextEditingController(),
      type: "text" , isMandatory: true
    ),
  ];
  }

  initOutStationList(){
  outStationList = [
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: null, 
      strQuestion: "Out Station", textController: null,
      type: "header" , isMandatory: true
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strIdOS", 
      strQuestion: "Id", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strRemovedOS", 
      strQuestion: "Removed", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: null, 
      strQuestion: "Code Of Practice", textController: null,
      type: "header" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: true, jsonfield: null, 
      strQuestion: "Comms", textController: null,
      type: "checkBox" , isMandatory: true
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strEncryptionkeyOS", 
      strQuestion: "Encryption key", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strMultiplierOS", 
      strQuestion: "Multiplier", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strNumberOfChannelsOS", 
      strQuestion: "Number Of Channels", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strNumberOfDigitsOS", 
      strQuestion: "Number Of Digits", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: null, 
      strQuestion: "Password", textController: null,
      type: "header" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strPinOS", 
      strQuestion: "Pin", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strTypeOS", 
      strQuestion: "Type", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: null, 
      strQuestion: "Usernames", textController: null,
      type: "header" , isMandatory: false
    ),
    
  ];
  }

  initCodeOfPractiseOSList(){

  codeOfPractiseOSList = [

     CloseJobQuestionModel(
      checkBoxVal: null, jsonfield:  "strCodeOfPracticeCodeOS", 
      strQuestion:  "Code Of Practice Code", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strCodeOfPracticeDispensationOS", 
      strQuestion: "Code Of Practice Dispensation", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
  
  ];
  }

  initCommsList(){

  commsList = [
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: null, 
      strQuestion: "Comms", textController: null,
      type: "header", isMandatory: true 
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strRemovedC", 
      strQuestion: "Removed", textController: TextEditingController(),
      type: "text" , isMandatory: true
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strAddressC", 
      strQuestion: "Address", textController: TextEditingController(),
      type: "text" , isMandatory: true
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strMethodC", 
      strQuestion: "Method", textController: TextEditingController(),
      type: "text" , isMandatory: true
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strBaudRateC", 
      strQuestion: "Baud Rate", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strDialInDialOutIndicatorC", 
      strQuestion: "Dial In Dial Out Indicator", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strProviderC", 
      strQuestion: "Provider", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
    
  ];
  }

  initPasswordList(){

  passwordList = [
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strPasswordsLevel1OS", 
      strQuestion: "Level1", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strPasswordsLevel2OS", 
      strQuestion: "Level2", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strPasswordsLevel3OS", 
      strQuestion: "Level3", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
  ];
  }

  initUserNameList(){
  
  usernameList = [
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strUsernamesLevel1OS", 
      strQuestion: "Level1", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strUsernamesLevel2OS", 
      strQuestion: "Level2", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strUsernamesLevel3OS", 
      strQuestion: "Level3", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
  ];
  }

  initSiteVisitList(){
  siteVisitList = [
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: null, 
      strQuestion: "Site Visit", textController: null,
      type: "header" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strSiteVisitCheckCode", 
      strQuestion: "Site Visit Check Code", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strSiteVisitStartDate", 
      strQuestion: "Site Visit Start Date", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strSiteVisitStartTime", 
      strQuestion: "Site Visit Start Time", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strSiteVisitEndDate", 
      strQuestion: "Site Visit End Date", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strSiteVisitEndTime", 
      strQuestion: "Site Visit End Time", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
  ];
  }

  initSupplyList(){

  supplyList = [
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: null, 
      strQuestion: "Supply", textController: null,
      type: "header" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strSupplyCapacity", 
      strQuestion: "Capacity", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strSupplyEnergisationStatus", 
      strQuestion: "Energisation Status", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strSupplyPhases", 
      strQuestion: "Phases", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strSupplyVoltage", 
      strQuestion: "Voltage", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
  ];


  }
}