import 'package:flutter/cupertino.dart';

class ElecCloseJobModel {
  int intAppointmentId;
  String strExternalJobReference;
  String strJumboId;
  String strMPAN;
  String strJumboJobType;
  String strAdditionalInformation;
  String strAssetCondition;
  String strAssetConditionReportDate;
  String strMSNSFC;
  String strMaxPowerRequirement;
  String strMeasurementClassId;
  String strReasonNotResolved;
  String strRemoteDisableEnableCapability;
  String strSSC;
  String strServiceLocation;
  String strSmartMeterInstallation;
  String strSpecialAccess;
  String strTariffCode;
  bool bitMeters;
  List<MeterList> meterList;
  bool bitOutStations;
  List<OutStationsList> outStationsList;
  bool bitSiteVisit;
  String strSiteVisitCheckCode;
  String strSiteVisitStartDate;
  String strSiteVisitStartTime;
  String strSiteVisitEndDate;
  String strSiteVisitEndTime;
  bool bitSupply;
  String strSupplyCapacity;
  String strSupplyEnergisationStatus;
  String strSupplyPhases;
  String strSupplyVoltage;

  ElecCloseJobModel(
      {this.intAppointmentId,
      this.strExternalJobReference,
      this.strJumboId,
      this.strMPAN,
      this.strJumboJobType,
      this.strAdditionalInformation,
      this.strAssetCondition,
      this.strAssetConditionReportDate,
      this.strMSNSFC,
      this.strMaxPowerRequirement,
      this.strMeasurementClassId,
      this.strReasonNotResolved,
      this.strRemoteDisableEnableCapability,
      this.strSSC,
      this.strServiceLocation,
      this.strSmartMeterInstallation,
      this.strSpecialAccess,
      this.strTariffCode,
      this.bitMeters,
      this.meterList,
      this.bitOutStations,
      this.outStationsList,
      this.bitSiteVisit,
      this.strSiteVisitCheckCode,
      this.strSiteVisitStartDate,
      this.strSiteVisitStartTime,
      this.strSiteVisitEndDate,
      this.strSiteVisitEndTime,
      this.bitSupply,
      this.strSupplyCapacity,
      this.strSupplyEnergisationStatus,
      this.strSupplyPhases,
      this.strSupplyVoltage});

  ElecCloseJobModel.fromJson(Map<String, dynamic> json) {
    intAppointmentId = json['intAppointmentId'];
    //intAppointmentId = 50251;
    strExternalJobReference = json['strExternalJobReference'];
    strJumboId = json['strJumboId'];
    strMPAN = json['strMPAN'];
    strJumboJobType = json['strJumboJobType'];
    strAdditionalInformation = json['strAdditionalInformation'];
    strAssetCondition = json['strAssetCondition'];
    strAssetConditionReportDate = json['strAssetConditionReportDate'];
    strMSNSFC = json['strMSNSFC'];
    strMaxPowerRequirement = json['strMaxPowerRequirement'];
    strMeasurementClassId = json['strMeasurementClassId'];
    strReasonNotResolved = json['strReasonNotResolved'];
    strRemoteDisableEnableCapability = json['strRemoteDisableEnableCapability'];
    strSSC = json['strSSC'];
    strServiceLocation = json['strServiceLocation'];
    strSmartMeterInstallation = json['strSmartMeterInstallation'];
    strSpecialAccess = json['strSpecialAccess'];
    strTariffCode = json['strTariffCode'];
    bitMeters = json['bitMeters'];
    if (json['meterList'] != null) {
      meterList = new List<MeterList>();
      json['meterList'].forEach((v) {
        meterList.add(new MeterList.fromJson(v));
      });
    }
    bitOutStations = json['bitOutStations'];
    if (json['outStationsList'] != null) {
      outStationsList = new List<OutStationsList>();
      json['outStationsList'].forEach((v) {
        outStationsList.add(new OutStationsList.fromJson(v));
      });
    }
    bitSiteVisit = json['bitSiteVisit'];
    strSiteVisitCheckCode = json['strSiteVisitCheckCode'];
    strSiteVisitStartDate = json['strSiteVisitStartDate'];
    strSiteVisitStartTime = json['strSiteVisitStartTime'];
    strSiteVisitEndDate = json['strSiteVisitEndDate'];
    strSiteVisitEndTime = json['strSiteVisitEndTime'];
    bitSupply = json['bitSupply'];
    strSupplyCapacity = json['strSupplyCapacity'];
    strSupplyEnergisationStatus = json['strSupplyEnergisationStatus'];
    strSupplyPhases = json['strSupplyPhases'];
    strSupplyVoltage = json['strSupplyVoltage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intAppointmentId'] = this.intAppointmentId;
    data['strExternalJobReference'] = this.strExternalJobReference;
    data['strJumboId'] = this.strJumboId;
    data['strMPAN'] = this.strMPAN;
    data['strJumboJobType'] = this.strJumboJobType;
    data['strAdditionalInformation'] = this.strAdditionalInformation;
    data['strAssetCondition'] = this.strAssetCondition;
    data['strAssetConditionReportDate'] = this.strAssetConditionReportDate;
    data['strMSNSFC'] = this.strMSNSFC;
    data['strMaxPowerRequirement'] = this.strMaxPowerRequirement;
    data['strMeasurementClassId'] = this.strMeasurementClassId;
    data['strReasonNotResolved'] = this.strReasonNotResolved;
    data['strRemoteDisableEnableCapability'] =
        this.strRemoteDisableEnableCapability;
    data['strSSC'] = this.strSSC;
    data['strServiceLocation'] = this.strServiceLocation;
    data['strSmartMeterInstallation'] = this.strSmartMeterInstallation;
    data['strSpecialAccess'] = this.strSpecialAccess;
    data['strTariffCode'] = this.strTariffCode;
    data['bitMeters'] = this.bitMeters;
    if (this.meterList != null) {
      data['meterList'] = this.meterList.map((v) => v.toJson()).toList();
    }
    data['bitOutStations'] = this.bitOutStations;
    if (this.outStationsList != null) {
      data['outStationsList'] =
          this.outStationsList.map((v) => v.toJson()).toList();
    }
    data['bitSiteVisit'] = this.bitSiteVisit;
    data['strSiteVisitCheckCode'] = this.strSiteVisitCheckCode;
    data['strSiteVisitStartDate'] = this.strSiteVisitStartDate;
    data['strSiteVisitStartTime'] = this.strSiteVisitStartTime;
    data['strSiteVisitEndDate'] = this.strSiteVisitEndDate;
    data['strSiteVisitEndTime'] = this.strSiteVisitEndTime;
    data['bitSupply'] = this.bitSupply;
    data['strSupplyCapacity'] = this.strSupplyCapacity;
    data['strSupplyEnergisationStatus'] = this.strSupplyEnergisationStatus;
    data['strSupplyPhases'] = this.strSupplyPhases;
    data['strSupplyVoltage'] = this.strSupplyVoltage;
    return data;
  }
}

class MeterList {
  String strSerialNumberM;
  String strCTRatioM;
  String strCertificationDateM;
  String strCertificationExpiryDateM;
  bool bitCodeOfPracticeM;
  String strCodeOfPracticeCodeM;
  String strCodeOfPracticeDispensationM;
  String strCodeOfPracticeIssueNumberM;
  String strCreditBalanceM;
  String strCurrentBalanceM;
  String strCurrentRatingM;
  String strDebtRecoveryRateM;
  String strEmergencyCreditM;
  String strEmergencyCreditOverrideM;
  String strEmergencyCreditStatusM;
  String strInitialCreditM;
  String strLocationM;
  String strMainOrCheckM;
  String strManufacturerAndModelM;
  String strRemovedM;
  String strRetrievalMethodM;
  String strRetrievalMethodEffectiveDateM;
  String strStandingChargeM;
  String strStandingChargeOverrideM;
  String strTimingDeviceSerialNumberM;
  String strTotalCreditAcceptedM;
  String strTotalDebtM;
  String strTotalDebtOutstandingM;
  String strTotalTokensInsertedM;
  String strTypeM;
  String strVTRatioM;
  List<RegisterList> registerList;

  MeterList(
      {this.strSerialNumberM,
      this.strCTRatioM,
      this.strCertificationDateM,
      this.strCertificationExpiryDateM,
      this.bitCodeOfPracticeM,
      this.strCodeOfPracticeCodeM,
      this.strCodeOfPracticeDispensationM,
      this.strCodeOfPracticeIssueNumberM,
      this.strCreditBalanceM,
      this.strCurrentBalanceM,
      this.strCurrentRatingM,
      this.strDebtRecoveryRateM,
      this.strEmergencyCreditM,
      this.strEmergencyCreditOverrideM,
      this.strEmergencyCreditStatusM,
      this.strInitialCreditM,
      this.strLocationM,
      this.strMainOrCheckM,
      this.strManufacturerAndModelM,
      this.strRemovedM,
      this.strRetrievalMethodM,
      this.strRetrievalMethodEffectiveDateM,
      this.strStandingChargeM,
      this.strStandingChargeOverrideM,
      this.strTimingDeviceSerialNumberM,
      this.strTotalCreditAcceptedM,
      this.strTotalDebtM,
      this.strTotalDebtOutstandingM,
      this.strTotalTokensInsertedM,
      this.strTypeM,
      this.strVTRatioM,
      this.registerList});

  MeterList.fromJson(Map<String, dynamic> json) {
    strSerialNumberM = json['strSerialNumberM'];
    strCTRatioM = json['strCTRatioM'];
    strCertificationDateM = json['strCertificationDateM'];
    strCertificationExpiryDateM = json['strCertificationExpiryDateM'];
    bitCodeOfPracticeM = json['bitCodeOfPracticeM'];
    strCodeOfPracticeCodeM = json['strCodeOfPracticeCodeM'];
    strCodeOfPracticeDispensationM = json['strCodeOfPracticeDispensationM'];
    strCodeOfPracticeIssueNumberM = json['strCodeOfPracticeIssueNumberM'];
    strCreditBalanceM = json['strCreditBalanceM'];
    strCurrentBalanceM = json['strCurrentBalanceM'];
    strCurrentRatingM = json['strCurrentRatingM'];
    strDebtRecoveryRateM = json['strDebtRecoveryRateM'];
    strEmergencyCreditM = json['strEmergencyCreditM'];
    strEmergencyCreditOverrideM = json['strEmergencyCreditOverrideM'];
    strEmergencyCreditStatusM = json['strEmergencyCreditStatusM'];
    strInitialCreditM = json['strInitialCreditM'];
    strLocationM = json['strLocationM'];
    strMainOrCheckM = json['strMainOrCheckM'];
    strManufacturerAndModelM = json['strManufacturerAndModelM'];
    strRemovedM = json['strRemovedM'];
    strRetrievalMethodM = json['strRetrievalMethodM'];
    strRetrievalMethodEffectiveDateM = json['strRetrievalMethodEffectiveDateM'];
    strStandingChargeM = json['strStandingChargeM'];
    strStandingChargeOverrideM = json['strStandingChargeOverrideM'];
    strTimingDeviceSerialNumberM = json['strTimingDeviceSerialNumberM'];
    strTotalCreditAcceptedM = json['strTotalCreditAcceptedM'];
    strTotalDebtM = json['strTotalDebtM'];
    strTotalDebtOutstandingM = json['strTotalDebtOutstandingM'];
    strTotalTokensInsertedM = json['strTotalTokensInsertedM'];
    strTypeM = json['strTypeM'];
    strVTRatioM = json['strVTRatioM'];
    if (json['registerList'] != null) {
      registerList = new List<RegisterList>();
      json['registerList'].forEach((v) {
        registerList.add(new RegisterList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['strSerialNumberM'] = this.strSerialNumberM;
    data['strCTRatioM'] = this.strCTRatioM;
    data['strCertificationDateM'] = this.strCertificationDateM;
    data['strCertificationExpiryDateM'] = this.strCertificationExpiryDateM;
    data['bitCodeOfPracticeM'] = this.bitCodeOfPracticeM;
    data['strCodeOfPracticeCodeM'] = this.strCodeOfPracticeCodeM;
    data['strCodeOfPracticeDispensationM'] =
        this.strCodeOfPracticeDispensationM;
    data['strCodeOfPracticeIssueNumberM'] = this.strCodeOfPracticeIssueNumberM;
    data['strCreditBalanceM'] = this.strCreditBalanceM;
    data['strCurrentBalanceM'] = this.strCurrentBalanceM;
    data['strCurrentRatingM'] = this.strCurrentRatingM;
    data['strDebtRecoveryRateM'] = this.strDebtRecoveryRateM;
    data['strEmergencyCreditM'] = this.strEmergencyCreditM;
    data['strEmergencyCreditOverrideM'] = this.strEmergencyCreditOverrideM;
    data['strEmergencyCreditStatusM'] = this.strEmergencyCreditStatusM;
    data['strInitialCreditM'] = this.strInitialCreditM;
    data['strLocationM'] = this.strLocationM;
    data['strMainOrCheckM'] = this.strMainOrCheckM;
    data['strManufacturerAndModelM'] = this.strManufacturerAndModelM;
    data['strRemovedM'] = this.strRemovedM;
    data['strRetrievalMethodM'] = this.strRetrievalMethodM;
    data['strRetrievalMethodEffectiveDateM'] =
        this.strRetrievalMethodEffectiveDateM;
    data['strStandingChargeM'] = this.strStandingChargeM;
    data['strStandingChargeOverrideM'] = this.strStandingChargeOverrideM;
    data['strTimingDeviceSerialNumberM'] = this.strTimingDeviceSerialNumberM;
    data['strTotalCreditAcceptedM'] = this.strTotalCreditAcceptedM;
    data['strTotalDebtM'] = this.strTotalDebtM;
    data['strTotalDebtOutstandingM'] = this.strTotalDebtOutstandingM;
    data['strTotalTokensInsertedM'] = this.strTotalTokensInsertedM;
    data['strTypeM'] = this.strTypeM;
    data['strVTRatioM'] = this.strVTRatioM;
    if (this.registerList != null) {
      data['registerList'] = this.registerList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RegisterList {
  String strIdR;
  String strRemovedR;
  String strAssociatedMeterIdR;
  String strAssociatedRegisterIdR;
  String strChannelNumberR;
  String strDescriptionR;
  String strMeasurementQuantityIdR;
  String strMeterMemoryLocationR;
  String strMeterMemoryLocationTypeR;
  String strMultiplierR;
  String strNumberOfDigitsR;
  String strPulseMultiplierR;
  String strPrepayUnitRateR;
  String strTimestampMeterMemoryLocationR;
  String strTypeR;
  bool bitReading;
  String strReadingFlagR;
  String strReadingTypeR;
  String strReadingValueR;
  bool bitRegimes;
  String strTimePatternRegimeCode1R;
  String strTimePatternRegimeCode2R;
  String strRegisterMappingCoefficient1R;
  String strRegisterMappingCoefficient2R;

  RegisterList(
      {this.strIdR,
      this.strRemovedR,
      this.strAssociatedMeterIdR,
      this.strAssociatedRegisterIdR,
      this.strChannelNumberR,
      this.strDescriptionR,
      this.strMeasurementQuantityIdR,
      this.strMeterMemoryLocationR,
      this.strMeterMemoryLocationTypeR,
      this.strMultiplierR,
      this.strNumberOfDigitsR,
      this.strPulseMultiplierR,
      this.strPrepayUnitRateR,
      this.strTimestampMeterMemoryLocationR,
      this.strTypeR,
      this.bitReading,
      this.strReadingFlagR,
      this.strReadingTypeR,
      this.strReadingValueR,
      this.bitRegimes,
      this.strTimePatternRegimeCode1R,
      this.strTimePatternRegimeCode2R,
      this.strRegisterMappingCoefficient1R,
      this.strRegisterMappingCoefficient2R});

  RegisterList.fromJson(Map<String, dynamic> json) {
    strIdR = json['strIdR'];
    strRemovedR = json['strRemovedR'];
    strAssociatedMeterIdR = json['strAssociatedMeterIdR'];
    strAssociatedRegisterIdR = json['strAssociatedRegisterIdR'];
    strChannelNumberR = json['strChannelNumberR'];
    strDescriptionR = json['strDescriptionR'];
    strMeasurementQuantityIdR = json['strMeasurementQuantityIdR'];
    strMeterMemoryLocationR = json['strMeterMemoryLocationR'];
    strMeterMemoryLocationTypeR = json['strMeterMemoryLocationTypeR'];
    strMultiplierR = json['strMultiplierR'];
    strNumberOfDigitsR = json['strNumberOfDigitsR'];
    strPulseMultiplierR = json['strPulseMultiplierR'];
    strPrepayUnitRateR = json['strPrepayUnitRateR'];
    strTimestampMeterMemoryLocationR = json['strTimestampMeterMemoryLocationR'];
    strTypeR = json['strTypeR'];
    bitReading = json['bitReading'];
    strReadingFlagR = json['strReadingFlagR'];
    strReadingTypeR = json['strReadingTypeR'];
    strReadingValueR = json['strReadingValueR'];
    bitRegimes = json['bitRegimes'];
    strTimePatternRegimeCode1R = json['strTimePatternRegimeCode1R'];
    strTimePatternRegimeCode2R = json['strTimePatternRegimeCode2R'];
    strRegisterMappingCoefficient1R = json['strRegisterMappingCoefficient1R'];
    strRegisterMappingCoefficient2R = json['strRegisterMappingCoefficient2R'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['strIdR'] = this.strIdR;
    data['strRemovedR'] = this.strRemovedR;
    data['strAssociatedMeterIdR'] = this.strAssociatedMeterIdR;
    data['strAssociatedRegisterIdR'] = this.strAssociatedRegisterIdR;
    data['strChannelNumberR'] = this.strChannelNumberR;
    data['strDescriptionR'] = this.strDescriptionR;
    data['strMeasurementQuantityIdR'] = this.strMeasurementQuantityIdR;
    data['strMeterMemoryLocationR'] = this.strMeterMemoryLocationR;
    data['strMeterMemoryLocationTypeR'] = this.strMeterMemoryLocationTypeR;
    data['strMultiplierR'] = this.strMultiplierR;
    data['strNumberOfDigitsR'] = this.strNumberOfDigitsR;
    data['strPulseMultiplierR'] = this.strPulseMultiplierR;
    data['strPrepayUnitRateR'] = this.strPrepayUnitRateR;
    data['strTimestampMeterMemoryLocationR'] =
        this.strTimestampMeterMemoryLocationR;
    data['strTypeR'] = this.strTypeR;
    data['bitReading'] = this.bitReading;
    data['strReadingFlagR'] = this.strReadingFlagR;
    data['strReadingTypeR'] = this.strReadingTypeR;
    data['strReadingValueR'] = this.strReadingValueR;
    data['bitRegimes'] = this.bitRegimes;
    data['strTimePatternRegimeCode1R'] = this.strTimePatternRegimeCode1R;
    data['strTimePatternRegimeCode2R'] = this.strTimePatternRegimeCode2R;
    data['strRegisterMappingCoefficient1R'] =
        this.strRegisterMappingCoefficient1R;
    data['strRegisterMappingCoefficient2R'] =
        this.strRegisterMappingCoefficient2R;
    return data;
  }
}

class OutStationsList {
  String strIdOS;
  String strRemovedOS;
  bool bitCodeOfPracticeOS;
  String strCodeOfPracticeCodeOS;
  String strCodeOfPracticeDispensationOS;
  String strEncryptionkeyOS;
  String strMultiplierOS;
  String strNumberOfChannelsOS;
  String strNumberOfDigitsOS;
  bool bitPasswordsOS;
  String strPasswordsLevel1OS;
  String strPasswordsLevel2OS;
  String strPasswordsLevel3OS;
  String strPinOS;
  String strTypeOS;
  bool bitUsernamesOS;
  String strUsernamesLevel1OS;
  String strUsernamesLevel2OS;
  String strUsernamesLevel3OS;
  List<CommsList> commsList;

  OutStationsList(
      {this.strIdOS,
      this.strRemovedOS,
      this.bitCodeOfPracticeOS,
      this.strCodeOfPracticeCodeOS,
      this.strCodeOfPracticeDispensationOS,
      this.strEncryptionkeyOS,
      this.strMultiplierOS,
      this.strNumberOfChannelsOS,
      this.strNumberOfDigitsOS,
      this.bitPasswordsOS,
      this.strPasswordsLevel1OS,
      this.strPasswordsLevel2OS,
      this.strPasswordsLevel3OS,
      this.strPinOS,
      this.strTypeOS,
      this.bitUsernamesOS,
      this.strUsernamesLevel1OS,
      this.strUsernamesLevel2OS,
      this.strUsernamesLevel3OS,
      this.commsList});

  OutStationsList.fromJson(Map<String, dynamic> json) {
    strIdOS = json['strIdOS'];
    strRemovedOS = json['strRemovedOS'];
    bitCodeOfPracticeOS = json['bitCodeOfPracticeOS'];
    strCodeOfPracticeCodeOS = json['strCodeOfPracticeCodeOS'];
    strCodeOfPracticeDispensationOS = json['strCodeOfPracticeDispensationOS'];
    strEncryptionkeyOS = json['strEncryptionkeyOS'];
    strMultiplierOS = json['strMultiplierOS'];
    strNumberOfChannelsOS = json['strNumberOfChannelsOS'];
    strNumberOfDigitsOS = json['strNumberOfDigitsOS'];
    bitPasswordsOS = json['bitPasswordsOS'];
    strPasswordsLevel1OS = json['strPasswordsLevel1OS'];
    strPasswordsLevel2OS = json['strPasswordsLevel2OS'];
    strPasswordsLevel3OS = json['strPasswordsLevel3OS'];
    strPinOS = json['strPinOS'];
    strTypeOS = json['strTypeOS'];
    bitUsernamesOS = json['bitUsernamesOS'];
    strUsernamesLevel1OS = json['strUsernamesLevel1OS'];
    strUsernamesLevel2OS = json['strUsernamesLevel2OS'];
    strUsernamesLevel3OS = json['strUsernamesLevel3OS'];
    if (json['commsList'] != null) {
      commsList = new List<CommsList>();
      json['commsList'].forEach((v) {
        commsList.add(new CommsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['strIdOS'] = this.strIdOS;
    data['strRemovedOS'] = this.strRemovedOS;
    data['bitCodeOfPracticeOS'] = this.bitCodeOfPracticeOS;
    data['strCodeOfPracticeCodeOS'] = this.strCodeOfPracticeCodeOS;
    data['strCodeOfPracticeDispensationOS'] =
        this.strCodeOfPracticeDispensationOS;
    data['strEncryptionkeyOS'] = this.strEncryptionkeyOS;
    data['strMultiplierOS'] = this.strMultiplierOS;
    data['strNumberOfChannelsOS'] = this.strNumberOfChannelsOS;
    data['strNumberOfDigitsOS'] = this.strNumberOfDigitsOS;
    data['bitPasswordsOS'] = this.bitPasswordsOS;
    data['strPasswordsLevel1OS'] = this.strPasswordsLevel1OS;
    data['strPasswordsLevel2OS'] = this.strPasswordsLevel2OS;
    data['strPasswordsLevel3OS'] = this.strPasswordsLevel3OS;
    data['strPinOS'] = this.strPinOS;
    data['strTypeOS'] = this.strTypeOS;
    data['bitUsernamesOS'] = this.bitUsernamesOS;
    data['strUsernamesLevel1OS'] = this.strUsernamesLevel1OS;
    data['strUsernamesLevel2OS'] = this.strUsernamesLevel2OS;
    data['strUsernamesLevel3OS'] = this.strUsernamesLevel3OS;
    if (this.commsList != null) {
      data['commsList'] = this.commsList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CommsList {
  String strRemovedC;
  String strAddressC;
  String strMethodC;
  String strBaudRateC;
  String strDialInDialOutIndicatorC;
  String strProviderC;

  CommsList(
      {this.strRemovedC,
      this.strAddressC,
      this.strMethodC,
      this.strBaudRateC,
      this.strDialInDialOutIndicatorC,
      this.strProviderC});

  CommsList.fromJson(Map<String, dynamic> json) {
    strRemovedC = json['strRemovedC'];
    strAddressC = json['strAddressC'];
    strMethodC = json['strMethodC'];
    strBaudRateC = json['strBaudRateC'];
    strDialInDialOutIndicatorC = json['strDialInDialOutIndicatorC'];
    strProviderC = json['strProviderC'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['strRemovedC'] = this.strRemovedC;
    data['strAddressC'] = this.strAddressC;
    data['strMethodC'] = this.strMethodC;
    data['strBaudRateC'] = this.strBaudRateC;
    data['strDialInDialOutIndicatorC'] = this.strDialInDialOutIndicatorC;
    data['strProviderC'] = this.strProviderC;
    return data;
  }
}


class CloseJobQuestionModel {
  String strQuestion;
  String jsonfield;
  String type;
  TextEditingController textController;
  bool checkBoxVal;
  bool isMandatory;

  CloseJobQuestionModel({
    this.strQuestion,
    this.jsonfield,
    this.type,
    this.textController,
    this.checkBoxVal,
    this.isMandatory
  });

}


class CheckCloseJobModel {
  List<CheckTable> table;

  CheckCloseJobModel({this.table});

  CheckCloseJobModel.fromJson(Map<String, dynamic> json) {
    if (json['table'] != null) {
      table = new List<CheckTable>();
      json['table'].forEach((v) {
        table.add(new CheckTable.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.table != null) {
      data['table'] = this.table.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CheckTable {
  int intId;
  String strMpan;
  String strFuel;
  int intJumboRequestid;
  String strSSC;
  int intJumboResponseid;
  String electricityMSN;
  String gasMSN;

  CheckTable(
      {this.intId,
      this.strMpan,
      this.strFuel,
      this.intJumboRequestid,
      this.strSSC,
      this.intJumboResponseid,
      this.electricityMSN,
      this.gasMSN});

  CheckTable.fromJson(Map<String, dynamic> json) {
    intId = json['intId'];
    strMpan = json['strMpan'];
    strFuel = json['strFuel'];
    intJumboRequestid = json['intJumboRequestid'];
    strSSC = json['strSSC'];
    intJumboResponseid = json['intJumboResponseid'];
    electricityMSN = json['electricityMSN'];
    gasMSN = json['gasMSN'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intId'] = this.intId;
    data['strMpan'] = this.strMpan;
    data['strFuel'] = this.strFuel;
    data['intJumboRequestid'] = this.intJumboRequestid;
    data['strSSC'] = this.strSSC;
    data['intJumboResponseid'] = this.intJumboResponseid;
    data['electricityMSN'] = this.electricityMSN;
    data['gasMSN'] = this.gasMSN;
    return data;
  }
}
