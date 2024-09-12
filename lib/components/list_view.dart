import 'package:flutter/material.dart';
import '../pages/note.dart';
import '../utils/get_last_update.dart';
import 'notes_color.dart';

Widget listView(List<dynamic> notes, Function setState) {
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

                setState();
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
                      Text(
                        notes[index].content!.length > 100
                            ? '${notes[index].content!.substring(0, 100)}...'
                            : notes[index].content!,
                      ),
                    ],
                  ))),
        );
      });
}