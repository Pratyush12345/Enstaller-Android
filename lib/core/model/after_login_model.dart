class AfterLoginModel {
  int rowNumber;
  int intId;
  String strName;
  String strDisplayName;
  String strEmail;
  String strPassword;
  String strPhoneNumber;
  int intRegionId;
  String strRegionName;
  int intWarehouseId;
  String strWarehouseName;
  int intLocationId;
  String strLocationName;
  int intContractId;
  String strContractName;
  int intRoleId;
  String strRoleName;
  bool bisActive;
  String strThirdPartyId;
  int intCreatedBy;
  String dteCreatedDate;
  int intModifiedBy;
  String dteModifiedDate;
  String strVANRegistrationNumber;

  AfterLoginModel(
      {this.rowNumber,
      this.intId,
      this.strName,
      this.strDisplayName,
      this.strEmail,
      this.strPassword,
      this.strPhoneNumber,
      this.intRegionId,
      this.strRegionName,
      this.intWarehouseId,
      this.strWarehouseName,
      this.intLocationId,
      this.strLocationName,
      this.intContractId,
      this.strContractName,
      this.intRoleId,
      this.strRoleName,
      this.bisActive,
      this.strThirdPartyId,
      this.intCreatedBy,
      this.dteCreatedDate,
      this.intModifiedBy,
      this.dteModifiedDate,
      this.strVANRegistrationNumber});

  AfterLoginModel.fromJson(Map<String, dynamic> json) {
    rowNumber = json['rowNumber'];
    intId = json['intId'];
    strName = json['strName'];
    strDisplayName = json['strDisplayName'];
    strEmail = json['strEmail'];
    strPassword = json['strPassword'];
    strPhoneNumber = json['strPhoneNumber'];
    intRegionId = json['intRegionId'];
    strRegionName = json['strRegionName'];
    intWarehouseId = json['intWarehouseId'];
    strWarehouseName = json['strWarehouseName'];
    intLocationId = json['intLocationId'];
    strLocationName = json['strLocationName'];
    intContractId = json['intContractId'];
    strContractName = json['strContractName'];
    intRoleId = json['intRoleId'];
    strRoleName = json['strRoleName'];
    bisActive = json['bisActive'];
    strThirdPartyId = json['strThirdPartyId'];
    intCreatedBy = json['intCreatedBy'];
    dteCreatedDate = json['dteCreatedDate'];
    intModifiedBy = json['intModifiedBy'];
    dteModifiedDate = json['dteModifiedDate'];
    strVANRegistrationNumber = json['strVANRegistrationNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rowNumber'] = this.rowNumber;
    data['intId'] = this.intId;
    data['strName'] = this.strName;
    data['strDisplayName'] = this.strDisplayName;
    data['strEmail'] = this.strEmail;
    data['strPassword'] = this.strPassword;
    data['strPhoneNumber'] = this.strPhoneNumber;
    data['intRegionId'] = this.intRegionId;
    data['strRegionName'] = this.strRegionName;
    data['intWarehouseId'] = this.intWarehouseId;
    data['strWarehouseName'] = this.strWarehouseName;
    data['intLocationId'] = this.intLocationId;
    data['strLocationName'] = this.strLocationName;
    data['intContractId'] = this.intContractId;
    data['strContractName'] = this.strContractName;
    data['intRoleId'] = this.intRoleId;
    data['strRoleName'] = this.strRoleName;
    data['bisActive'] = this.bisActive;
    data['strThirdPartyId'] = this.strThirdPartyId;
    data['intCreatedBy'] = this.intCreatedBy;
    data['dteCreatedDate'] = this.dteCreatedDate;
    data['intModifiedBy'] = this.intModifiedBy;
    data['dteModifiedDate'] = this.dteModifiedDate;
    data['strVANRegistrationNumber'] = this.strVANRegistrationNumber;
    return data;
  }
}
