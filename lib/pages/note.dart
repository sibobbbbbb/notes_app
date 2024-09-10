import 'package:flutter/material.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Note"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Toolbar for formatting text
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
                          {int? currentLength,
                          bool? isFocused,
                          int? maxLength}) {
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: "Title",
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        fontSize: _fontSize,
                        fontWeight:
                            _isBold ? FontWeight.bold : FontWeight.normal,
                        fontStyle:
                            _isItalic ? FontStyle.italic : FontStyle.normal,
                      ),
                    ),
                    const Divider(),
                    TextField(
                      controller: _controller2,
                      maxLines: null,
                      style: TextStyle(
                        fontSize: _fontSize,
                        fontWeight:
                            _isBold ? FontWeight.bold : FontWeight.normal,
                        fontStyle:
                            _isItalic ? FontStyle.italic : FontStyle.normal,
                      ),
                      decoration: const InputDecoration(
                        hintText: "Start typing your note...",
                        border: InputBorder.none,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Display selected image
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
