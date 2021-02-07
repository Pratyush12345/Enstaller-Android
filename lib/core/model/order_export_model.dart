import 'package:intl/intl.dart';

class OrderExportModel{
  String strUserName;
  String strStatus;
  String dteCreatedDate;
  String dteCollectionDate;
  String strRefrence;
  String strContractName;
  String dteModifiedDate;
  String strSKU;
  String strItemName;
  int decQty;

  OrderExportModel(
      {this.decQty,
        this.strSKU,
        this.strItemName,
        this.strUserName,
        this.strStatus,
        this.dteCreatedDate,
        this.dteCollectionDate,
        this.strRefrence,
        this.strContractName,
        this.dteModifiedDate});

  OrderExportModel.fromJson(Map<String, dynamic> json) {
    decQty = json["decQty"].toInt()?? 0;
    strSKU = json["strSKU"]??'';
    strItemName = json["strItemName"]?? '';
    strUserName = json['strUserName'] ?? '';
    strContractName = json['strContractName']??'';
    dteCreatedDate = json['dteCreatedDate']!= null?DateFormat('yyyy-MM-dd HH:MM').format(
        DateTime.parse(json['dteCreatedDate'])) : '';
    dteCollectionDate = json['dteCollectionDate']!= null?DateFormat('yyyy-MM-dd HH:MM').format(
        DateTime.parse(json['dteCollectionDate'])):'';
    strRefrence = json["strRefrence"]?? '';
    strStatus = json["strStatus"]?? '';
    dteModifiedDate =json['dteModifiedDate']!= null? DateFormat('yyyy-MM-dd HH:MM').format(
        DateTime.parse(json['dteModifiedDate'])): '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["decQty"] = this.decQty.toString();
    data["strSKU"] = this.strSKU.toString();
    data["strItemName"] = this.strItemName.toString();
    data["strUserName"] = this.strUserName.toString();
    data["strContractName"] = this.strContractName.toString();
    data["dteCreatedDate"] = this.dteCreatedDate.toString();
    data["dteCollectionDate"] = this.dteCollectionDate.toString();
    data["strRefrence"] = this.strRefrence.toString();
    data["strStatus"] = this.strStatus.toString();
    data["dteModifiedDate"] = this.dteModifiedDate.toString();
    return data;
  }
}