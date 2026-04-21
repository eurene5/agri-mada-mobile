import 'package:flutter/material.dart';

abstract final class AppLogger {
  static void debug(String message, {Object? error, StackTrace? stackTrace}) {
    assert(() {
      debugPrint('[DEBUG] $message');
      if (error != null) debugPrint('[ERROR] $error');
      if (stackTrace != null) debugPrint('[STACK] $stackTrace');
      return true;
    }());
  }

  static void error(
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    assert(() {
      debugPrint('[ERROR] $message — $error');
      if (stackTrace != null) debugPrint('[STACK] $stackTrace');
      return true;
    }());
  }

  static void info(String message) {
    assert(() {
      debugPrint('[INFO] $message');
      return true;
    }());
  }
}
