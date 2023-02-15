import 'package:logger/logger.dart';

class ConsoleMessages {
  static final logger = Logger(printer: PrettyPrinter());

  static void showErrorMessage(dynamic message) => logger.e(message);

  static void showSuccessMessage(dynamic message) => logger.i(message);

  static void showDebugMessage(dynamic message) => logger.d(message);
}