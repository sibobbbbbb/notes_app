import 'package:intl/intl.dart';
import '../database/note_object.dart';

String getLastUpdate(Note note) {
  DateTime inputDate = DateFormat('yyyy-MM-dd').parse(note.lastUpdate);
  DateTime yesterday = DateTime.now().subtract(const Duration(days: 1));
  DateTime today = DateTime.now();
  if (inputDate.day == today.day &&
      inputDate.month == today.month &&
      inputDate.year == today.year) {
    return 'Today';
  } else if (inputDate.day == yesterday.day &&
      inputDate.month == yesterday.month &&
      inputDate.year == yesterday.year) {
    return 'Yesterday';
  } else {
    return note.lastUpdate;
  }
}