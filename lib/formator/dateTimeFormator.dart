import 'package:intl/intl.dart';

class Formator{
   String formatTime(String dateTimeString) {
      
      final inputFormat = DateFormat("yyyy-MM-dd HH:mm:ssZ");
      final inputDate = inputFormat.parse(dateTimeString);

      
      final dayOfWeekFormat = DateFormat.EEEE('en_US');
      final timeFormat = DateFormat.jm('en_US');

      
      final dayOfWeek = dayOfWeekFormat.format(inputDate);

      
      final startTime = timeFormat.format(inputDate);
      
      final endTime =
          timeFormat.format(inputDate.add(const Duration(hours: 3)));

      
      final formattedDate = '$dayOfWeek $startTime - $endTime';

      return formattedDate;
    }

    String formatDate(String dateTimeString) {
      
      final inputFormat = DateFormat("yyyy-MM-dd HH:mm:ssZ");
      final inputDate = inputFormat.parse(dateTimeString);

      
      final outputFormat = DateFormat("d MMMM yyyy", 'en_US');

      
      final formattedDate = outputFormat.format(inputDate);

      return formattedDate;
    }

    String formatDateTime(String dateTimeString) {
      final inputFormat = DateFormat("yyyy-MM-dd HH:mm:ss.SSS'Z'");
      final inputDate = inputFormat.parse(dateTimeString);

      final localDate = inputDate.toLocal();

      final outputFormat = DateFormat("E, MMMM d h:mm a");

      final formattedDate = outputFormat.format(localDate);

      return formattedDate;
    }
}