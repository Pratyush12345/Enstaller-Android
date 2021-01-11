class DocumentModel{
  String strDocUser;
  String intCreatedBy;
  String intSupplierId;
  String strKey;

  DocumentModel(
      {
        this.strDocUser,
        this.intCreatedBy,
        this.intSupplierId,
        this.strKey});

  DocumentModel.fromJson(Map<String, dynamic> json) {
    strDocUser = json['strDocUser'];
    intCreatedBy = json['intCreatedBy'];
    intSupplierId = json['intSupplierId'];
    strKey = json['strKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['strDocUser'] = this.strDocUser;
    data['intCreatedBy'] = this.intCreatedBy;
    data['intSupplierId'] = this.intSupplierId;
    data['strKey'] = this.strKey;
    return data;
  }
}

class DocumentResponseModel{
  int intId;
  String strDocUser;
  String strDocType;
  String strFileName;
  int intSupplierId;
  bool bisEngineerRead;
  String strCompanyName;
  String strValue;
  bool bisalive;

  DocumentResponseModel(
      {
  this.intId,
  this.strDocUser,
  this.strDocType,
  this.strFileName,
  this.intSupplierId,
  this.bisEngineerRead,
  this.strCompanyName,
  this.strValue,
  this.bisalive,
});

  DocumentResponseModel.fromJson(Map<String, dynamic> json) {
  intId = json["intId"];
  strDocUser = json["strDocUser"];
  strDocType = json["strDocType"];
  strFileName = json["strFileName"];
  intSupplierId = json["intSupplierId"];
  bisEngineerRead = json["bisEngineerRead"];
  strCompanyName = json["strCompanyName"];
  strValue = json["strValue"];
  bisalive = json["bisalive"];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["intId"] = intId;
    data["strDocUser"] = strDocUser;
    data["strDocType"] = strDocType;
    data["strFileName"] = strFileName;
    data["intSupplierId"] = intSupplierId;
    data["bisEngineerRead"] = bisEngineerRead;
    data["strCompanyName"] = strCompanyName;
    data["strValue"] = strValue;
    data["bisalive"] = bisalive;

return data;
  }
}

