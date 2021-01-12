class SMSNotificationModel{
   String dteCreatedDate;
   String strBookingReference;
   String customerName;
   String strPageName;
   String body;
   String msgto;
   String msgStatus;
    

  SMSNotificationModel(
      {
   this.dteCreatedDate,
   this.strBookingReference,
   this.customerName,
   this.strPageName,
   this.body,
   this.msgto,
   this.msgStatus,
   
});

  SMSNotificationModel.fromJson(Map<String, dynamic> json) {
  dteCreatedDate = json["dteCreatedDate"];
  strBookingReference = json["strBookingReference"];
  customerName = json["customerName"];
  strPageName = json["strPageName"];
  body = json["body"];
  msgto = json["msgto"];
  msgStatus = json["msgStatus"];
  
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["dteCreatedDate"] = dteCreatedDate;
    data["strBookingReference"] = strBookingReference;
    data["customerName"] = customerName;
    data["strPageName"] = strPageName;
    data["body"] = body;
    data["msgto"] = msgto;
    data["msgStatus"] = msgStatus;

return data;
  }
}

