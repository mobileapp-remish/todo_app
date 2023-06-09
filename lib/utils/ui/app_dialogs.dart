import 'package:flutter/material.dart';
import 'package:todo_app/widgets/alert_dialog_widget.dart';
import 'package:todo_app/widgets/information_dialog_widget.dart';
import 'package:todo_app/widgets/log_out_dialog.dart';
import 'package:todo_app/widgets/progress_dialog_widget.dart';

class AppDialogs {
  static void displayErrorSnackBar({
    required String message,
    required BuildContext context,
  }) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    final snackBar = SnackBar(
      content: Text(message),
      elevation: 3,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(8),
      action: SnackBarAction(
        label: 'RETRY',
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void displaySuccessSnackBar({
    required String message,
    required BuildContext context,
  }) {
    final snackBar = SnackBar(
      content: Text(message),
      elevation: 3,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

//TODO Please Wait Dialog
  static Future<void> showProgressDialog({
    required BuildContext context,
    String? msg,
    bool isDismissible = false,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: isDismissible,
      builder: (ctx) => progressWidget(
        msg: msg,
      ),
    );
  }

//TODO Title,Subtitle Dialog
  static void showAlertDialog({
    required BuildContext context,
    required String title,
    required String description,
    required String firstButtonName,
    required String secondButtonName,
    required VoidCallback onFirstButtonClicked,
    required VoidCallback onSecondButtonClicked,
    bool isDismissible = false,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialogWidget(
          title: title,
          description: description,
          onFirstButtonClicked: onFirstButtonClicked,
          onSecondButtonClicked: onSecondButtonClicked,
          secondButtonName: secondButtonName,
          firstButtonName: firstButtonName,
        );
      },
      barrierDismissible: isDismissible,
    );
  }

  //TODO Title,Subtitle Dialog
  static void showInformationDialog({
    required BuildContext context,
    required String title,
    required String description,
    required String actionName,
    required VoidCallback onActionClick,
    bool isDismissible = false,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return informationWidget(
          title: title,
          description: description,
          actionName: actionName,
          onClickAction: onActionClick,
        );
      },
      barrierDismissible: isDismissible,
    );
  }

  static Future<bool> showExitAlertDialog({
    required BuildContext context,
    required String title,
    required String description,
    required String firstButtonName,
    required String secondButtonName,
    required VoidCallback onFirstButtonClicked,
    required VoidCallback onSecondButtonClicked,
  }) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialogWidget(
          title: title,
          description: description,
          onFirstButtonClicked: onFirstButtonClicked,
          onSecondButtonClicked: onSecondButtonClicked,
          secondButtonName: secondButtonName,
          firstButtonName: firstButtonName,
        );
      },
      barrierDismissible: false,
    );
  }

  //TODO LogOut Dialog
  static Future<void> showLogoutDialogue({
    required BuildContext context,
    required VoidCallback onCancelBtnClick,
    required VoidCallback onLogoutBtnClick,
    bool barrierDismissible = false,
  }) {
    return showDialog(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (ctx) => logOutDialog(
        onCancelBtnClick: onCancelBtnClick,
        onLogoutBtnClick: onLogoutBtnClick,
      ),
    );
  }
}
