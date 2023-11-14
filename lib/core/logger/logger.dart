import 'package:logger/logger.dart';

final log = Logger(printer: CustomLog());

class CustomLog extends LogPrinter {
  @override
  List<String> log(LogEvent event) {
    final time = PrettyPrinter().getTime(DateTime.now()).substring(0, 8);
    final message = event.message;
    final color = PrettyPrinter.levelColors[event.level];
    final emoji = PrettyPrinter.levelEmojis[event.level];
    final String result = '$emoji|$time| $message';
    if (color != null) {
      return [color(result)];
    }
    return [result];
  }
}
