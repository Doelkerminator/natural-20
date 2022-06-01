import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:natural_20/database/database_firestore.dart';

class AuthenticatorGoogle {
  static Future<User?> initSession({required BuildContext context}) async {
    FirebaseAuth authenticator = FirebaseAuth.instance;
    User? user;

    GoogleSignIn objGoogleSignIn = GoogleSignIn();
    GoogleSignInAccount? objGoogleSignInAccount =
        await objGoogleSignIn.signIn();

    if (objGoogleSignInAccount != null) {
      GoogleSignInAuthentication objGoogleSignInAuthentication =
          await objGoogleSignInAccount.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: objGoogleSignInAuthentication.accessToken,
          idToken: objGoogleSignInAuthentication.idToken);
      try {
        UserCredential userCredential =
            await authenticator.signInWithCredential(credential);
        user = userCredential.user;
        if (!await DatabaseFirestore.checkIfDocExists(user!.uid)) {
          await DatabaseFirestore.createUser(user);
        }
        return user;
      } on PlatformException catch (e) {
        return null;
      }
    }
    return null;
  }

  static Future<void> closeSession() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
  }
}
