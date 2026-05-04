class DateHelper {
  const DateHelper._();

  static DateTime startOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }
}
