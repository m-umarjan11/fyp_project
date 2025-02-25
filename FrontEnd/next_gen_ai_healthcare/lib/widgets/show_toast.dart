import 'dart:ui';

import 'package:fluttertoast/fluttertoast.dart';

void showToastMessage(String message) {
  Fluttertoast.showToast(
    msg: message,
    backgroundColor: const Color(0xFFFF9800).withOpacity(0.3),
    gravity: ToastGravity.BOTTOM,

  );
}
