import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticatorGoogle{
  static Future<User?> initSession({required BuildContext context}) async{
    FirebaseAuth authenticator = FirebaseAuth.instance;
    User? user;

    GoogleSignIn objGoogleSignIn = GoogleSignIn();
    GoogleSignInAccount? objGoogleSignInAccount = await objGoogleSignIn.signIn();

    if(objGoogleSignInAccount != null){
      GoogleSignInAuthentication objGoogleSignInAuthentication = await objGoogleSignInAccount.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: objGoogleSignInAuthentication.accessToken,
        idToken: objGoogleSignInAuthentication.idToken
      );
      try{
        UserCredential userCredential = await authenticator.signInWithCredential(credential);
        user = userCredential.user;
        return user;
      } on FirebaseException catch(e) {
        print(e.message);
      }
    }
  }

  static Future<void> closeSession() async {
    await GoogleSignIn().signOut(); 
    await FirebaseAuth.instance.signOut();
  }
}