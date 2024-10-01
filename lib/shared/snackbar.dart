import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import 'router.dart';

showAppSnack(String message,
    {SNACKBARTYPE snackbartype = SNACKBARTYPE.normal, Duration? duration}) {
  try {
    return Flushbar(
      message: message,
      icon: Icon(
        Icons.info_outline,
        size: 28.0,
        color: _getIconColor(snackbartype),
      ),
      backgroundColor: _getColor(snackbartype),
      duration: duration ?? const Duration(seconds: 3),
      leftBarIndicatorColor: _getIconColor(snackbartype),
    ).show(appRouter.configuration.navigatorKey.currentContext!);
  } catch (e) {
    debugPrint(e.toString());
  }
}

Color _getIconColor(SNACKBARTYPE snackbartype) {
  switch (snackbartype) {
    case SNACKBARTYPE.error:
      return Colors.grey.shade200;
    default:
      return const Color(0xffFEF7F3);
  }
}

Color _getColor(SNACKBARTYPE snackbartype) {
  switch (snackbartype) {
    case SNACKBARTYPE.error:
      return Colors.red.shade700;
    default:
      return Colors.black;
  }
}

enum SNACKBARTYPE {
  normal,
  error,
}
