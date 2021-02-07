class ElectricAndGasMeterModel {
  int intId;
  int intCustomerId;
  String strFuel;
  String strMpan;
  String strMeterSerialNo;
  String strSSC;
  String strProfileClass;
  String dteSupplyStartDate;
  String dteSupplyEndDate;
  String strGridSupplyPoint;
  bool bIsEnergised;
  bool bIsSmart;
  String strOperationType;
  String dteCreatedDate;
  int intCreatedBy;
  String strProductReference;
  String strGSPGroupId;

  ElectricAndGasMeterModel(
      {this.intId,
        this.intCustomerId,
        this.strFuel,
        this.strMpan,
        this.strMeterSerialNo,
        this.strSSC,
        this.strProfileClass,
        this.dteSupplyStartDate,
        this.dteSupplyEndDate,
        this.strGridSupplyPoint,
        this.bIsEnergised,
        this.bIsSmart,
        this.strOperationType,
        this.dteCreatedDate,
        this.intCreatedBy,
        this.strProductReference,
        this.strGSPGroupId});

  ElectricAndGasMeterModel.fromJson(Map<String, dynamic> json) {
    intId = json['intId'];
    intCustomerId = json['intCustomerId'];
    strFuel = json['strFuel'];
    strMpan = json['strMpan'];
    strMeterSerialNo = json['strMeterSerialNo'];
    strSSC = json['strSSC'];
    strProfileClass = json['strProfileClass'];
    dteSupplyStartDate = json['dteSupplyStartDate'];
    dteSupplyEndDate = json['dteSupplyEndDate'];
    strGridSupplyPoint = json['strGridSupplyPoint'];
    bIsEnergised = json['bIsEnergised'];
    bIsSmart = json['bIsSmart'];
    strOperationType = json['strOperationType'];
    dteCreatedDate = json['dteCreatedDate'];
    intCreatedBy = json['intCreatedBy'];
    strProductReference = json['strProduct_Reference'];
    strGSPGroupId = json['strGSPGroupId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intId'] = this.intId;
    data['intCustomerId'] = this.intCustomerId;
    data['strFuel'] = this.strFuel;
    data['strMpan'] = this.strMpan;
    data['strMeterSerialNo'] = this.strMeterSerialNo;
    data['strSSC'] = this.strSSC;
    data['strProfileClass'] = this.strProfileClass;
    data['dteSupplyStartDate'] = this.dteSupplyStartDate;
    data['dteSupplyEndDate'] = this.dteSupplyEndDate;
    data['strGridSupplyPoint'] = this.strGridSupplyPoint;
    data['bIsEnergised'] = this.bIsEnergised;
    data['bIsSmart'] = this.bIsSmart;
    data['strOperationType'] = this.strOperationType;
    data['dteCreatedDate'] = this.dteCreatedDate;
    data['intCreatedBy'] = this.intCreatedBy;
    data['strProduct_Reference'] = this.strProductReference;
    data['strGSPGroupId'] = this.strGSPGroupId;
    return data;
  }
}