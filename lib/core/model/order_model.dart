import 'package:intl/intl.dart';

class OrderModel {
  int intOrderId;
  int rowNumber;
  String strStatus;
  String strRefrence;
  String strWarehouseName;
  String createdDate; 

  OrderModel(
      {this.intOrderId,
      this.strStatus,
      this.strWarehouseName,
      this.strRefrence,
      this.rowNumber});

  OrderModel.fromJson(Map<String, dynamic> json) {
    intOrderId = json["intOrderId"];
    strStatus = json["strStatus"];
    strRefrence = json["strRefrence"];
    strWarehouseName = json["strWarehouseName"];
    rowNumber = json["rowNumber"];

    createdDate = DateFormat('yyyy-MM-dd').format(
       DateTime.parse(json['strRefrence'].toString().split('-')[0]));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["intOrderId"] = this.intOrderId.toString();
    data["strWarehouseName"] = this.strWarehouseName.toString();
    data["strRefrence"] = this.strRefrence.toString();
    data["strStatus"] = this.strStatus.toString();
    data["rowNumber"] = this.rowNumber.toString();

    return data;
  }
}
