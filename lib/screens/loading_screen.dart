import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:natural_20/screens/login_screen.dart';
import '../Auth/AuthenticatorFacebook.dart';
import '../Auth/AuthenticatorGoogle.dart';
import '../Auth/AuthenticatorTwittter.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    handleSplashscreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: const [CircularProgressIndicator(), Text("Cerrando Sesión")]
        ),
      )
    );
  }

  void handleSplashscreen() async {
    await closeSession();
    print("object");
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  Future<void> closeSession() async {
    if (FirebaseAuth.instance.currentUser?.providerData[0].providerId ==
        "google.com") {
      await AuthenticatorGoogle.closeSession();
    } else if (FirebaseAuth.instance.currentUser?.providerData[0].providerId ==
        "facebook.com") {
      await AuthenticatorFacebook.closeSession();
    } else if (FirebaseAuth.instance.currentUser?.providerData[0].providerId ==
        "twitter.com") {
      await AuthenticatorTwitter.closeSession();
    }
  }
}
