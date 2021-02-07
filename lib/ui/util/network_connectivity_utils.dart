import 'package:connectivity/connectivity.dart';
import 'package:enstaller/ui/util/dialog_util.dart';
import 'package:flutter/material.dart';

class NetworkConnectionUtils {
  static NetworkConnectionUtils _networkConnectionUtils =
      NetworkConnectionUtils();

  static NetworkConnectionUtils get networkConnectionUtilsInstance =>
      _networkConnectionUtils;

  final Connectivity _connectivity = Connectivity();

  // used to check connectivity status
  Future<bool> getConnectivityStatus(BuildContext context,
      {bool showSnackBar = true, ScaffoldState scaffoldState}) async {
    var connectivityResult = await (_connectivity.checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
// I am connected to a mobile network.
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
// I am connected to a wifi network.
      return true;
    } else {
      if (showSnackBar) {
        DialogSnackBarUtils.dialogSnackBarUtilsInstance.showAlertDialog(
            context: context,
            title: "",
            positiveButton: 'ok',
            subTitle: 'Check Your Internet Connection',
            onPositiveButtonTab: () {
             Navigator.pop(context);
            });
//        DialogSnackBarUtils.dialogSnackBarUtilsInstance.showSnackbar(
//            context: context,
//            scaffoldState: scaffoldState,
//            message: AppLocalizations.of(context).common.error.pleaseCheckInternetConnection);
      }
      return false;
    }
  }
}
