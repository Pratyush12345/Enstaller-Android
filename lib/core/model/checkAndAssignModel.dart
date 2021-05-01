class IsOrderAssignedModel {
  int intStockId;
  int intItemId;
  int intContainerId;
  int intOrderId;
  int intOrderLineItemId;
  double decQty;

  IsOrderAssignedModel(
      {this.intStockId, 
      this.intItemId,
      this.intContainerId,
      this.intOrderId,
      this.intOrderLineItemId,
      this.decQty});

  IsOrderAssignedModel.fromJson(Map<String, dynamic> json) {
    intStockId = json['intStockId'];
    intItemId = json['intItemId'];
    intContainerId = json['intContainerId'];
    intOrderId = json['intOrderId'];
    intOrderLineItemId = json['intOrderLineItemId'];
    decQty = json['decQty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intStockId'] = this.intStockId;
    data['intItemId'] = this.intItemId;
    data['intContainerId'] = this.intContainerId;
    data['intOrderId'] = this.intOrderId;
    data['intOrderLineItemId'] = this.intOrderLineItemId;
    data['decQty'] = this.decQty;
    return data;
  }
}

class OrderByRefernceModel {
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

  OrderByRefernceModel(
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

  OrderByRefernceModel.fromJson(Map<String, dynamic> json) {
    rowNumber = json['rowNumber'];
    intId = json['intId'];
    intUserId = json['intUserId'];
    strUserName = json['strUserName'];
    intStatusId = json['intStatusId'];
    strStatus = json['strStatus'];
    bisBulkUpload = json['bisBulkUpload'];
    intCreatedBy = json['intCreatedBy'];
    dteCreatedDate = json['dteCreatedDate'];
    bisAlive = json['bisAlive'];
    dteCollectionDate = json['dteCollectionDate'];
    strRefrence = json['strRefrence'];
    intRegionId = json['intRegionId'];
    strRegionName = json['strRegionName'];
    strThirdParty = json['strThirdParty'];
    intContractId = json['intContractId'];
    strContractName = json['strContractName'];
    intWarehouseId = json['intWarehouseId'];
    strWarehouseName = json['strWarehouseName'];
    isApproved = json['isApproved'];
    isMerged = json['isMerged'];
    strMarshallingLane = json['strMarshallingLane'];
    intModifiedBy = json['intModifiedBy'];
    dteModifiedDate = json['dteModifiedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rowNumber'] = this.rowNumber;
    data['intId'] = this.intId;
    data['intUserId'] = this.intUserId;
    data['strUserName'] = this.strUserName;
    data['intStatusId'] = this.intStatusId;
    data['strStatus'] = this.strStatus;
    data['bisBulkUpload'] = this.bisBulkUpload;
    data['intCreatedBy'] = this.intCreatedBy;
    data['dteCreatedDate'] = this.dteCreatedDate;
    data['bisAlive'] = this.bisAlive;
    data['dteCollectionDate'] = this.dteCollectionDate;
    data['strRefrence'] = this.strRefrence;
    data['intRegionId'] = this.intRegionId;
    data['strRegionName'] = this.strRegionName;
    data['strThirdParty'] = this.strThirdParty;
    data['intContractId'] = this.intContractId;
    data['strContractName'] = this.strContractName;
    data['intWarehouseId'] = this.intWarehouseId;
    data['strWarehouseName'] = this.strWarehouseName;
    data['isApproved'] = this.isApproved;
    data['isMerged'] = this.isMerged;
    data['strMarshallingLane'] = this.strMarshallingLane;
    data['intModifiedBy'] = this.intModifiedBy;
    data['dteModifiedDate'] = this.dteModifiedDate;
    return data;
  }
}

class OrderLineDetail {
  int intId;
  int intOrderId;
  int intItemId;
  String strItemName;
  String strItemDescription;
  int intContractId;
  double decQty;
  bool bisAlive;
  String dteCreatedDate;
  int intCreatedBy;

  OrderLineDetail(
      {this.intId,
      this.intOrderId,
      this.intItemId,
      this.strItemName,
      this.strItemDescription,
      this.intContractId,
      this.decQty,
      this.bisAlive,
      this.dteCreatedDate,
      this.intCreatedBy});

  OrderLineDetail.fromJson(Map<String, dynamic> json) {
    intId = json['intId'];
    intOrderId = json['intOrderId'];
    intItemId = json['intItemId'];
    strItemName = json['strItemName'];
    strItemDescription = json['strItemDescription'];
    intContractId = json['intContractId'];
    decQty = (json['decQty']);
    bisAlive = json['bisAlive'];
    dteCreatedDate = json['dteCreatedDate'];
    intCreatedBy = json['intCreatedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intId'] = this.intId;
    data['intOrderId'] = this.intOrderId;
    data['intItemId'] = this.intItemId;
    data['strItemName'] = this.strItemName;
    data['strItemDescription'] = this.strItemDescription;
    data['intContractId'] = this.intContractId;
    data['decQty'] = this.decQty;
    data['bisAlive'] = this.bisAlive;
    data['dteCreatedDate'] = this.dteCreatedDate;
    data['intCreatedBy'] = this.intCreatedBy;
    return data;
  }
}

class CheckSerialModel {
  int intStockId;
  int intItemId;
  int intContainerId;
  int intItemTypeId;
  int intOrderLineItemId;
  String strItemName;
  String strContainerName;
  String strSerialNo;
  double decQty;

  CheckSerialModel(
      {this.intStockId,
      this.intItemId,
      this.intContainerId,
      this.intItemTypeId,
      this.intOrderLineItemId,
      this.strItemName,
      this.strContainerName,
      this.strSerialNo,
      this.decQty});

  CheckSerialModel.fromJson(Map<String, dynamic> json) {
    intStockId = json['intStockId'];
    intItemId = json['intItemId'];
    intContainerId = json['intContainerId'];
    intItemTypeId = json['intItemTypeId'];
    intOrderLineItemId = json['intOrderLineItemId'];
    strItemName = json['strItemName'];
    strContainerName = json['strContainerName'];
    strSerialNo = json['strSerialNo'];
    decQty = json['decQty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intStockId'] = this.intStockId;
    data['intItemId'] = this.intItemId;
    data['intContainerId'] = this.intContainerId;
    data['intItemTypeId'] = this.intItemTypeId;
    data['intOrderLineItemId'] = this.intOrderLineItemId;
    data['strItemName'] = this.strItemName;
    data['strContainerName'] = this.strContainerName;
    data['strSerialNo'] = this.strSerialNo;
    data['decQty'] = this.decQty;
    return data;
  }
}

class SaveCheckOrderModel {
  int intCreatedBy;
  List<StockList> stockList;

  SaveCheckOrderModel({this.intCreatedBy, this.stockList});

  SaveCheckOrderModel.fromJson(Map<String, dynamic> json) {
    intCreatedBy = json['intCreatedBy'];
    if (json['StockList'] != null) {
      stockList = new List<StockList>();
      json['StockList'].forEach((v) {
        stockList.add(new StockList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intCreatedBy'] = this.intCreatedBy;
    if (this.stockList != null) {
      data['StockList'] = this.stockList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StockList {
  int intStockId;
  int intItemId;
  int intContainerId;
  int intOrderId;
  int intOrderLineItemId;
  int decQty;

  StockList(
      {this.intStockId,
      this.intItemId,
      this.intContainerId,
      this.intOrderId,
      this.intOrderLineItemId,
      this.decQty});

  StockList.fromJson(Map<String, dynamic> json) {
    intStockId = json['intStockId'];
    intItemId = json['intItemId'];
    intContainerId = json['intContainerId'];
    intOrderId = json['intOrderId'];
    intOrderLineItemId = json['intOrderLineItemId'];
    decQty = json['decQty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intStockId'] = this.intStockId;
    data['intItemId'] = this.intItemId;
    data['intContainerId'] = this.intContainerId;
    data['intOrderId'] = this.intOrderId;
    data['intOrderLineItemId'] = this.intOrderLineItemId;
    data['decQty'] = this.decQty;
    return data;
  }
}

