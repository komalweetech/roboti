import 'package:intl/intl.dart';

extension DateFormatterExtension on DateTime {
  String toHHMMA() {
    return DateFormat("hh:mm a").format(this);
  }

  String toDDMMMYYYY() {
    return DateFormat("dd MMM yyyy").format(this);
  }

  bool isAtSameMomentOrIsAfter(DateTime date) {
    return isAfter(date) || isAtSameMomentAs(date);
  }

  bool isAtSameMomentOrIsBefore(DateTime date) {
    return isBefore(date) || isAtSameMomentAs(date);
  }
}

extension DateFormatExtension on String {
  String toDDMMYYYYHHMM() {
    return DateFormat("dd MMM yyyy, hh:mm a")
        .format(DateTime.parse(this).toLocal());
  }
}
