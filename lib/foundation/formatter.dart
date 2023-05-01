import 'package:intl/intl.dart';

class Formatter {
  static formatDouble(double? value, {int fixed = 2}) {
    return value != null ? value.toStringAsFixed(fixed) : '-';
  }

  static String formatDate(DateTime date, {String? format}) {
    return DateFormat(format ?? 'yyyy.MM.dd HH:mm:ss').format(date.toLocal());
  }

  static String formatTimeline(int timestamp, {bool alwaysShowDetail = false, String languageCode = 'zh'}) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);

    var today = DateTime.now();

    var standardDate = DateTime(today.year, today.month, today.day, 23, 59, 59);
    // The incoming date is compared with today's 23:59:59
    Duration diff = standardDate.difference(date);

    if (diff < const Duration(days: 1)) {
      return _format('HH:mm:ss', date);
    }

    if (diff >= const Duration(days: 1) && diff < const Duration(days: 2)) {
      if (languageCode == 'en') {
        return 'Yesterday ' + _format('HH:mm:ss', date);
      } else {
        return _format('昨天 HH:mm:ss', date);
      }
    }

    if (date.year == today.year) {
      if (languageCode == 'en') {
        return _format((alwaysShowDetail ? 'MM/dd HH:mm:ss' : 'MM/dd'), date);
      } else {
        return _format((alwaysShowDetail ? 'MM月dd日 HH:mm:ss' : 'MM月dd日'), date);
      }
    } else {
      if (languageCode == 'en') {
        return _format((alwaysShowDetail ? 'MM/dd/yyyy HH:mm:ss' : 'MM/dd/yyyy'), date);
      } else {
        return _format((alwaysShowDetail ? 'yyyy年MM月dd日 HH:mm:ss' : 'yyyy年MM月dd日'), date);
      }
    }
  }

  static String _format(String format, DateTime date) {
    return DateFormat(format).format(date.toLocal());
  }

  static String formatTimestamp(int? timestamp, {String? format}) {
    if (timestamp == null) {
      return '';
    }
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return Formatter.formatDate(date, format: format);
  }

  static String formatDuration(int seconds) {
    int hour = (seconds - (seconds % 3600)) ~/ 3600;
    int minute = (seconds - (seconds % 60)) ~/ 60;
    int second = (seconds - minute * 60);

    if (hour > 0) {
      return '${_formatTime(hour)}:${_formatTime(minute)}:${_formatTime(second)}';
    } else {
      return '${_formatTime(minute)}:${_formatTime(second)}';
    }
  }

  static String _formatTime(int time) {
    if (time < 10) {
      return '0$time';
    }
    return time.toString();
  }
}
