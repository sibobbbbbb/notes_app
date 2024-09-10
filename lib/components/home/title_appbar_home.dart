import 'package:flutter/material.dart';

Widget titleAppbarHome() {
  return Padding(
    padding: const EdgeInsets.only(top: 2),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(50),
          ),
          child: const Row(
            children: [
              CircleAvatar(
                radius: 23,
                backgroundImage: AssetImage('assets/images/SiBoB.png'),
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Farhan Raditya',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '48 Notes',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 25),
            ],
          ),
        ),
      ],
    ),
  );
}
