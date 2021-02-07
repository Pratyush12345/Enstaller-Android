class SerialItemModel{
  String strSerialNo;
  String strItemName;


  SerialItemModel({this.strSerialNo, this.strItemName});

  SerialItemModel.fromJson(Map<String, dynamic> json) {
    strSerialNo = json['strSerialNo'];
    strItemName = json['strItemName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['strSerialNo'] = this.strSerialNo;
    data['strItemName'] = this.strItemName;
    return data;
  }
}