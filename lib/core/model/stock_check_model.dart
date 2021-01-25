class StockCheckModel{
  int intId;
  int intMOPUserId;
  String strMOPUserName;
  String strComments;
  String strEngReplyComments;
  String strCurrentStatus;
  String strRequestedDate; 

  StockCheckModel(
      {this.intId,
      this.intMOPUserId,
      this.strMOPUserName,
      this.strComments,
      this.strEngReplyComments,
      this.strCurrentStatus,
      this.strRequestedDate});


  StockCheckModel.fromJson(Map<String, dynamic> json){
    intId = json['intId'];
    intMOPUserId = json["intMOPUserId"];
    strMOPUserName = json["strMOPUserName"];
    strComments = json["strComments"];
    strEngReplyComments = json["strEngReplyComments"];
    strCurrentStatus = json["strCurrentStatus"];
    strRequestedDate = json["strRequestedDate"];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["intMOPUserId"] = this.intMOPUserId.toString();
    data["strMOPUserName"] = this.strMOPUserName.toString();
    data["strComments"] = this.strComments.toString();
    data["strEngReplyComments"] = this.strEngReplyComments.toString();
    data["strCurrentStatus"] = this.strCurrentStatus.toString();
    data["strRequestedDate"] = this.strRequestedDate.toString();
    return data;
  }
}