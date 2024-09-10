import 'package:flutter/material.dart';

List<Widget> actionsAppbarHome() {
  return <Widget>[
    Container(
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[200],
      ),
      child: IconButton(
        color: Colors.black,
        icon: const Icon(Icons.search),
        onPressed: () {
          print('Search');
        },
      ),
    ),
    const SizedBox(width: 15),
    Container(
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[200],
      ),
      child: IconButton(
        color: Colors.black,
        icon: const Icon(Icons.grid_view),
        onPressed: () {
          print('More');
        },
      ),
    ),
    const SizedBox(width: 10),
  ];
}
