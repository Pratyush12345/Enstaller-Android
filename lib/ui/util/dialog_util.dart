import 'package:enstaller/ui/util/text_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogSnackBarUtils {
  static DialogSnackBarUtils _dialogSnackBarUtils = DialogSnackBarUtils();

  static DialogSnackBarUtils get dialogSnackBarUtilsInstance =>
      _dialogSnackBarUtils;


  TextEditingController _textEditingController= TextEditingController();


  // show snackbar
  void showSnackbar(
      {BuildContext context,
        ScaffoldState scaffoldState,
        String message,
        Color backgroundColor}) {
    scaffoldState.showSnackBar(new SnackBar(
        backgroundColor:
        backgroundColor ?? Colors.white,
        content: new Text(
          message,
          style: TextStyle(color: Colors.black,fontSize: 14.0),
        )));
  }

  // used to show alert
  void showAlertDialog({
    @required BuildContext context,
    @required String title,
    String subTitle,
    String centerImage,
    String positiveButton,
    TextStyle titleTextStyle,
    TextStyle subTitleTextStyle,
    TextStyle buttonTextStyle,
    String negativeButton,
    bool barrierDismissible = false,
    Function onPositiveButtonTab,
    Function onNegativeButtonTab,
  }) {
    var actionWidgets = <Widget>[];
    if (positiveButton?.isNotEmpty == true) {
      actionWidgets.add(CupertinoDialogAction(
        child: Text(
          positiveButton ?? "",
          style: buttonTextStyle ??
              TextStyle(
                  color: Colors.black,
                  fontSize: 14.0),
        ),
        onPressed: onPositiveButtonTab,
      ));
    }
    if (negativeButton?.isNotEmpty == true) {
      actionWidgets.add(CupertinoDialogAction(
        child: Text(
          negativeButton ?? "",
          style: buttonTextStyle ??
              TextStyle(
                  color: Colors.black,
                  fontSize:14.0),
        ),
        onPressed: onNegativeButtonTab,
      ));
    }

// show the dialog
    showDialog(
        barrierDismissible: barrierDismissible,
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: new Text(
            title,
            style: titleTextStyle ??
               TextStyle(color: Colors.black,fontSize: 14.0),
          ),
          content: Visibility(
              visible: subTitle?.isNotEmpty ,
              child: new Text(
                subTitle ?? "",
                style: subTitleTextStyle ??
                    TextStyle(
                        fontSize: 12.0,
                        color: Colors.black),
              )),
          actions: actionWidgets,
        ));
  }
  // used to show alert
  void showAlertDialog1({
    @required BuildContext context,
    @required String title,
    String subTitle,
    String centerImage,
    String positiveButton,
    TextStyle titleTextStyle,
    TextStyle subTitleTextStyle,
    TextStyle buttonTextStyle,
    String negativeButton,
    bool barrierDismissible = false,
    Function onPositiveButtonTab,
    Function onNegativeButtonTab,
  }) {
    var actionWidgets = <Widget>[];
    if (positiveButton?.isNotEmpty == true) {
      actionWidgets.add(CupertinoDialogAction(
        child: Text(
          positiveButton ?? "",
          style: buttonTextStyle ??
              TextStyle(
                  color: Colors.black,
                  fontSize: 14.0),
        ),
        onPressed: onPositiveButtonTab,
      ));
    }
    if (negativeButton?.isNotEmpty == true) {
      actionWidgets.add(CupertinoDialogAction(
        child: Text(
          negativeButton ?? "",
          style: buttonTextStyle ??
              TextStyle(
                  color: Colors.black,
                  fontSize: 14.0),
        ),
        onPressed: onNegativeButtonTab,
      ));
    }}

}
