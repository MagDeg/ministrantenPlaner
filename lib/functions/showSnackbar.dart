import 'package:flutter/material.dart';

class Message {
  static final messangerKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackbar(String? text) {
    if (text == null) return;
    final snackbar = SnackBar(
      content: Text(text),
      backgroundColor: Colors.red,
    );

    messangerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackbar);
  }
}