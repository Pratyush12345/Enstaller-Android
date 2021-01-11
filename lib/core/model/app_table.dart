class AppTable {
  int intId;
  String strAppointmentType;
  String strJobType;
  String dteBookedDateStr;
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
  String dteCreatedDateStr;
  int intPriority;
  int intBookedBy;
  bool bisCustomerConfirmed;
  String dteCustomerConfirmedDate;
  int intCustomerId;
  int intSupplierId;
  String strBookedSlotType;
  bool bisIsEmailSendingEnabled;
  bool bisIsSmsSendingEnabled;
  Null strBookingChannel;
  Null dteClosedAt;
  Null strCancellationComment;
  Null strCancellationReason;
  String strContactName;
  String strPostCode;
  String strCompanyName;
  String strLogo;
  int intEngineerId;
  String engineerName;
  String patchCode;
  String appointmentEventType;

  AppTable(
      {this.intId,
        this.strAppointmentType,
        this.strJobType,
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
        this.dteCreatedDateStr,
        this.intPriority,
        this.intBookedBy,
        this.bisCustomerConfirmed,
        this.dteCustomerConfirmedDate,
        this.intCustomerId,
        this.intSupplierId,
        this.strBookedSlotType,
        this.bisIsEmailSendingEnabled,
        this.bisIsSmsSendingEnabled,
        this.strBookingChannel,
        this.dteClosedAt,
        this.strCancellationComment,
        this.strCancellationReason,
        this.strContactName,
        this.strPostCode,
        this.strCompanyName,
        this.strLogo,
        this.intEngineerId,
        this.engineerName,
        this.patchCode,
        this.appointmentEventType});

  AppTable.fromJson(Map<String, dynamic> json) {
    intId = json['intId'];
    strAppointmentType = json['strAppointmentType'];
    strJobType = json['strJobType'];
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
    dteCreatedDateStr = json['dteCreatedDate_str'];
    intPriority = json['intPriority'];
    intBookedBy = json['intBookedBy'];
    bisCustomerConfirmed = json['bisCustomerConfirmed'];
    dteCustomerConfirmedDate = json['dteCustomerConfirmedDate'];
    intCustomerId = json['intCustomerId'];
    intSupplierId = json['intSupplierId'];
    strBookedSlotType = json['strBookedSlotType'];
    bisIsEmailSendingEnabled = json['bisIsEmailSendingEnabled'];
    bisIsSmsSendingEnabled = json['bisIsSmsSendingEnabled'];
    strBookingChannel = json['strBookingChannel'];
    dteClosedAt = json['dteClosedAt'];
    strCancellationComment = json['strCancellationComment'];
    strCancellationReason = json['strCancellationReason'];
    strContactName = json['strContactName'];
    strPostCode = json['strPostCode'];
    strCompanyName = json['strCompanyName'];
    strLogo = json['strLogo'];
    intEngineerId = json['intEngineerId'];
    engineerName = json['engineerName'];
    patchCode = json['patchCode'];
    appointmentEventType = json['appointmentEventType']=='InRoute'?'En Route':json['appointmentEventType']=='On Route'?'En Route':json['appointmentEventType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intId'] = this.intId;
    data['strAppointmentType'] = this.strAppointmentType;
    data['strJobType'] = this.strJobType;
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
    data['dteCreatedDate_str'] = this.dteCreatedDateStr;
    data['intPriority'] = this.intPriority;
    data['intBookedBy'] = this.intBookedBy;
    data['bisCustomerConfirmed'] = this.bisCustomerConfirmed;
    data['dteCustomerConfirmedDate'] = this.dteCustomerConfirmedDate;
    data['intCustomerId'] = this.intCustomerId;
    data['intSupplierId'] = this.intSupplierId;
    data['strBookedSlotType'] = this.strBookedSlotType;
    data['bisIsEmailSendingEnabled'] = this.bisIsEmailSendingEnabled;
    data['bisIsSmsSendingEnabled'] = this.bisIsSmsSendingEnabled;
    data['strBookingChannel'] = this.strBookingChannel;
    data['dteClosedAt'] = this.dteClosedAt;
    data['strCancellationComment'] = this.strCancellationComment;
    data['strCancellationReason'] = this.strCancellationReason;
    data['strContactName'] = this.strContactName;
    data['strPostCode'] = this.strPostCode;
    data['strCompanyName'] = this.strCompanyName;
    data['strLogo'] = this.strLogo;
    data['intEngineerId'] = this.intEngineerId;
    data['engineerName'] = this.engineerName;
    data['patchCode'] = this.patchCode;
    data['appointmentEventType'] = this.appointmentEventType;
    return data;
  }
}