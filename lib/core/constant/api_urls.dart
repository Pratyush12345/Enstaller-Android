class ApiUrls{
  static String getAppointmentCode = "appointments/UpdateAppointmentStatus";
  static String logInUrl='users/login';
  static String getAppointMentListUrl='appointments/GetAppointmentByEngineerId';
  static String getappointmenttodaytomorrow = 'appointments/GetAppointmentByEngineerIdTodayTomorrow';
  static String getActivityLogsAppointmentIdUrl='appointments/GetActivityLogsAppointmentId';
  static String getAppointmentCommentsByAppointmentUrl='AppointmentComments/GetAppointmentCommentsByAppointment';
  static String saveAppointmentComments='AppointmentComments/SaveAppointmentComments';
  static String getAppointmentDetailsUrl='appointments/Get';
  static String getCustomerMeterListByCustomerUrl='CustomerMeter/GetCustomerMeterListByCustomer';
  static String appointmentDataEventsbyEngineerUrl='AppointmentEvents/AppointmentDataEventsbyEngineer';
  static String updateAppointmentStatusUrl='appointments/UpdateAppointmentStatus';
  static String getSurveyQuestionAppointmentWiseUrl='SurveyQuetion/GetSurveyQuestionAppointmentWise';
  static String addSurveyQuestionAnswerDetailUrl='SurveyQuestionAnswer/AddSurveyQuestionAnswerDetail';
  static String supplierDocumentUpdateEngineerRead = 'SupplierDocument/SupplierDocumentUpdateEngineerRead';
  static String getCustomerByIdUrl='Customer/GetCustomerById';
  static String getEngineerAppointmentsUrl='appointments/GetEngineerAppointments';
  static String getAppointmentByEngineerIdUrl='appointments/GetAppointmentByEngineerId';
  static String getSurveyQuestionAnswerDetailUrl='SurveyQuestionAnswer/GetSurveyQuestionAnswerDetail';
  static String getSupplierDocument = 'SupplierDocument/GetSupplierDocumentListUserwise';
  static String getEmailTemplateSenderHistoryUserWise = 'EmailTemplateSenderHistory/GetEmailTemplateSenderHistoryUserWise';
  static String getSMSClickSendNotificationUserWise = 'SMSClickSendHistory/GetSMSClickSendNotificationUserWise';
  static String getMAICheckProcess = 'DCCMAI/GetMAICheckProcess';
  static String getItemsForOrder  = 'Order/BindUserContractWiseItemModel';
  static String getContractsForOrder  = 'Location/GetStockContractList';
  static String saveOrder='Order/InsertUpdateDeleteOrder';
  static String saveOrderLine = 'Order/InsertUpdateDeleteOrderLineItems';
}