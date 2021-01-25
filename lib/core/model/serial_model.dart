class SerialNoModel{
  String strSerialNo;

  SerialNoModel({this.strSerialNo});

  SerialNoModel.fromJson(Map<String, dynamic> json){
    strSerialNo = json['strSerialNo'];
  }
 
  SerialNoModel.fromJson1(Map<String, dynamic> json){
    strSerialNo = json['serialNo'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['serialNo'] = strSerialNo;
    return data;
  }
}