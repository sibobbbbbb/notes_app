import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../components/home/title_appbar_home.dart';
import '../components/home/actions_appbar_home.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hive/hive.dart';
import '../../pages/note.dart';
import '../database/note_object.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Box noteBox;
  List<dynamic> notes = [];

  @override
  void initState() {
    super.initState();
    noteBox = Hive.box('notes');
    notes = noteBox.values.toList();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      notes = noteBox.values.toList();
    });
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: titleAppbarHome(),
          actions: actionsAppbarHome(),
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await Navigator.push(context, MaterialPageRoute(
                builder: (context) => NotePage(note: Note(
                  title: '',
                  content: '',
                  lastUpdate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
                ))
              ));
              setState(() {
                notes = Hive.box('notes').values.toList();
              });
            },
            backgroundColor: Colors.grey[200],
            child: const Icon(Icons.add),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: MasonryGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            itemCount: notes.length,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.grey[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: InkWell(
                  onTap: () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                NotePage(note: notes[index])));

                    setState(() {
                      notes = Hive
                          .box('notes')
                          .values
                          .toList();
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: getLastUpdate(notes[index]),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const TextSpan(
                                text: ' - Last Update',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          notes[index].title!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(notes[index].content!),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }
}
