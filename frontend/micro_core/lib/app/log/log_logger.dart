import 'package:logger/logger.dart';

import './i_log.dart';

class LogLogger implements ILog {
  late Logger _log;

  LogLogger() {
    _log = Logger(
      printer: PrettyPrinter(
          methodCount: 2, // number of method calls to be displayed
          errorMethodCount:
              8, // number of method calls if stacktrace is provided
          lineLength: 120, // width of the output
          colors: true, // Colorful log messages
          printEmojis: true, // Print an emoji for each log message
          printTime: false // Should each log print contain a timestamp
          ),
    );
  }

  @override
  e(String message) {
    _log.e(message);
  }

  @override
  w(String message){
    _log.w(message);
  }
}
