class SaveOrderLine {
  int intId;
  int intOrderId;
  int intItemId;
  bool bisAlive;
  int intCreatedBy;
  int decQty;
  int intContractId;

  SaveOrderLine(
      {this.intId = 0,
      this.intOrderId,
      this.intCreatedBy,
      this.bisAlive,
      this.decQty,
      this.intContractId,
      this.intItemId});

  SaveOrderLine.fromJson(Map<String, dynamic> json) {
    intId = json['intId'];
    intOrderId = json["intOrderId"];
    intCreatedBy = json["intCreatedBy"];
    bisAlive = json["bisAlive"];
    decQty = json["decQty"];
    intContractId = json["intContractId"];
    intItemId = json["intItemId"];
  }



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["intOrderId"] = this.intOrderId.toString();
    data["intCreatedBy"] = this.intCreatedBy.toString();
    data["bisAlive"] = this.bisAlive? 1: 0;
    data["decQty"] = this.decQty.toString();
    data["intContractId"] = this.intContractId.toString();
    data["intItemId"] = this.intItemId.toString();
    data['intId'] = this.intId.toString();
    return data;
  }
}
