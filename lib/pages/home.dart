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
  bool isSearching = false;
  bool isAnimating = false;
  final TextEditingController searchController = TextEditingController();

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
    notes.sort((a, b) => b.lastUpdate.compareTo(a.lastUpdate));
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
                AnimatedContainer(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  duration: const Duration(milliseconds: 300),
                  width: isSearching ? 52 : 213,
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 23,
                        backgroundImage: AssetImage('assets/images/SiBoB.png'),
                      ),
                      if (!isSearching && !isAnimating)
                        const SizedBox(width: 15),
                      if (!isSearching && !isAnimating)
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
                      if (!isSearching && !isAnimating)
                        const SizedBox(width: 25),
                    ],
                  ),
                ),
                if (!isSearching)
                  const SizedBox(width: 37)
                else
                  const SizedBox(width: 13),
                if (!isSearching)
                  Container(
                    padding: const EdgeInsets.all(1),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xFF3B3B3B)),
                    child: IconButton(
                      color: Colors.white,
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        setState(() {
                          isSearching = !isSearching;
                        });
                      },
                    ),
                  )
                else
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Search notes...",
                        hintStyle: const TextStyle(color: Colors.black45),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                      ),
                      style: const TextStyle(color: Colors.black),
                      onChanged: (value) {
                        setState(() {
                          notes = noteBox.values
                              .where((note) =>
                                  note.title
                                      .toString()
                                      .toLowerCase()
                                      .contains(value.toLowerCase()) ||
                                  note.content
                                      .toString()
                                      .toLowerCase()
                                      .contains(value.toLowerCase()))
                              .toList();
                        });
                      },
                    ),
                  ),
                if (isSearching)
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      if (isSearching) {
                        setState(() {
                          isSearching = false;
                          isAnimating = true;
                          searchController.clear();
                          stateFunc();
                        });

                        Future.delayed(const Duration(milliseconds: 300), () {
                          setState(() {
                            isAnimating = false;
                          });
                        });
                      } else {
                        setState(() {
                          isSearching = true;
                        });
                      }
                    },
                  ),
              ],
            ),
          ),
          actions: <Widget>[
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: DropdownButton(
                    icon: const Icon(Icons.sort),
                    alignment: Alignment.center,

                    borderRadius: BorderRadius.circular(30),
                    hint: const Text('Sort by',
                        style: TextStyle(color: Colors.white)),
                    items: const [
                      DropdownMenuItem(
                        value: 'A-Z',
                        child: Text('Sort by A-Z'),
                      ),
                      DropdownMenuItem(
                        value: 'Z-A',
                        child: Text('Sort by Z-A'),
                      ),
                      DropdownMenuItem(
                        value: 'newest',
                        child: Text('Sort by Newest'),
                      ),
                      DropdownMenuItem(
                        value: 'oldest',
                        child: Text('Sort by Oldest'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        switch (value) {
                          case 'A-Z':
                            notes.sort((a, b) => a.title.compareTo(b.title));
                            break;
                          case 'Z-A':
                            notes.sort((a, b) => b.title.compareTo(a.title));
                            break;
                          case 'newest':
                            notes.sort(
                                (a, b) => b.lastUpdate.compareTo(a.lastUpdate));
                            break;
                          case 'oldest':
                            notes.sort(
                                (a, b) => a.lastUpdate.compareTo(b.lastUpdate));
                            break;
                        }
                      });
                    }),
              ),
              const SizedBox(height: 15),
              Expanded(
                  child: isGridView
                      ? gridView(notes, stateFunc)
                      : listView(notes, stateFunc)),
            ],
          ),
        ));
  }
}
