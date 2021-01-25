import 'package:enstaller/core/model/serial_model.dart';

class StockRequestReplyModel{
  List<SerialNoModel> listSerials;
  int intRequestId;
  String strComments;

  StockRequestReplyModel(
      {this.listSerials, this.intRequestId, this.strComments});

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['strComments'] = strComments;
    data['intRequestId'] = intRequestId.toString();
    data['listSerials'] = listSerials.map((e) => e.toJson()).toList();
    return data;
  }
}