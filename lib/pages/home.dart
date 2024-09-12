import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
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
  bool isGridView = true;
  static const List<String> color = [
    "FD99FF",
    "FF9E9E",
    "91F48F",
    "FFF599",
    "9EFFFF",
    "B69CFF"
  ];

  Widget gridView(List<dynamic> notes) {
    return MasonryGridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      itemCount: notes.length,
      itemBuilder: (context, index) {
        return Card(
          color: Color(int.parse('0xFF${color[index % color.length]}')),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: InkWell(
            onTap: () async {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NotePage(note: notes[index])));

              setState(() {
                notes = Hive.box('notes').values.toList();
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
    );
  }

  Widget listView(List<dynamic> notes) {
    return ListView.builder(
        itemCount: notes.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: Color(int.parse('0xFF${color[index % color.length]}')),
            child: InkWell(
                onTap: () async {
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotePage(note: notes[index])));

                  setState(() {
                    notes = Hive.box('notes').values.toList();
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
                    ))),
          );
        });
  }

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
        backgroundColor: const Color(0xFF252525),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFF252525),
          title: Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 23,
                        backgroundImage: AssetImage('assets/images/SiBoB.png'),
                      ),
                      const SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Farhan Raditya',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${notes.length} Notes',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 25),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Container(
              padding: const EdgeInsets.all(1),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xFF3B3B3B)),
              child: IconButton(
                color: Colors.white,
                icon: const Icon(Icons.search),
                onPressed: () {
                  // print('Search');
                },
              ),
            ),
            const SizedBox(width: 15),
            Container(
              padding: const EdgeInsets.all(1),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF3B3B3B),
              ),
              child: IconButton(
                color: Colors.white,
                icon: isGridView
                    ? const Icon(Icons.grid_view)
                    : const Icon(Icons.list),
                onPressed: () {
                  setState(() {
                    isGridView = !isGridView;
                  });
                },
              ),
            ),
            const SizedBox(width: 10),
          ],
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NotePage(
                            note: Note(
                          title: '',
                          content: '',
                          lastUpdate:
                              DateFormat('yyyy-MM-dd').format(DateTime.now()),
                        ))));
            setState(() {
              notes = Hive.box('notes').values.toList();
            });
          },
          backgroundColor: const Color(0xFF3B3B3B),
          child: const Icon(color: Colors.white, Icons.add),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: isGridView ? gridView(notes) : listView(notes),
        ));
  }
}
