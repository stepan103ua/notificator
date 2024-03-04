import 'package:notificator/core/data/models/time.dart';

abstract class ValidationUtils {
  static String? validateTitle(String? title) {
    if (title == null || title.isEmpty) {
      return 'Title cannot be empty';
    }
    return null;
  }

  static String? validateDate(DateTime? date) {
    if (date == null) {
      return 'Date cannot be empty';
    }

    if (date.isBefore(DateTime.now())) {
      return 'Date cannot be in the past';
    }

    return null;
  }

  static String? validateTime(Time? time) {
    if (time == null) {
      return 'Time cannot be empty';
    }
    return null;
  }
}
