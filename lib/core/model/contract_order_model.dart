class ContractOrder{
  int intId;
  String strName;

  ContractOrder({this.intId, this.strName});

  ContractOrder.fromJson(Map<String, dynamic> json) {
    intId = json['intId'];
    strName = json['strName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intId'] = this.intId;
    data['strName'] = this.strName;
    return data;
  }
}