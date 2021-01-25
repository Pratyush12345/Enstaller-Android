import 'package:enstaller/core/constant/app_string.dart';

class StatusModel {
  int intId;
  String strAppointmentType;
  String strJobType;
  String dteBookedDate;
  String strBookedTime;
  String strSiteAddress;
  String strSiteDateConsent;
  String strSiteCustomerPassword;
  String strSiteCustomerComment;
  int intTimeOnSite;
  String strComment;
  String strBookingReference;
  String strStatus;
  String strBookingStatusType;
  String dteCreatedDate;
  int intPriority;
  int intBookedBy;
  bool bisCustomerConfirmed;
  String dteCustomerConfirmedDate;
  int intCustomerId;
  int intSupplierId;
  String strBookedSlotType;
  String strContactName;
  String strCompanyName;
  String strLogo;
  Null dteCreatedDateStr;
  int intEngineerId;
  String engineerName;
  String strPostCode;
  Null regionPatches;
  String patchCode;
  String strBookedBy;
  String appointmentEventType;
  String customerName;
  int intTimeSlotId;
  int intAppointmentEventId;
  String dteCapturedAt;

  StatusModel(
      {this.intId,
        this.strAppointmentType,
        this.strJobType,
        this.dteBookedDate,
        this.strBookedTime,
        this.strSiteAddress,
        this.strSiteDateConsent,
        this.strSiteCustomerPassword,
        this.strSiteCustomerComment,
        this.intTimeOnSite,
        this.strComment,
        this.strBookingReference,
        this.strStatus,
        this.strBookingStatusType,
        this.dteCreatedDate,
        this.intPriority,
        this.intBookedBy,
        this.bisCustomerConfirmed,
        this.dteCustomerConfirmedDate,
        this.intCustomerId,
        this.intSupplierId,
        this.strBookedSlotType,
        this.strContactName,
        this.strCompanyName,
        this.strLogo,
        this.dteCreatedDateStr,
        this.intEngineerId,
        this.engineerName,
        this.strPostCode,
        this.regionPatches,
        this.patchCode,
        this.strBookedBy,
        this.appointmentEventType,
        this.customerName,
        this.intTimeSlotId,
        this.intAppointmentEventId,
        this.dteCapturedAt});

  StatusModel.fromJson(Map<String, dynamic> json) {
    intId = json['intId'];
    strAppointmentType = json['strAppointmentType'];
    strJobType = json['strJobType'];
    dteBookedDate = json['dteBookedDate'];
    strBookedTime = json['strBookedTime'];
    strSiteAddress = json['strSiteAddress'];
    strSiteDateConsent = json['strSiteDateConsent'];
    strSiteCustomerPassword = json['strSiteCustomerPassword'];
    strSiteCustomerComment = json['strSiteCustomerComment'];
    intTimeOnSite = json['intTimeOnSite'];
    strComment = json['strComment'];
    strBookingReference = json['strBookingReference'];
    strStatus = json['strStatus'];
    strBookingStatusType = json['strBookingStatusType'];
    dteCreatedDate = json['dteCreatedDate'];
    intPriority = json['intPriority'];
    intBookedBy = json['intBookedBy'];
    bisCustomerConfirmed = json['bisCustomerConfirmed'];
    dteCustomerConfirmedDate = json['dteCustomerConfirmedDate'];
    intCustomerId = json['intCustomerId'];
    intSupplierId = json['intSupplierId'];
    strBookedSlotType = json['strBookedSlotType'];
    strContactName = json['strContactName'];
    strCompanyName = json['strCompanyName'];
    strLogo = json['strLogo'];
    dteCreatedDateStr = json['dteCreatedDate_str'];
    intEngineerId = json['intEngineerId'];
    engineerName = json['engineerName'];
    strPostCode = json['strPostCode'];
    regionPatches = json['regionPatches'];
    patchCode = json['patchCode'];
    strBookedBy = json['strBookedBy'];
    appointmentEventType = json['appointmentEventType']==AppStrings.onRoute?AppStrings.enRoute:json['appointmentEventType']==AppStrings.inRoute?AppStrings.enRoute:json['appointmentEventType'];
    customerName = json['customerName'];
    intTimeSlotId = json['intTimeSlotId'];
    intAppointmentEventId = json['intAppointmentEventId'];
    dteCapturedAt = json['dteCapturedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intId'] = this.intId;
    data['strAppointmentType'] = this.strAppointmentType;
    data['strJobType'] = this.strJobType;
    data['dteBookedDate'] = this.dteBookedDate;
    data['strBookedTime'] = this.strBookedTime;
    data['strSiteAddress'] = this.strSiteAddress;
    data['strSiteDateConsent'] = this.strSiteDateConsent;
    data['strSiteCustomerPassword'] = this.strSiteCustomerPassword;
    data['strSiteCustomerComment'] = this.strSiteCustomerComment;
    data['intTimeOnSite'] = this.intTimeOnSite;
    data['strComment'] = this.strComment;
    data['strBookingReference'] = this.strBookingReference;
    data['strStatus'] = this.strStatus;
    data['strBookingStatusType'] = this.strBookingStatusType;
    data['dteCreatedDate'] = this.dteCreatedDate;
    data['intPriority'] = this.intPriority;
    data['intBookedBy'] = this.intBookedBy;
    data['bisCustomerConfirmed'] = this.bisCustomerConfirmed;
    data['dteCustomerConfirmedDate'] = this.dteCustomerConfirmedDate;
    data['intCustomerId'] = this.intCustomerId;
    data['intSupplierId'] = this.intSupplierId;
    data['strBookedSlotType'] = this.strBookedSlotType;
    data['strContactName'] = this.strContactName;
    data['strCompanyName'] = this.strCompanyName;
    data['strLogo'] = this.strLogo;
    data['dteCreatedDate_str'] = this.dteCreatedDateStr;
    data['intEngineerId'] = this.intEngineerId;
    data['engineerName'] = this.engineerName;
    data['strPostCode'] = this.strPostCode;
    data['regionPatches'] = this.regionPatches;
    data['patchCode'] = this.patchCode;
    data['strBookedBy'] = this.strBookedBy;
    data['appointmentEventType'] = this.appointmentEventType;
    data['customerName'] = this.customerName;
    data['intTimeSlotId'] = this.intTimeSlotId;
    data['intAppointmentEventId'] = this.intAppointmentEventId;
    data['dteCapturedAt'] = this.dteCapturedAt;
    return data;
  }
}