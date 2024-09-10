import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';

String getFormattedDate(int daysAgo) {
  final now = DateTime.now();
  final date = now.subtract(Duration(days: daysAgo));
  if (daysAgo == 0) return 'Today';
  if (daysAgo == 1) return 'Yesterday';
  return DateFormat('yyyy-MM-dd').format(date);
}

void addRandomIsPinned(List<Map<String, dynamic>> notes) {
  final random = Random();
  for (var note in notes) {
    note['isPinned'] = random.nextBool();
  }
}

final List<Map<String, dynamic>> notes = [
  {
    'title': 'Game Design Document',
    'description': 'Game document for "Rocket Game" including mechanics, etc.',
    'lastUpdate': getFormattedDate(0),
  },
  {
    'title': 'Resource 3D Asset for Exploration',
    'description': 'This is a link for free asset 3D Design.',
    'lastUpdate': getFormattedDate(1),
  },
  {
    'title': 'To do List Friday',
    'description': 'My list activities for this Friday: Work, Design Exploration, Playing PlayStation 1.',
    'lastUpdate': getFormattedDate(2),
  },
  {
    'title': 'My First Animation 3D Object',
    'description': 'This is my first 3D animation. It is about animation and designing the 3D effect.',
    'lastUpdate': getFormattedDate(3),
  },
  {
    'title': 'My Security Key of Wallet Crypto',
    'description': 'This is the security key of my wallet crypto.',
    'lastUpdate': getFormattedDate(4),
  },
  {
    'title': 'Game Design Document',
    'description': 'Game document for "Rocket Game" including mechanics, etc.',
    'lastUpdate': getFormattedDate(5),
  },
  {
    'title': 'Resource 3D Asset for Exploration',
    'description': 'This is a link for free asset 3D Design.',
    'lastUpdate': getFormattedDate(6),
  },
  {
    'title': 'To do List Friday',
    'description': 'My list activities for this Friday: Work, Design Exploration, Playing PlayStation 1.',
    'lastUpdate': getFormattedDate(7),
  },
  {
    'title': 'My First Animation 3D Object',
    'description': 'This is my first 3D animation. It is about animation and designing the 3D effect.',
    'lastUpdate': getFormattedDate(8),
  },
  {
    'title': 'My Security Key of Wallet Crypto',
    'description': 'This is the security key of my wallet crypto.',
    'lastUpdate': getFormattedDate(9),
  },
  {
    'title': 'My First Animation 3D Object',
    'description': 'This is my first 3D animation. It is about animation and designing the 3D effect.',
    'lastUpdate': getFormattedDate(10),
  },
  {
    'title': 'My Security Key of Wallet Crypto',
    'description': 'This is the security key of my wallet crypto.',
    'lastUpdate': getFormattedDate(11),
  },
  {
    'title': 'To do List Friday',
    'description': 'My list activities for this Friday: Work, Design Exploration, Playing PlayStation 1.',
    'lastUpdate': getFormattedDate(12),
  },
  {
    'title': 'My First Animation 3D Object',
    'description': 'This is my first 3D animation. It is about animation and designing the 3D effect.',
    'lastUpdate': getFormattedDate(13),
  },
  {
    'title': 'My Security Key of Wallet Crypto',
    'description': 'This is the security key of my wallet crypto.',
    'lastUpdate': getFormattedDate(14),
  },
  {
    'title': 'My First Animation 3D Object',
    'description': 'This is my first 3D animation. It is about animation and designing the 3D effect.',
    'lastUpdate': getFormattedDate(15),
  },
  {
    'title': 'My Security Key of Wallet Crypto',
    'description': 'This is the security key of my wallet crypto.',
    'lastUpdate': getFormattedDate(16),
  },
];

Widget bodyHome() {
  return Padding(
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: notes[index]['lastUpdate']!,
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
                  notes[index]['title']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Text(notes[index]['description']!),
              ],
            ),
          ),
        );
      },
    ),
  );
}