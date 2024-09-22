import 'package:firebase_auth/firebase_auth.dart';
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

Future<Box?> openUserBox(User? user) async {
  String? email = user?.email;
  if (email != null) {
    Box userBox = await Hive.openBox(email);
    if (userBox.isEmpty) {
      Map<String, dynamic> userData = {
        "displayName": user?.displayName,
        "email": user?.email,
        "photoURL": user?.photoURL,
      };
      List<Note> notes = [];
      await userBox.put("userData", userData);
      await userBox.put("notes", notes);
    }
    return userBox;
  }
  return null;
}

void addNoteToBox(User? user, Note note) async {
  print("masuk sini");
  List? notes = getUserNotes(user);

  notes ??= [];

  notes.add(note);
  String? email = user?.email;

  if (email != null) {
    print("nge add");
    Box userBox = Hive.box(email);
    await userBox.put('notes', notes);
  }
}

List<dynamic>? getUserNotes(User? user) {
  String? email = user?.email;
  Box? userBox = email != null ? Hive.box(email) : null;

  if (userBox == null || userBox.get("notes") == null) {
    return [];
  }

  List<dynamic> notes = userBox.get("notes");
  return notes;
}
