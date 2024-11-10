import 'dart:developer' as dev;

class LogManager {
  static bool isInDevelopment = false;
  static void log({
    String head = '',
    required String msg,
  }) {
    if (isInDevelopment) {
      if (head.isEmpty) {
        dev.log(msg);
      } else {
        dev.log('[$head] $msg');
      }
    } else {
      if (head.isEmpty) {
        dev.log(msg);
      } else {
        dev.log('[$head] Log Wont work because app is not in development');
      }
    }
  }
}
