import 'package:intl/intl.dart';

import '../../features/chat/domain/entity/message_entity.dart';

class DateFormater {
  static String getTime(MessageEntity message) {
    final DateTime sendingTime = DateTime.parse(message.sendingTime);
    // final DateFormat inputFormat = DateFormat('yyy-MM-dd HH:mm:ss.SSSSSS');
    final DateFormat outputFormat = DateFormat('h:mm a');
    // final DateTime dateTime = inputFormat.parse(sendingTime);
    final String finalTime = outputFormat.format(sendingTime);
    return finalTime;
  }

  static String formatTime(Duration duration) {
    String twoDigits(int number) => number.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }

  static String formatPostTime(String date) {
    var postingTime = DateTime.parse(date);
    var formatedPostingTime = DateFormat('d MMMM hh:mma').format(postingTime);
    return formatedPostingTime;
  }

  static String formatDateTimeToRelative(String dateTimeString) {
    final dateTime = DateTime.parse(dateTimeString);
    final now = DateTime.now();

    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays}d';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    } else {
      return 'Just now';
    }
  }
}
