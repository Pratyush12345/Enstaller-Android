class StockLocationModel {
  int locationId;
  String locationName;

  StockLocationModel({this.locationId, this.locationName});

  StockLocationModel.fromJson(Map<String, dynamic> json) {
    locationId = json['locationId'];
    locationName = json['locationName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['locationId'] = this.locationId;
    data['locationName'] = this.locationName;
    return data;
  }
}
class StockStatusModel {
  int intStatusId;
  String strStatusName;

  StockStatusModel({this.intStatusId, this.strStatusName});

  StockStatusModel.fromJson(Map<String, dynamic> json) {
    intStatusId = json['intStatusId'];
    strStatusName = json['strStatusName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intStatusId'] = this.intStatusId;
    data['strStatusName'] = this.strStatusName;
    return data;
  }
}

class DownLoadFormatModel {
  int intId;
  String strKey;
  String strValue;

  DownLoadFormatModel({this.intId, this.strKey, this.strValue});

  DownLoadFormatModel.fromJson(Map<String, dynamic> json) {
    intId = json['intId'];
    strKey = json['strKey'];
    strValue = json['strValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intId'] = this.intId;
    data['strKey'] = this.strKey;
    data['strValue'] = this.strValue;
    return data;
  }
}


class StockBatchModel {
  int intBatchId;
  String strBatchNumber;

  StockBatchModel({this.intBatchId, this.strBatchNumber});

  StockBatchModel.fromJson(Map<String, dynamic> json) {
    intBatchId = json['intBatchId'];
    strBatchNumber = json['strBatchNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intBatchId'] = this.intBatchId;
    data['strBatchNumber'] = this.strBatchNumber;
    return data;
  }
}

class StockPalletModel {
  String strPalletId;
  int intStockId;
  int intBatchId;
  bool isSelected; 

  StockPalletModel({this.strPalletId, this.intStockId, this.intBatchId});

  StockPalletModel.fromJson(Map<String, dynamic> json) {
    strPalletId = json['strPalletId'];
    intStockId = json['intStockId'];
    intBatchId = json['intBatchId'];
    isSelected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['strPalletId'] = this.strPalletId;
    data['intStockId'] = this.intStockId;
    data['intBatchId'] = this.intBatchId;
    data['isSelected'] =  this.isSelected;
    return data;
  }
}

