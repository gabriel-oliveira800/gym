import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

abstract class Helpers {
  static final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  static String generateId() => Uuid().v4();

  static void showSnackBar(String message) {
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
