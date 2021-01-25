class ItemOrder{
  int intId;
  String strName;
  int intContractId;

  ItemOrder({this.intId, this.strName, this.intContractId});

  ItemOrder.fromJson(Map<String, dynamic> json) {
    intId = json['intId'];
    strName = json['strName'];
    intContractId = json['intContractId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intId'] = this.intId;
    data['strName'] = this.strName;
    data['intContractId'] = this.intContractId;
    return data;
  }
}