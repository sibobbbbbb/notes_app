import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'login.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();

class Profile extends StatefulWidget {
  final User? user;
  final FirebaseAuth auth;

  const Profile({super.key, required this.user, required this.auth});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF252525),
      appBar: AppBar(
        title: const Text("Profile",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 27,
                color: Colors.white)),
        backgroundColor: const Color(0xFF3B3B3B),
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 40),
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(widget.user!.photoURL!),
                        fit: BoxFit.cover)),
              ),
            ),
            const Divider(
              height: 100,
            ),
            const Text(
              'NAME',
              style: TextStyle(
                  color: Colors.white, letterSpacing: 2.0, fontSize: 15),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '  ${widget.user?.email?.split('@')[0]}',
              style: TextStyle(
                color: Colors.amberAccent[200],
                letterSpacing: 2.0,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'PHONE NUMBER',
              style: TextStyle(
                  color: Colors.white, letterSpacing: 2.0, fontSize: 15),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '  ${widget.user?.phoneNumber}',
              style: TextStyle(
                color: Colors.amberAccent[200],
                letterSpacing: 2.0,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                const Icon(
                  Icons.email,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  '${widget.user?.email}',
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Center(
                  child: MaterialButton(
                hoverColor: Colors.red[700],
                height: 50,
                minWidth: 150,
                color: Colors.red,
                onPressed: () async {
                  // await googleSignIn.disconnect();
                  await googleSignIn.signOut();
                  await widget.auth.signOut();

                  Hive.close();

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: const Text("Sign Out"),
              )),
            )
          ],
        ),
      ),
    );
  }
}
