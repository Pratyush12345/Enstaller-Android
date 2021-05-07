import 'package:connectivity/connectivity.dart';
import 'package:enstaller/core/model/elec_closejob_model.dart';
import 'package:flutter/cupertino.dart';

class GasJobViewModel {
  GasJobViewModel.meterList(){
   initmeterList();
  }
  GasJobViewModel.registerList(){
    initregisterList();
  }
  GasJobViewModel.converterList(){
    initconvertersList();
  }

  static GasJobViewModel instance = GasJobViewModel._();
  GasJobViewModel._();
  List<CloseJobQuestionModel> addGasCloseJobList = [];
  List<CloseJobQuestionModel> meterList = [];
  int meterCount;
  List<CloseJobQuestionModel> registerList = [];
  List<CloseJobQuestionModel> convertersList = [];
  List<CloseJobQuestionModel> siteVisitList = [];
  List<CloseJobQuestionModel> transactionList = [];
  List<Widget> list;
  GlobalKey<FormState> formKey;
  Map<int, List<CloseJobQuestionModel>> metermap;
  Map<int, Map<int, List<CloseJobQuestionModel>>>registermap;
  Map<int, Map<int, List<CloseJobQuestionModel>>> convertersmap;
  Map<int, int> registerCount;
  Map<int, int> converterCount;
  final Connectivity connectivity = Connectivity();
  bool showIndicator = false;
  DateTime startDate;
  DateTime endDate; 
 
 initVariable(List<CheckTable> listw){
    list = [];
    metermap = {};
    registermap = {};
    convertersmap = {};
    registerCount = {};
    converterCount = {};
    
    formKey = GlobalKey<FormState>();
    try{
    CheckTable checkTable = listw.firstWhere((element) => element.strFuel.toString() == "GAS");
    GasJobViewModel.instance.initialize(checkTable);
    }catch(e){
     GasJobViewModel.instance.initialize(listw[0]);
      
    }
  
 }
  initialize(CheckTable checkTable ){
    initaddCLoseJob(checkTable);
    meterCount = 0;
    initmeterList();
    initregisterList();
    initconvertersList();
    initSiteVisitList();
    initTransactionList();
  }

  initaddCLoseJob(CheckTable checkTable){
   addGasCloseJobList = [
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: null, 
      strQuestion: "Add Gas Close Job", textController: null,
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
      checkBoxVal: null, jsonfield: "strMPRN", 
      strQuestion: "MPRN", textController: TextEditingController()..text = checkTable.strMpan??"",
      type: "text" , isMandatory: true
    ),
      CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strJumboJobType", 
      strQuestion: "Jumbo Job Type", textController: TextEditingController(),
      type: "text", isMandatory: false 
    ),
      CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strSupplierMarketParticipantId", 
      strQuestion: "Supplier Market Participant Id", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
      CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strConversionFactor", 
      strQuestion: "Conversion Factor", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
      CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strFieldWorkerNotes", 
      strQuestion: "Field Worker Notes", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
      CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strLocation", 
      strQuestion: "Location", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
      CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strLocationNotes", 
      strQuestion: "Location Notes", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
      CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strMeterLink", 
      strQuestion: "Meter Link", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
      CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strMeterPointStatus", 
      strQuestion: "Meter Point Status", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
      CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strMeteringPressure", 
      strQuestion: "Metering Pressure", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
     CloseJobQuestionModel(
      checkBoxVal: false, jsonfield: "bitMeters", 
      strQuestion: "Meters", textController: null,
      type: "checkBox" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: null, 
      strQuestion: "Site Visit", textController: null,
      type: "header", isMandatory: false 
    ),
    CloseJobQuestionModel(
      checkBoxVal: false, jsonfield: "bitTransaction", 
      strQuestion: "Transaction", textController: null,
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
      checkBoxVal: null, jsonfield: "strRemovedM", 
      strQuestion: "Removed", textController: TextEditingController(),
      type: "text" , isMandatory: true
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strCollarStatusM", 
      strQuestion: "Collar Status", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strLocationM", 
      strQuestion: "Location", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strLocationNotesM", 
      strQuestion: "Location Notes", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strManufacturerM", 
      strQuestion: "Manufacturer", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strMeasuringCapacityM", 
      strQuestion: "Measuring Capacity", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strMechanismM", 
      strQuestion: "Mechanism", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strModelM", 
      strQuestion: "Model", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strOwnerMarketParticipantIdM", 
      strQuestion: "Owner Market Participant Id", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strPaymentMethodM", 
      strQuestion: "Payment Method", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strPulseValueM", 
      strQuestion: "Pulse Value", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strStatusM", 
      strQuestion: "Status", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strTypeM", 
      strQuestion: "Type", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strUsageM", 
      strQuestion: "Usage", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strYearOfManufactureM", 
      strQuestion: "Year Of Manufacture", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: true, jsonfield: null, 
      strQuestion: "Register", textController: null,
      type: "checkBox" , isMandatory: true
    ),
    CloseJobQuestionModel(
      checkBoxVal: false, jsonfield: "bitConverters", 
      strQuestion: "Converters", textController: null,
      type: "checkBox" , isMandatory: false
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
      checkBoxVal: null, jsonfield: "strRemovedR", 
      strQuestion: "Removed", textController: TextEditingController(),
      type: "text" , isMandatory: true
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strMultiplicationFactorR", 
      strQuestion: "Multiplication Factor", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strNumberOfDigitsR", 
      strQuestion: "Number Of Digits", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strReadingR", 
      strQuestion: "Reading", textController: TextEditingController(),
      type: "text" , isMandatory: true
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strUnitsOfMeasureR", 
      strQuestion: "Units Of Measure", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
  ];
  }  
  
  initconvertersList(){

  convertersList = [
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: null, 
      strQuestion: "Converters", textController: null,
      type: "header", isMandatory: true 
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strSerialNumberC", 
      strQuestion: "Serial Number", textController: TextEditingController(),
      type: "text" , isMandatory: true
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strAssetClassC", 
      strQuestion: "Asset Class", textController: TextEditingController(),
      type: "text" , isMandatory: true
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strAssetProvAbbrevNameC", 
      strQuestion: "Asset Prov Abbrev Name", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strAssetStatusC", 
      strQuestion: "Asset Status", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strConversionBasisC", 
      strQuestion: "Conversion Basis", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strConversionFactorC", 
      strQuestion: "Conversion Factor", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strLocationC", 
      strQuestion: "Location", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strLocationNotesC", 
      strQuestion: "Location Notes", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strManufacturerC", 
      strQuestion: "rManufacturer", textController: TextEditingController(),
      type: "text" , isMandatory: false
    )
    ,CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strModelC", 
      strQuestion: "Model", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strPaymentMethodC", 
      strQuestion: "Payment Method", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strProductIdC", 
      strQuestion: "Product Id", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strYearOfManufactureC", 
      strQuestion: "Year Of Manufacture", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
  ];
  }  

  initSiteVisitList(){

  siteVisitList = [
    
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strSiteVisitStartDate", 
      strQuestion: "Start Date", textController: TextEditingController(),
      type: "text" , isMandatory: true
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strSiteVisitStartTime", 
      strQuestion: "Start Time", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strSiteVisitEndDate", 
      strQuestion: "End Date", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strSiteVisitEndTime", 
      strQuestion: "End Time", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
  ];
  }

  initTransactionList(){

  transactionList = [
    CloseJobQuestionModel(
      checkBoxVal: false, jsonfield: null, 
      strQuestion: "Transaction", textController: null,
      type: "header" , isMandatory: false
    ),
    
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strTransactionComment", 
      strQuestion: "Comment", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strTransactionStatus", 
      strQuestion: "Status", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
    CloseJobQuestionModel(
      checkBoxVal: null, jsonfield: "strStatusChangeReason", 
      strQuestion: "Status Change Reason", textController: TextEditingController(),
      type: "text" , isMandatory: false
    ),
    
  ];
  }

}