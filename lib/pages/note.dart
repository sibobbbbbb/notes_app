import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../database/note_object.dart';

class NotePage extends StatefulWidget {
  final Note note;
  const NotePage({super.key, required this.note});

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
    if (_controller1.text != widget.note.title || _controller2.text != widget.note.content) {
      widget.note.title = _controller1.text;
      widget.note.content = _controller2.text;
      widget.note.lastUpdate = DateFormat('yyyy-MM-dd').format(DateTime.now());

      await widget.note.save();
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (popDisposition) async {
        await _onWillPop();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Create Note"),
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
                    color: _isBold ? Colors.blue : Colors.black,
                  ),
                  IconButton(
                    icon: const Icon(Icons.format_italic),
                    onPressed: () {
                      setState(() {
                        _isItalic = !_isItalic;
                      });
                    },
                    color: _isItalic ? Colors.blue : Colors.black,
                  ),
                  DropdownButton<double>(
                    value: _fontSize,
                    items: [16, 18, 20, 24].map((size) {
                      return DropdownMenuItem<double>(
                        value: size.toDouble(),
                        child: Text(size.toString()),
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
                      // Title and description text fields
                      TextField(
                        controller: _controller1,
                        maxLength: 30,
                        buildCounter: (BuildContext context,
                            {int? currentLength, bool? isFocused, int? maxLength}) {
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: "Title",
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          fontSize: _fontSize,
                          fontWeight: _isBold ? FontWeight.bold : FontWeight.normal,
                          fontStyle: _isItalic ? FontStyle.italic : FontStyle.normal,
                        ),
                      ),
                      const Divider(),
                      TextField(
                        controller: _controller2,
                        maxLines: null,
                        style: TextStyle(
                          fontSize: _fontSize,
                          fontWeight: _isBold ? FontWeight.bold : FontWeight.normal,
                          fontStyle: _isItalic ? FontStyle.italic : FontStyle.normal,
                        ),
                        decoration: const InputDecoration(
                          hintText: "Start typing your note...",
                          border: InputBorder.none,
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
