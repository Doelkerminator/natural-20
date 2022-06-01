import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twitter_login/twitter_login.dart';

import '../database/database_firestore.dart';

class AuthenticatorTwitter {
  /*static Future<User?> initSession({required BuildContext context}) async {
    User? user;
    
    final twitterLogin = TwitterLogin(
        apiKey: '',
        apiSecretKey: '1518494290288070656-Csv9abM6yBvxe12Ow7Fr9e6MMXJlPH',
        redirectURI: 'natural-20://'
    );

    // Trigger the sign-in flow
    await twitterLogin.login().then((value) async {

      final twitterAuthCredential = TwitterAuthProvider.credential(
        accessToken: value.authToken!,
        secret: value.authTokenSecret!,
      );

      
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(twitterAuthCredential);
      user = userCredential.user;
      if(!await DatabaseFirestore.checkIfDocExists(user!.uid)){
          await DatabaseFirestore.createUser(user!);
        }
      return user;
    });
    return null;
  }*/

  static Future<User?> initSession({required BuildContext context}) async {
    User? user;
    try{
      final twitterLogin = TwitterLogin(
        apiKey: 'Uc23KTmvskxqBkMCujiOnUpzD',
        apiSecretKey: 'LnD8PUGbzECDJROXeQoEPx1DRDkvdOWv8X0yuOgLir7mi2xnM4',
        redirectURI: 'natural-20://'
    );

    // Trigger the sign-in flow
    final authResult = await twitterLogin.login();

    // Create a credential from the access token
    final twitterAuthCredential = TwitterAuthProvider.credential(
      accessToken: authResult.authToken!,
      secret: authResult.authTokenSecret!
    );

    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(twitterAuthCredential);
      user = userCredential.user;
      if(!await DatabaseFirestore.checkIfDocExists(user!.uid)){
          await DatabaseFirestore.createUser(user);
        }
      return user;
    } catch(e){
      return null;
    }
  }

  static Future<void> closeSession() async {
    await FirebaseAuth.instance.signOut();
  }
}
