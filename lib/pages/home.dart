import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';
import '../../pages/note.dart';
import '../components/grid_view.dart';
import '../components/list_view.dart';
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

  void stateFunc() {
    setState(() {
      notes = Hive.box('notes').values.toList();
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
          child: isGridView ? gridView(notes,stateFunc) : listView(notes,stateFunc),
        ));
  }
}
