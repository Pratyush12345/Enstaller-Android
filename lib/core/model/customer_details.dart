class CustomerDetails {
  int intId;
  String strTitle;
  String strFirstName;
  String strLastName;
  String strContactName;
  String strCustomerNumber;
  String strAccountNumber;
  String strContactTelephone;
  String strContactSMS;
  String strAddress;
  String strPostCode;
  String strEmail;
  String strSupplyStatus;
  String dteSupplyStartDate;
  bool bisVIP;
  String strUserName;
  String strPassword;
  String strNotificationPreference;
  String strDataConsent;
  int intCreatedBy;
  String dteCreatedDate;
  String strComment;
  bool bisActive;
  int intOutwardPostCodeId;
  String strFuel;
  var decBalance;
  String strVulnerabilities;

  CustomerDetails(
      {this.intId,
        this.strTitle,
        this.strFirstName,
        this.strLastName,
        this.strContactName,
        this.strCustomerNumber,
        this.strAccountNumber,
        this.strContactTelephone,
        this.strContactSMS,
        this.strAddress,
        this.strPostCode,
        this.strEmail,
        this.strSupplyStatus,
        this.dteSupplyStartDate,
        this.bisVIP,
        this.strUserName,
        this.strPassword,
        this.strNotificationPreference,
        this.strDataConsent,
        this.intCreatedBy,
        this.dteCreatedDate,
        this.strComment,
        this.bisActive,
        this.intOutwardPostCodeId,
        this.strFuel,
        this.decBalance,
        this.strVulnerabilities});

  CustomerDetails.fromJson(Map<String, dynamic> json) {
    intId = json['intId'];
    strTitle = json['strTitle'];
    strFirstName = json['strFirstName'];
    strLastName = json['strLastName'];
    strContactName = json['strContactName'];
    strCustomerNumber = json['strCustomerNumber'];
    strAccountNumber = json['strAccountNumber'];
    strContactTelephone = json['strContact_Telephone'];
    strContactSMS = json['strContact_SMS'];
    strAddress = json['strAddress'];
    strPostCode = json['strPostCode'];
    strEmail = json['strEmail'];
    strSupplyStatus = json['strSupply_Status'];
    dteSupplyStartDate = json['dteSupply_Start_Date'];
    bisVIP = json['bisVIP'];
    strUserName = json['strUserName'];
    strPassword = json['strPassword'];
    strNotificationPreference = json['strNotification_Preference'];
    strDataConsent = json['strData_Consent'];
    intCreatedBy = json['intCreatedBy'];
    dteCreatedDate = json['dteCreatedDate'];
    strComment = json['strComment'];
    bisActive = json['bisActive'];
    intOutwardPostCodeId = json['intOutwardPostCodeId'];
    strFuel = json['strFuel'];
    decBalance = json['decBalance'];
    strVulnerabilities = json['strVulnerabilities'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intId'] = this.intId;
    data['strTitle'] = this.strTitle;
    data['strFirstName'] = this.strFirstName;
    data['strLastName'] = this.strLastName;
    data['strContactName'] = this.strContactName;
    data['strCustomerNumber'] = this.strCustomerNumber;
    data['strAccountNumber'] = this.strAccountNumber;
    data['strContact_Telephone'] = this.strContactTelephone;
    data['strContact_SMS'] = this.strContactSMS;
    data['strAddress'] = this.strAddress;
    data['strPostCode'] = this.strPostCode;
    data['strEmail'] = this.strEmail;
    data['strSupply_Status'] = this.strSupplyStatus;
    data['dteSupply_Start_Date'] = this.dteSupplyStartDate;
    data['bisVIP'] = this.bisVIP;
    data['strUserName'] = this.strUserName;
    data['strPassword'] = this.strPassword;
    data['strNotification_Preference'] = this.strNotificationPreference;
    data['strData_Consent'] = this.strDataConsent;
    data['intCreatedBy'] = this.intCreatedBy;
    data['dteCreatedDate'] = this.dteCreatedDate;
    data['strComment'] = this.strComment;
    data['bisActive'] = this.bisActive;
    data['intOutwardPostCodeId'] = this.intOutwardPostCodeId;
    data['strFuel'] = this.strFuel;
    data['decBalance'] = this.decBalance;
    data['strVulnerabilities'] = this.strVulnerabilities;
    return data;
  }
}