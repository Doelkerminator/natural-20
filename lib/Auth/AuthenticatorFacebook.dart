import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthenticatorFacebook{
  static Future<User?> initSession({required BuildContext context}) async {
    User? user;
    try {
      final LoginResult result = await FacebookAuth.instance.login(permissions: (['email', 'public_profile']));
      final token = result.accessToken!.token;
      final graphResponse = await http.get(Uri.parse('https://graph.facebook.com/'
          'v2.12/me?fields=name,first_name,last_name,email&access_token=${token}'));
      try {
        final AuthCredential facebookCredential = FacebookAuthProvider.credential(result.accessToken!.token);
        final userCredential = await FirebaseAuth.instance.signInWithCredential(facebookCredential);
        user = userCredential.user;
        if(!await checkIfDocExists(user!.uid)){
          await createUser(user);
        }
        return user;
      }catch(e){ return null; }
    } catch (e) { return null; }
  }

  static Future<void> closeSession() async {
    await FacebookAuth.instance.logOut(); 
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
      "characters": {}
    });
  }
}