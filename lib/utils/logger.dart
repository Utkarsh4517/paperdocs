import 'package:logger/logger.dart';

class LoggerHandler {
  static print(String msg) {
    Logger(printer: PrettyPrinter()).d(msg);
  }
}
