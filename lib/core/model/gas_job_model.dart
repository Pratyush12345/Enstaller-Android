class GasCloseJobModel {
  int intAppointmentId;
  String strExternalJobReference;
  String strJumboId;
  String strMPRN;
  String strJumboJobType;
  String strSupplierMarketParticipantId;
  String strConversionFactor;
  String strFieldWorkerNotes;
  String strLocation;
  String strLocationNotes;
  String strMeterLink;
  String strMeterPointStatus;
  String strMeteringPressure;
  String strSiteVisitStartDate;
  String strSiteVisitStartTime;
  String strSiteVisitEndDate;
  String strSiteVisitEndTime;
  bool bitTransaction;
  String strTransactionComment;
  String strTransactionStatus;
  String strStatusChangeReason;
  bool bitMeters;
  List<MeterList> meterList;

  GasCloseJobModel(
      {this.intAppointmentId,
      this.strExternalJobReference,
      this.strJumboId,
      this.strMPRN,
      this.strJumboJobType,
      this.strSupplierMarketParticipantId,
      this.strConversionFactor,
      this.strFieldWorkerNotes,
      this.strLocation,
      this.strLocationNotes,
      this.strMeterLink,
      this.strMeterPointStatus,
      this.strMeteringPressure,
      this.strSiteVisitStartDate,
      this.strSiteVisitStartTime,
      this.strSiteVisitEndDate,
      this.strSiteVisitEndTime,
      this.bitTransaction,
      this.strTransactionComment,
      this.strTransactionStatus,
      this.strStatusChangeReason,
      this.bitMeters,
      this.meterList});

  GasCloseJobModel.fromJson(Map<String, dynamic> json) {
    intAppointmentId = json['intAppointmentId'];
    strExternalJobReference = json['strExternalJobReference'];
    strJumboId = json['strJumboId'];
    strMPRN = json['strMPRN'];
    strJumboJobType = json['strJumboJobType'];
    strSupplierMarketParticipantId = json['strSupplierMarketParticipantId'];
    strConversionFactor = json['strConversionFactor'];
    strFieldWorkerNotes = json['strFieldWorkerNotes'];
    strLocation = json['strLocation'];
    strLocationNotes = json['strLocationNotes'];
    strMeterLink = json['strMeterLink'];
    strMeterPointStatus = json['strMeterPointStatus'];
    strMeteringPressure = json['strMeteringPressure'];
    strSiteVisitStartDate = json['strSiteVisitStartDate'];
    strSiteVisitStartTime = json['strSiteVisitStartTime'];
    strSiteVisitEndDate = json['strSiteVisitEndDate'];
    strSiteVisitEndTime = json['strSiteVisitEndTime'];
    bitTransaction = json['bitTransaction'];
    strTransactionComment = json['strTransactionComment'];
    strTransactionStatus = json['strTransactionStatus'];
    strStatusChangeReason = json['strStatusChangeReason'];
    bitMeters = json['bitMeters'];
    if (json['meterList'] != null) {
      meterList = new List<MeterList>();
      json['meterList'].forEach((v) {
        meterList.add(new MeterList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intAppointmentId'] = this.intAppointmentId;
    data['strExternalJobReference'] = this.strExternalJobReference;
    data['strJumboId'] = this.strJumboId;
    data['strMPRN'] = this.strMPRN;
    data['strJumboJobType'] = this.strJumboJobType;
    data['strSupplierMarketParticipantId'] =
        this.strSupplierMarketParticipantId;
    data['strConversionFactor'] = this.strConversionFactor;
    data['strFieldWorkerNotes'] = this.strFieldWorkerNotes;
    data['strLocation'] = this.strLocation;
    data['strLocationNotes'] = this.strLocationNotes;
    data['strMeterLink'] = this.strMeterLink;
    data['strMeterPointStatus'] = this.strMeterPointStatus;
    data['strMeteringPressure'] = this.strMeteringPressure;
    data['strSiteVisitStartDate'] = this.strSiteVisitStartDate;
    data['strSiteVisitStartTime'] = this.strSiteVisitStartTime;
    data['strSiteVisitEndDate'] = this.strSiteVisitEndDate;
    data['strSiteVisitEndTime'] = this.strSiteVisitEndTime;
    data['bitTransaction'] = this.bitTransaction;
    data['strTransactionComment'] = this.strTransactionComment;
    data['strTransactionStatus'] = this.strTransactionStatus;
    data['strStatusChangeReason'] = this.strStatusChangeReason;
    data['bitMeters'] = this.bitMeters;
    if (this.meterList != null) {
      data['meterList'] = this.meterList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MeterList {
  String strSerialNumberM;
  String strRemovedM;
  String strCollarStatusM;
  String strLocationM;
  String strLocationNotesM;
  bool bitConverters;
  String strManufacturerM;
  String strMeasuringCapacityM;
  String strMechanismM;
  String strModelM;
  String strOwnerMarketParticipantIdM;
  String strPaymentMethodM;
  String strPulseValueM;
  String strStatusM;
  String strTypeM;
  String strUsageM;
  String strYearOfManufactureM;
  List<RegisterList> registerList;
  List<ConverterList> converterList;

  MeterList(
      {this.strSerialNumberM,
      this.strRemovedM,
      this.strCollarStatusM,
      this.strLocationM,
      this.strLocationNotesM,
      this.bitConverters,
      this.strManufacturerM,
      this.strMeasuringCapacityM,
      this.strMechanismM,
      this.strModelM,
      this.strOwnerMarketParticipantIdM,
      this.strPaymentMethodM,
      this.strPulseValueM,
      this.strStatusM,
      this.strTypeM,
      this.strUsageM,
      this.strYearOfManufactureM,
      this.registerList,
      this.converterList});

  MeterList.fromJson(Map<String, dynamic> json) {
    strSerialNumberM = json['strSerialNumberM'];
    strRemovedM = json['strRemovedM'];
    strCollarStatusM = json['strCollarStatusM'];
    strLocationM = json['strLocationM'];
    strLocationNotesM = json['strLocationNotesM'];
    bitConverters = json['bitConverters'];
    strManufacturerM = json['strManufacturerM'];
    strMeasuringCapacityM = json['strMeasuringCapacityM'];
    strMechanismM = json['strMechanismM'];
    strModelM = json['strModelM'];
    strOwnerMarketParticipantIdM = json['strOwnerMarketParticipantIdM'];
    strPaymentMethodM = json['strPaymentMethodM'];
    strPulseValueM = json['strPulseValueM'];
    strStatusM = json['strStatusM'];
    strTypeM = json['strTypeM'];
    strUsageM = json['strUsageM'];
    strYearOfManufactureM = json['strYearOfManufactureM'];
    if (json['registerList'] != null) {
      registerList = new List<RegisterList>();
      json['registerList'].forEach((v) {
        registerList.add(new RegisterList.fromJson(v));
      });
    }
    if (json['converterList'] != null) {
      converterList = new List<ConverterList>();
      json['converterList'].forEach((v) {
        converterList.add(new ConverterList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['strSerialNumberM'] = this.strSerialNumberM;
    data['strRemovedM'] = this.strRemovedM;
    data['strCollarStatusM'] = this.strCollarStatusM;
    data['strLocationM'] = this.strLocationM;
    data['strLocationNotesM'] = this.strLocationNotesM;
    data['bitConverters'] = this.bitConverters;
    data['strManufacturerM'] = this.strManufacturerM;
    data['strMeasuringCapacityM'] = this.strMeasuringCapacityM;
    data['strMechanismM'] = this.strMechanismM;
    data['strModelM'] = this.strModelM;
    data['strOwnerMarketParticipantIdM'] = this.strOwnerMarketParticipantIdM;
    data['strPaymentMethodM'] = this.strPaymentMethodM;
    data['strPulseValueM'] = this.strPulseValueM;
    data['strStatusM'] = this.strStatusM;
    data['strTypeM'] = this.strTypeM;
    data['strUsageM'] = this.strUsageM;
    data['strYearOfManufactureM'] = this.strYearOfManufactureM;
    if (this.registerList != null) {
      data['registerList'] = this.registerList.map((v) => v.toJson()).toList();
    }
    if (this.converterList != null) {
      data['converterList'] =
          this.converterList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RegisterList {
  String strRemovedR;
  String strMultiplicationFactorR;
  String strNumberOfDigitsR;
  String strReadingR;
  String strUnitsOfMeasureR;

  RegisterList(
      {this.strRemovedR,
      this.strMultiplicationFactorR,
      this.strNumberOfDigitsR,
      this.strReadingR,
      this.strUnitsOfMeasureR});

  RegisterList.fromJson(Map<String, dynamic> json) {
    strRemovedR = json['strRemovedR'];
    strMultiplicationFactorR = json['strMultiplicationFactorR'];
    strNumberOfDigitsR = json['strNumberOfDigitsR'];
    strReadingR = json['strReadingR'];
    strUnitsOfMeasureR = json['strUnitsOfMeasureR'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['strRemovedR'] = this.strRemovedR;
    data['strMultiplicationFactorR'] = this.strMultiplicationFactorR;
    data['strNumberOfDigitsR'] = this.strNumberOfDigitsR;
    data['strReadingR'] = this.strReadingR;
    data['strUnitsOfMeasureR'] = this.strUnitsOfMeasureR;
    return data;
  }
}

class ConverterList {
  String strSerialNumberC;
  String strAssetClassC;
  String strAssetProvAbbrevNameC;
  String strAssetStatusC;
  String strConversionBasisC;
  String strConversionFactorC;
  String strLocationC;
  String strLocationNotesC;
  String strManufacturerC;
  String strModelC;
  String strPaymentMethodC;
  String strProductIdC;
  String strYearOfManufactureC;

  ConverterList(
      {this.strSerialNumberC,
      this.strAssetClassC,
      this.strAssetProvAbbrevNameC,
      this.strAssetStatusC,
      this.strConversionBasisC,
      this.strConversionFactorC,
      this.strLocationC,
      this.strLocationNotesC,
      this.strManufacturerC,
      this.strModelC,
      this.strPaymentMethodC,
      this.strProductIdC,
      this.strYearOfManufactureC});

  ConverterList.fromJson(Map<String, dynamic> json) {
    strSerialNumberC = json['strSerialNumberC'];
    strAssetClassC = json['strAssetClassC'];
    strAssetProvAbbrevNameC = json['strAssetProvAbbrevNameC'];
    strAssetStatusC = json['strAssetStatusC'];
    strConversionBasisC = json['strConversionBasisC'];
    strConversionFactorC = json['strConversionFactorC'];
    strLocationC = json['strLocationC'];
    strLocationNotesC = json['strLocationNotesC'];
    strManufacturerC = json['strManufacturerC'];
    strModelC = json['strModelC'];
    strPaymentMethodC = json['strPaymentMethodC'];
    strProductIdC = json['strProductIdC'];
    strYearOfManufactureC = json['strYearOfManufactureC'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['strSerialNumberC'] = this.strSerialNumberC;
    data['strAssetClassC'] = this.strAssetClassC;
    data['strAssetProvAbbrevNameC'] = this.strAssetProvAbbrevNameC;
    data['strAssetStatusC'] = this.strAssetStatusC;
    data['strConversionBasisC'] = this.strConversionBasisC;
    data['strConversionFactorC'] = this.strConversionFactorC;
    data['strLocationC'] = this.strLocationC;
    data['strLocationNotesC'] = this.strLocationNotesC;
    data['strManufacturerC'] = this.strManufacturerC;
    data['strModelC'] = this.strModelC;
    data['strPaymentMethodC'] = this.strPaymentMethodC;
    data['strProductIdC'] = this.strProductIdC;
    data['strYearOfManufactureC'] = this.strYearOfManufactureC;
    return data;
  }
}
