import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notes_app/components/home/body_home.dart';
import '../components/home/title_appbar_home.dart';
import '../components/home/actions_appbar_home.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: titleAppbarHome(),
        actions: actionsAppbarHome(),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: bodyHome(),
    );
  }
}
