class EmailNotificationModel{
  int intId;
  int intUserId;
  int intCustomerId;
  int intAppointmentId;
  String strEmail;
  String strPageName;
  String strActionName;
  String dteCreatedDate;
  String strMailContent;
  String mailChimpId;
  int intAutoMailid;
  bool isPartnerEmail;
  String strAttachmentPath;
  int intgroupid;
  bool bisfromPartner;
  bool bisfromCustomer;
  bool isGroupBillEmail;
  String strGroupBillIDs;
  String strGroupCustomerIDs;
  bool bisReadByCustomer;
  int intSupplierId;
  int intSupplierUserId;
  int intEngineerId;
  String strActionby;
  String customerName;
  String supplierCompany;
  String engineerName;

  
  EmailNotificationModel(
      {
  this.intId,
  this.intUserId,
  this.intCustomerId,
  this.intAppointmentId,
  this.strEmail,
  this.strPageName,
  this.strActionName,
  this.dteCreatedDate,
  this.strMailContent,
  this.mailChimpId,
  this.intAutoMailid,
  this.isPartnerEmail,
  this.strAttachmentPath,
  this.intgroupid,
  this.bisfromPartner,
  this.bisfromCustomer,
  this.isGroupBillEmail,
  this.strGroupBillIDs,
  this.strGroupCustomerIDs,
  this.bisReadByCustomer,
  this.intSupplierId,
  this.intSupplierUserId,
  this.intEngineerId,
  this.strActionby,
  this.customerName,
  this.supplierCompany,
  this.engineerName,

});

  EmailNotificationModel.fromJson(Map<String, dynamic> json) {
  intId = json["intId"];
  intUserId = json["intUserId"];
  intCustomerId = json["intCustomerId"];
  intAppointmentId = json["intAppointmentId"];
  strEmail = json["strEmail"];
  strPageName = json["strPageName"];
  strActionName = json["strActionName"];
  dteCreatedDate = json["dteCreatedDate"];
  strMailContent = json["strMailContent"];
  mailChimpId = json["mailChimpId"];
  intAutoMailid = json["intAutoMailid"];
  isPartnerEmail = json["isPartnerEmail"];
  strAttachmentPath = json["strAttachmentPath"];
  intgroupid = json["intgroupid"];
  bisfromPartner = json["bisfromPartner"];
  bisfromCustomer = json["bisfromCustomer"];
  isGroupBillEmail = json["isGroupBillEmail"];
  strGroupBillIDs = json["strGroupBillIDs"];
  strGroupCustomerIDs = json["strGroupCustomerIDs"];
  bisReadByCustomer = json["bisReadByCustomer"];
  intSupplierId = json["intSupplierId"];
  intSupplierUserId = json["intSupplierUserId"];
  intEngineerId = json["intEngineerId"];
  strActionby = json["strActionby"];
  customerName = json["customerName"];
  supplierCompany = json["supplierCompany"];
  engineerName = json["engineerName"];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["intId"] = intId ;
   data["intUserId"]= intUserId ;
  data["intCustomerId"] = intCustomerId;
  data["intAppointmentId"] = intAppointmentId;
  data["strEmail"] = strEmail;
  data["strPageName"] = strPageName;
  data["strActionName"] = strActionName ;
  data["dteCreatedDate"] = dteCreatedDate;
  data["strMailContent"] = strMailContent;
  data["mailChimpId"] = mailChimpId;
   data["intAutoMailid"] = intAutoMailid;
   data["isPartnerEmail"] = isPartnerEmail;
   data["strAttachmentPath"] = strAttachmentPath;
   data["intgroupid"] = intgroupid;
   data["bisfromPartner"] = bisfromPartner;
   data["bisfromCustomer"] = bisfromCustomer;
   data["isGroupBillEmail"] = isGroupBillEmail;
   data["strGroupBillIDs"] = strGroupBillIDs;
   data["strGroupCustomerIDs"] = strGroupCustomerIDs;
  data["bisReadByCustomer"] = bisReadByCustomer ;
  data["intSupplierId"] = intSupplierId;
  data["intSupplierUserId"] = intSupplierUserId;
  data["intEngineerId"] = intEngineerId;
  data["strActionby"] = strActionby ;
  data["customerName"] = customerName;
   data["supplierCompany"] = supplierCompany;
   data["engineerName"] = engineerName;

return data;
  }
}


