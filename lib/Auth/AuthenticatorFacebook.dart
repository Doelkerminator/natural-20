import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:http/http.dart' as http;
import 'package:natural_20/database/database_firestore.dart';

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
        if(!await DatabaseFirestore.checkIfDocExists(user!.uid)){
          await DatabaseFirestore.createUser(user);
        }
        return user;
      }catch(e){ return null; }
    } catch (e) { return null; }
  }

  static Future<void> closeSession() async {
    await FacebookAuth.instance.logOut(); 
    await FirebaseAuth.instance.signOut();
  }
}