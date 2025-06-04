import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

class MyLogger {
  static const _ansiReset = '\x1B[0m';
  static const _ansiRed = '\x1B[91m'; // Bright red
  static const _ansiGreen = '\x1B[92m'; // Bright green
  static const _ansiYellow = '\x1B[93m'; // Bright yellow
  static const _ansiBlue = '\x1B[94m'; // Bright blue

  static void debug(String message) {
    _log(message, level: 500, name: 'DEBUG', color: _ansiBlue);
  }

  static void info(String message) {
    _log(message, level: 800, name: 'INFO', color: _ansiGreen);
  }

  static void warning(String message) {
    _log(message, level: 900, name: 'WARNING', color: _ansiYellow);
  }

  static void error(String message) {
    _log(message, level: 1000, name: 'ERROR', color: _ansiRed);
  }

  static void _log(String message,
      {required int level, required String name, required String color}) {
    final coloredMessage = '$color$message$_ansiReset';
    if (kDebugMode) {
      print(coloredMessage);
    }
    // Print the colored message to the console
    // developer.log(message,
    //     level: level,
    //     name: name); // Log the message without colors for developer tools
  }
}
