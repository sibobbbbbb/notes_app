import 'package:intl/intl.dart';
import 'package:hive/hive.dart';
part 'note_object.g.dart';

@HiveType(typeId: 0)
class Note extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String content;
  @HiveField(2)
  String lastUpdate;

  Note({
    required this.title,
    required this.content,
    required this.lastUpdate,
  });
}

String getFormattedDate(int daysAgo) {
  final now = DateTime.now();
  final date = now.subtract(Duration(days: daysAgo));
  if (daysAgo == 0) return 'Today';
  if (daysAgo == 1) return 'Yesterday';
  return DateFormat('yyyy-MM-dd').format(date);
}

void tempDataNote(Box box) async {
  final List<Note> notes = [
    Note(
      title: 'Game Design Document',
      content: 'Game document for "Rocket Game" including mechanics, etc.',
      lastUpdate: getFormattedDate(0),
    ),
    Note(
      title: 'Resource 3D Asset for Exploration',
      content: 'This is a link for free asset 3D Design.',
      lastUpdate: getFormattedDate(1),
    ),
    Note(
      title: 'To do List Friday',
      content: 'My list activities for this Friday: Work, Design Exploration, Playing PlayStation 1.',
      lastUpdate: getFormattedDate(2),
    ),
    Note(
      title: 'My First Animation 3D Object',
      content: 'This is my first 3D animation. It is about animation and designing the 3D effect.',
      lastUpdate: getFormattedDate(3),
    ),
    Note(
      title: 'My Security Key of Wallet Crypto',
      content: 'This is the security key of my wallet crypto.',
      lastUpdate: getFormattedDate(4),
    ),
  ];

  for (var note in notes) {
    box.add(note);
  }
}

