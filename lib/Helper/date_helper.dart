class DateHelper {
  static int getThirtyDaysAgo() {
    return DateTime.now().subtract(const Duration(days: 30)).millisecondsSinceEpoch;
  }

  static int getOneYearAgo() {
    return DateTime.now().subtract(const Duration(days: 365)).millisecondsSinceEpoch;
  }

  static String formatTimestamp(int timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp).toString();
  }
}