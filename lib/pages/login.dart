import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:notes_app/pages/home.dart';
import 'package:sign_in_button/sign_in_button.dart';
import '../database/note_object.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((User? userLogin) async {
      if (userLogin != null) {
        Box? box = await openUserBox(userLogin);
        if(box != null)
          {
            Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => Home(
                user: userLogin,
                auth: _auth,
              ),
            ),
            (Route<dynamic> route) => false,
          );
        }
      }
    });
  }

  Widget _signInButton() {
    return SizedBox(
        height: 50,
        child: SignInButton(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          Buttons.google,
          onPressed: _handleGoogleSignIn,
        ));
  }

  Future<void> _handleGoogleSignIn() async {
    try{
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        return;
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _auth.signInWithCredential(credential);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double halfHeightPhone = MediaQuery.of(context).size.height / 2;
    return Scaffold(
      backgroundColor: const Color(0xFF252525),
      body: Padding(
        padding: EdgeInsets.only(top: halfHeightPhone - 100),
        child: Center(
          child: Column(
            children: [
              const Text(
                'Login',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _signInButton(),
            ],
          ),
        ),
      ),
    );
  }
}
