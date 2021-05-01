import 'package:enstaller/core/service/api_service.dart';
import 'package:enstaller/core/service/navigation_service.dart';
import 'package:enstaller/core/viewmodel/abort_appointment_viewmodel.dart';
import 'package:enstaller/core/viewmodel/appointment_viewmodel.dart';
import 'package:enstaller/core/viewmodel/check_request_viewmodel.dart';
import 'package:enstaller/core/viewmodel/email_notification_viewmodel.dart';
import 'package:enstaller/core/viewmodel/comment_dialog_viewmodel.dart';
import 'package:enstaller/core/viewmodel/details_screen_viewmodel.dart';
import 'package:enstaller/core/viewmodel/documnet_viewmodel.dart';
import 'package:enstaller/core/viewmodel/get_user_details_viewmodel.dart';
import 'package:enstaller/core/viewmodel/home_screen_viewmodel.dart';
import 'package:enstaller/core/viewmodel/login_viewmodel.dart';
import 'package:enstaller/core/viewmodel/add_order_screen_viewmodel.dart';
import 'package:enstaller/core/viewmodel/order_detail_viewmodel.dart';
import 'package:enstaller/core/viewmodel/order_screen_viewmodel.dart';
import 'package:enstaller/core/viewmodel/show_appointmentbydate_viewmodel.dart';
import 'package:enstaller/core/viewmodel/stock_chcek_request_viewmodel.dart';
import 'package:enstaller/core/viewmodel/stock_request_reply_viewmodel.dart';
import 'package:enstaller/core/viewmodel/survey_screen_viewmodel.dart';
import 'package:enstaller/core/viewmodel/today_appointment_viewmodel.dart';
import 'package:enstaller/core/viewmodel/update_status_viewmodel.dart';
import 'package:enstaller/core/viewmodel/sms_notification_viewmodel.dart';
import 'package:enstaller/core/viewmodel/warehouse_viewmodel.dart/checkandassign_viewmodel.dart';
import 'package:enstaller/core/viewmodel/warehouse_viewmodel.dart/stock_update_status.dart';
import 'package:enstaller/ui/screen/add_order_screen.dart';
import 'package:enstaller/ui/screen/widget/abort_appointment_widget.dart';
import 'package:get_it/get_it.dart';




GetIt getIt = GetIt.instance;

void setupLocator() {

  //UI Models
  getIt.registerLazySingleton(() => NavigationService());
  getIt.registerFactory(() => ApiService());


  //screenViewModel

  getIt.registerFactory(() => LogInViewModel());
  getIt.registerFactory(() => HomeScreenViewModel());
  getIt.registerFactory(() => DetailsScreenViewModel());
  getIt.registerFactory(() => CommentDialogViewModel());
  getIt.registerFactory(() => AbortAppointmentViewModel());
  getIt.registerFactory(() => UpdateStatusViewModel());
  getIt.registerFactory(() => SurveyScreenViewModel());
  getIt.registerFactory(() => AppointmentViewModel());
  getIt.registerFactory(() => TodayAppointmentViewModel());
  getIt.registerFactory(() => ShowAppointmentByDateViewmodel());
  getIt.registerFactory(() => GetUserDetailsViewModel());
  getIt.registerFactory(() => DocumnetViewModel());
  getIt.registerFactory(() => EmailNotificationViewModel());
  getIt.registerFactory(() => SMSNotificationViewModel());
  getIt.registerFactory(() => AddOrderScreenViewModel());
  getIt.registerFactory(() => StockCheckRequestViewModel());
  getIt.registerFactory(() => StockRequestReplyViewModel());
  getIt.registerFactory(() => OrderScreenViewModel());
  getIt.registerFactory(() => OrderDetailViewModel());
  getIt.registerFactory(() => CheckRequestViewModel());
  getIt.registerFactory(() => StockUpdateStatusViewModel());
   



}