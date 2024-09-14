import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/pages/home.dart';
import 'package:sign_in_button/sign_in_button.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((User? userLogin) {
      if (userLogin != null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => Home(user: userLogin,auth: _auth,),
          ),
          (Route<dynamic> route) => false,
        );
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

  void _handleGoogleSignIn() {
    try {
      GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
      _auth.signInWithProvider(googleAuthProvider);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Widget displayUser() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(_user!.photoURL!),
              ),
            ),
          ),
          Text(_user!.email!),
          Text(_user!.displayName ?? ""),
          MaterialButton(
            color: Colors.red,
            onPressed: _auth.signOut,
            child: const Text("Sign Out"),
          )
        ],
      ),
    );
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
