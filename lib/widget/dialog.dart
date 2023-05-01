import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'center_pop_view.dart';

class AlertAction {
  final String title;
  final Function onPressed;

  AlertAction(this.title, this.onPressed);
}

class AlertView {
  static String defaultCancelTitle = '取消';
  static String defaultConfirmTitle = '确定';
  static String defaultLoadingTitle = '请稍候';
  
  static showActionSheet(BuildContext context, List<AlertAction> actions) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(AlertView.defaultCancelTitle),
          ),
          actions: actions
              .map((e) => CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.of(context).pop();
                      e.onPressed();
                    },
                    child: Text(e.title),
                  ))
              .toList(),
        );
      },
    );
  }
}

void showProgressHUD(BuildContext context, {String? title, Color? barrierColor}) {
  showDialog(
    context: context,
    barrierColor: barrierColor,
    builder: (BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: WillPopScope(
          onWillPop: () => Future.value(false),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              Center(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(30, 30, 30, 20),
                  margin: const EdgeInsets.only(bottom: 100),
                  decoration: BoxDecoration(color: const Color(0x99000000), borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      CupertinoTheme(
                        data: CupertinoTheme.of(context).copyWith(brightness: Brightness.dark),
                        child: const CupertinoActivityIndicator(radius: 12),
                      ),
                      const SizedBox(height: 10),
                      Text(title ?? AlertView.defaultLoadingTitle, style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

void hideProgressHUD(BuildContext context) {
  Navigator.pop(context);
}

showTopPopView({required BuildContext context, Widget? child, double topOffset = 0}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    transitionDuration: const Duration(milliseconds: 150),
    pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            GestureDetector(
              onTap: () => Navigator.pop(context),
              behavior: HitTestBehavior.opaque,
              child: Container(),
            ),
            Positioned(
              left: 0,
              top: topOffset,
              right: 0,
              bottom: 0,
              child: IgnorePointer(
                child: Container(color: Colors.black54),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: topOffset,
              child: child!,
            ),
          ],
        ),
      );
    },
  );
}

Future<T?> showCenterPopView<T>(BuildContext context, Widget widget,
    {bool barrierDismissible = false, void Function(BuildContext)? onClose}) async {
  return showDialog<T>(
    context: context,
    builder: (BuildContext context) {
      return CenterPopView(
        widget,
        barrierDismissible: barrierDismissible,
        onClose: onClose,
      );
    },
  );
}

Future<T?> showBottomPopView<T>(BuildContext context, Widget widget, {bool barrierDismissible = true}) async {
  return await showGeneralDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black54,
    transitionDuration: const Duration(milliseconds: 150),
    pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                if (barrierDismissible) {
                  Navigator.pop(context);
                }
              },
              behavior: HitTestBehavior.opaque,
              child: Container(),
            ),
            Positioned(left: 0, right: 0, bottom: 0, child: widget),
          ],
        ),
      );
    },
  );
}

Future<bool> showAlertView({
  required BuildContext context,
  String? title,
  String? message,
  String? confirmTitle,
  String? cancelTitle,
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
  bool isDestructiveAction = false,
}) async {
  return await showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: title != null ? Text(title) : null,
        content: message != null ? Text(message) : null,
        actions: [
          CupertinoDialogAction(
            child: Text(cancelTitle ?? AlertView.defaultCancelTitle),
            onPressed: () {
              Navigator.pop(context, false);
              if (onCancel != null) {
                onCancel();
              }
            },
          ),
          if (confirmTitle != null || onConfirm != null)
            CupertinoDialogAction(
              isDestructiveAction: isDestructiveAction,
              isDefaultAction: true,
              child: Text(confirmTitle ?? AlertView.defaultConfirmTitle),
              onPressed: () {
                Navigator.pop(context, true);
                if (onConfirm != null) {
                  onConfirm();
                }
              },
            ),
        ],
      );
    },
  );
}
