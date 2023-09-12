import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

hideKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

copyClipBoard(String data) async {
  await Clipboard.setData(ClipboardData(text: data));
  Fluttertoast.cancel();
  Fluttertoast.showToast(msg: "Copied!");
}
