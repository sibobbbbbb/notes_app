import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../pages/note.dart';
import '../utils/get_last_update.dart';
import 'notes_color.dart';

Widget gridView(User? user,List<dynamic> notes, Function setState) {
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
                    builder: (context) => NotePage(note: notes[index], user: user,)));

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
            ),
          ),
        ),
      );
    },
  );
}