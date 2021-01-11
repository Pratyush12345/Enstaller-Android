class Appointment {
  int intId;
  String strAppointmentType;
  String strJobType;
  String dteBookedDate;
  Null dteBookedDateStr;
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
  bool bisIsEmailSendingEnabled;
  bool bisIsSmsSendingEnabled;
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
  int intTimeSlotId;

  Appointment(
      {this.intId,
        this.strAppointmentType,
        this.strJobType,
        this.dteBookedDate,
        this.dteBookedDateStr,
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
        this.bisIsEmailSendingEnabled,
        this.bisIsSmsSendingEnabled,
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
        this.intTimeSlotId});

  Appointment.fromJson(Map<String, dynamic> json) {
    intId = json['intId'];
    strAppointmentType = json['strAppointmentType'];
    strJobType = json['strJobType'];
    dteBookedDate = json['dteBookedDate'];
    dteBookedDateStr = json['dteBookedDate_str'];
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
    bisIsEmailSendingEnabled = json['bisIsEmailSendingEnabled'];
    bisIsSmsSendingEnabled = json['bisIsSmsSendingEnabled'];
    strContactName = json['strContactName'];
    strCompanyName = json['strCompanyName'];
    strLogo = json['strLogo'];
    dteCreatedDateStr = json['dteCreatedDate_str'];
    intEngineerId = json['intEngineerId'];
    engineerName = json['EngineerName'];
    strPostCode = json['strPostCode'];
    regionPatches = json['RegionPatches'];
    patchCode = json['PatchCode'];
    strBookedBy = json['strBookedBy'];
    appointmentEventType = json['AppointmentEventType'];
    intTimeSlotId = json['intTimeSlotId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intId'] = this.intId;
    data['strAppointmentType'] = this.strAppointmentType;
    data['strJobType'] = this.strJobType;
    data['dteBookedDate'] = this.dteBookedDate;
    data['dteBookedDate_str'] = this.dteBookedDateStr;
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
    data['bisIsEmailSendingEnabled'] = this.bisIsEmailSendingEnabled;
    data['bisIsSmsSendingEnabled'] = this.bisIsSmsSendingEnabled;
    data['strContactName'] = this.strContactName;
    data['strCompanyName'] = this.strCompanyName;
    data['strLogo'] = this.strLogo;
    data['dteCreatedDate_str'] = this.dteCreatedDateStr;
    data['intEngineerId'] = this.intEngineerId;
    data['EngineerName'] = this.engineerName;
    data['strPostCode'] = this.strPostCode;
    data['RegionPatches'] = this.regionPatches;
    data['PatchCode'] = this.patchCode;
    data['strBookedBy'] = this.strBookedBy;
    data['AppointmentEventType'] = this.appointmentEventType;
    data['intTimeSlotId'] = this.intTimeSlotId;
    return data;
  }
}