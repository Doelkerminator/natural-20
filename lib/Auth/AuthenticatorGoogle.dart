import 'package:cloud_firestore/cloud_firestore.dart';
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
        if(!await checkIfDocExists(user!.uid)){
          await createUser(user);
        }
        return user;
      } on FirebaseException catch(e) {
        return null;
      }
    }
  }

  static Future<void> closeSession() async {
    await GoogleSignIn().signOut(); 
    await FirebaseAuth.instance.signOut();
  }

  static Future<bool> checkIfDocExists(String docId) async {
    try {
      CollectionReference collection = FirebaseFirestore.instance.collection('usuarios');
      var doc = await collection.doc(docId).get();
      return doc.exists;
    } catch (e) {
      throw e;
    }
  }

  static Future<void> createUser(User user) async {
    CollectionReference newUser = FirebaseFirestore.instance.collection('usuarios');
    await newUser.doc(user.uid).set({
      "name": user.displayName,
      "email": user.email,
      "photo": user.photoURL,
      "provider": user.providerData[0].providerId,
      "uid": user.uid,
      "characters": []
    });
  }
}