class SaveOrder{
  int intId;
  int intUserId;
  bool bisBulkUpload;
  int intCreatedBy;
  String dteCollectionDate;
  bool bisAlive;
  int intRegionId;
  String strThirdParty;
  int intContractId; 
  int intWarehouseId;
  bool isMerged;
  String strMarshallingLane;
  int intModifiedBy;


  SaveOrder(
      {this.intId = 0,
      this.intUserId,
      this.bisBulkUpload,
      this.intCreatedBy,
      this.dteCollectionDate,
      this.bisAlive,
      this.intRegionId,
      this.strThirdParty,
      this.intContractId,
      this.intWarehouseId,
      this.isMerged,
      this.strMarshallingLane,
      this.intModifiedBy});

  SaveOrder.fromJson(Map<String, dynamic> json) {
    intId = json['intId'];
    intUserId = json["intUserId"];
    bisBulkUpload = json["bisBulkUpload"];
    intCreatedBy = json["intCreatedBy"];
    dteCollectionDate = json["dteCollectionDate"];
    bisAlive = json["bisAlive"];
    intRegionId = json["intRegionId"];
    strThirdParty = json["strThirdParty"];
    intContractId = json["intContractId"];
    intWarehouseId = json["intWarehouseId"];
    isMerged = json["isMerged"];
    strMarshallingLane = json["strMarshallingLane"];
    intModifiedBy = json["intModifiedBy"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["intUserId"] = this.intUserId.toString();
    data["intId"] = this.intId.toString();
    data["bisBulkUpload"] = this.bisBulkUpload.toString();
    data["intCreatedBy"] = this.intCreatedBy.toString();
    data["dteCollectionDate"] = this.dteCollectionDate.toString();
    data["bisAlive"] = this.bisAlive.toString();
    data["intRegionId"] = this.intRegionId.toString();
    data["strThirdParty"] = this.strThirdParty.toString();
    data["intContractId"] = this.intContractId.toString();
    data["intWarehouseId"] = this.intWarehouseId.toString();
    data["isMerged"] = this.isMerged.toString();
    data["strMarshallingLane"] = this.strMarshallingLane;
    data["intModifiedBy"] = this.intModifiedBy.toString();
    return data;
  }
}