import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cubit_test/repositories/models/book.dart';

class TradeOrder {
  final String id;
  final Book giving;
  final Book taking;
  final String date;

  String get timePassed {
    // Parse the timestamp string into a DateTime object
    DateTime timestamp = DateTime.parse(date);

    // Get the current time
    DateTime now = DateTime.now();

    // Calculate the difference between the current time and the timestamp
    Duration difference = now.difference(timestamp);

    // Calculate the difference in hours, minutes, and seconds
    int hours = difference.inHours;
    int minutes = difference.inMinutes.remainder(60);
    int seconds = difference.inSeconds.remainder(60);

    // Format the result into a string
    String result = '';
    if (hours > 0) {
      result += '$hours hours ';
    }
    if (minutes > 0 || hours > 0) {
      result += '$minutes minutes ';
    }
    result += '$seconds seconds ago';

    return result;
  }

  TradeOrder(
      {required this.id,
      required this.giving,
      required this.taking,
      required this.date});
}
