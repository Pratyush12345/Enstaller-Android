import 'package:intl/intl.dart';

class OrderDetailModel{
  int rowNumber;
  int intId;
  int intUserId;
  String strUserName;
  int intStatusId;
  String strStatus;
  bool bisBulkUpload;
  int intCreatedBy;
  String dteCreatedDate;
  bool bisAlive;
  String dteCollectionDate;
  String strRefrence;
  int intRegionId;
  String strRegionName;
  String strThirdParty;
  int intContractId;
  String strContractName;
  int intWarehouseId;
  String strWarehouseName;
  bool isApproved;
  bool isMerged;
  String strMarshallingLane;
  int intModifiedBy;
  String dteModifiedDate;

  OrderDetailModel(
      {this.rowNumber,
      this.intId,
      this.intUserId,
      this.strUserName,
      this.intStatusId,
      this.strStatus,
      this.bisBulkUpload,
      this.intCreatedBy,
      this.dteCreatedDate,
      this.bisAlive,
      this.dteCollectionDate,
      this.strRefrence,
      this.intRegionId,
      this.strRegionName,
      this.strThirdParty,
      this.intContractId,
      this.strContractName,
      this.intWarehouseId,
      this.strWarehouseName,
      this.isApproved,
      this.isMerged,
      this.strMarshallingLane,
      this.intModifiedBy,
      this.dteModifiedDate});

  OrderDetailModel.fromJson(Map<String, dynamic> json) {
    intId = json["intId"]?? 0;
    intUserId = json["intUserId"]?? 0;
    rowNumber = json["rowNumber"]?? 0;
    strUserName = json['strUserName'] ?? '';
    intStatusId = json['intStatusId'] ?? 0;
    bisBulkUpload = json['bisBulkUpload']?? false;
    intCreatedBy = json['intCreatedBy']??0;
    dteCreatedDate = DateFormat('yyyy-MM-dd').format(
        DateTime.parse(json['dteCreatedDate'])) ?? '';
    bisAlive = json['bisAlive']?? false;
    dteCollectionDate = DateFormat('yyyy-MM-dd HH:MM').format(
        DateTime.parse(json['dteCollectionDate']))?? '';
    strRefrence = json["strRefrence"]?? '';
    strStatus = json["strStatus"]?? '';
    intRegionId = json['intRegionId']?? 0;
    strRegionName = json['strRegionName']?? '';
    strThirdParty = json['strThirdParty']?? '';
    intContractId = json['intContractId']?? 0;
    strContractName = json['strContractName']?? '';
    intWarehouseId = json['intWarehouseId'] ?? 0;
    strWarehouseName = json["strWarehouseName"] ?? '';
    isApproved = json['isApproved']?? false;
    isMerged = json['isMerged']?? false;
    strMarshallingLane = json['strMarshallingLane']?? '';
    intModifiedBy = json['intModifiedBy']?? 0;
    dteModifiedDate = DateFormat('yyyy-MM-dd').format(
        DateTime.parse(json['dteModifiedDate']))?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["intId"] = this.intId.toString();
    data["strWarehouseName"] = this.strWarehouseName.toString();
    data["strRefrence"] = this.strRefrence.toString();
    data["strStatus"] = this.strStatus.toString();
    data["rowNumber"] = this.rowNumber.toString();

    return data;
  }
}