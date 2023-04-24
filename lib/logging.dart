import 'package:logger/logger.dart';

final logger = Logger(printer: CustomPrinter());

class CustomPrinter extends LogPrinter {
  @override
  List<String> log(LogEvent event) {
    final message = event.message;

    return [("$message")];
  }
}
