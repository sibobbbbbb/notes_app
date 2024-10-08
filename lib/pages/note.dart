import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../database/note_object.dart';

class NotePage extends StatefulWidget {
  final Note note;
  final User? user;

  const NotePage({super.key, required this.note, required this.user});

  @override
  State<NotePage> createState() => _NotePage();
}

class _NotePage extends State<NotePage> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  bool _isBold = false;
  bool _isItalic = false;
  double _fontSize = 16.0;

  @override
  void initState() {
    super.initState();
    _controller1.text = widget.note.title;
    _controller2.text = widget.note.content;
  }

  Future<bool> _onWillPop() async {
    if (_controller1.text.isEmpty && _controller2.text.isEmpty) {
      await widget.note.delete();
      return true;
    }

    if (_controller1.text != widget.note.title ||
        _controller2.text != widget.note.content) {
      var isNew = widget.note.title.isEmpty && widget.note.content.isEmpty;
      widget.note.title = _controller1.text;
      widget.note.content = _controller2.text;
      widget.note.lastUpdate = DateFormat('yyyy-MM-dd').format(DateTime.now());

      if (isNew) {
        addNoteToBox(widget.user,widget.note);
      } else {
        await widget.note.save();
      }
    }
    return true;
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Note"),
          content: const Text("Are you sure you want to delete this note?"),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text("Delete"),
              onPressed: () async {
                deleteNoteFromBox(widget.user, widget.note);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (popDisposition) async {
        await _onWillPop();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF252525),
        appBar: AppBar(
          title: const Text("Create Note", style: TextStyle(fontSize: 20)),
          backgroundColor: const Color(0xFF252525),
          iconTheme: const IconThemeData(color: Colors.white),
          titleTextStyle: const TextStyle(color: Colors.white),
          actions: [
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                _showDeleteConfirmationDialog(context);
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: const Icon(Icons.format_bold),
                    onPressed: () {
                      setState(() {
                        _isBold = !_isBold;
                      });
                    },
                    color: _isBold ? Colors.blue : Colors.white,
                  ),
                  IconButton(
                    icon: const Icon(Icons.format_italic),
                    onPressed: () {
                      setState(() {
                        _isItalic = !_isItalic;
                      });
                    },
                    color: _isItalic ? Colors.blue : Colors.white,
                  ),
                  DropdownButton<double>(
                    dropdownColor: const Color(0xFF252525),
                    value: _fontSize,
                    items: [16, 18, 20, 24].map((size) {
                      return DropdownMenuItem<double>(
                        value: size.toDouble(),
                        child: Text(
                          size.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    }).toList(),
                    onChanged: (double? newSize) {
                      setState(() {
                        _fontSize = newSize!;
                      });
                    },
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Title dan description text fields
                      TextField(
                        controller: _controller1,
                        maxLength: 30,
                        buildCounter: (BuildContext context,
                            {int? currentLength,
                              bool? isFocused,
                              int? maxLength}) {
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: "Title",
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.white60),
                        ),
                        style: TextStyle(
                          fontSize: _fontSize,
                          fontWeight: _isBold ? FontWeight.bold : FontWeight.normal,
                          fontStyle: _isItalic ? FontStyle.italic : FontStyle.normal,
                          color: Colors.white,
                        ),
                      ),
                      const Divider(color: Colors.white60),
                      TextField(
                        controller: _controller2,
                        maxLines: null,
                        style: TextStyle(
                          fontSize: _fontSize,
                          fontWeight: _isBold ? FontWeight.bold : FontWeight.normal,
                          fontStyle: _isItalic ? FontStyle.italic : FontStyle.normal,
                          color: Colors.white,
                        ),
                        decoration: const InputDecoration(
                          hintText: "Start typing your note...",
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.white60),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
