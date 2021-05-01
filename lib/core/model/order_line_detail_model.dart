class OrderLineDetailModel {
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


  OrderLineDetailModel(
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

  OrderLineDetailModel.fromJson(Map<String, dynamic> json) {
    intId = json['intId'];
    intOrderId = json["intOrderId"];
    intItemId = json["intItemId"];
    intCreatedBy = json["intCreatedBy"];
    bisAlive = json["bisAlive"];
    decQty = json["decQty"].toInt();
    intContractId = json["intContractId"];
    strItemName = json['strItemName']??'';
    strItemDescription = json['strItemDescription']?? '';
    dteCreatedDate = json['dteCreatedDate']??'';

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["intOrderId"] = this.intOrderId.toString();
    data["intCreatedBy"] = this.intCreatedBy.toString();
    data["bisAlive"] = this.bisAlive.toString();
    data["decQty"] = this.decQty.toString();
    data["intContractId"] = this.intContractId.toString();
    data["intItemId"] = this.intItemId.toString();
    data['intId'] = this.intId.toString();
    data['strItemName'] = this.strItemName.toString();
    data['strItemDescription'] = this.strItemDescription.toString();
    data['dteCreatedDate'] = this.dteCreatedDate.toString();
    return data;
  }
}
