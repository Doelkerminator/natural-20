import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String? email;
  String? name;
  String? photo;
  String? provider;
  String? uid;

  UserModel({this.email, this.name, this.photo, this.provider, this.uid});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'],
      name: map['name'],
      photo: map['photo'] ?? "Not image",
      provider: map['provider'],
      uid: map['uid'],
    );
  }

  static Map<String, dynamic> toMap() {
    return {
      "name": FirebaseAuth.instance.currentUser?.displayName,
      "email": FirebaseAuth.instance.currentUser?.email,
      "photo": FirebaseAuth.instance.currentUser?.photoURL,
      "provider": FirebaseAuth.instance.currentUser?.providerData[0].providerId,
      "uid": FirebaseAuth.instance.currentUser?.uid,
    };
  }
}
