import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/CharacterModel.dart';

class DatabaseFirestore{
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

  static Future<void> createCampaign(String urlImage, String nameCampaign, String detailsCampaign) async {
    CollectionReference newCampaign =
    FirebaseFirestore.instance.collection('campania');
    User? user = FirebaseAuth.instance.currentUser;
    await newCampaign.doc().set({
      "name": nameCampaign,
      "detail": detailsCampaign,
      "image": urlImage,
      "creator": {
        "name": user?.displayName,
        "email": user?.email,
        "photo": user?.photoURL,
        "provider": user?.providerData[0].providerId,
        "uid": user?.uid,
      }
    });
  }

  static Future<void> getAllCampaigns() async {
    CollectionReference campaigns = FirebaseFirestore.instance.collection('campania');
    QuerySnapshot querySnapshot = await campaigns.get();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    print(allData);
  }

  // Character related
  static Future<void> createCharacter(Character character) async {
    CollectionReference characterRef = FirebaseFirestore.instance.collection('usuarios');
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await characterRef.doc(user.uid).collection('characters').add(character.toMap());
    }
  }

  static Future<List<Character>?> getUserCharacters() async {
    User? user = FirebaseAuth.instance.currentUser;
    CollectionReference characterRef = FirebaseFirestore.instance.collection('usuarios').doc(user!.uid).collection('characters');
    QuerySnapshot querySnapshot = await characterRef.get();
    return querySnapshot.docs.map((character) => Character.fromMap(character.data() as Map<String,dynamic>)).toList();
  }

  static Future<Character?> getCharacter(String charId) async {
    User? user = FirebaseAuth.instance.currentUser;
    CollectionReference characterRef = FirebaseFirestore.instance.collection('usuarios').doc(user!.uid).collection('characters');
    var characterDoc = await characterRef.doc(charId).get();
    if(characterDoc.exists) {
      return Character.fromMap(characterDoc.data() as Map<String,dynamic>);
    }
    else {
      print('Character $charId was not found in ${user.uid} character list');
      return null;
    }
  }
  
  static Future<void> updateCharacter(String charId, Character character) async {
    User? user = FirebaseAuth.instance.currentUser;
    CollectionReference characterRef = FirebaseFirestore.instance.collection('usuarios').doc(user!.uid).collection('characters');
    await characterRef.doc(charId).update(character.toMap());
  }

  static Future<void> deleteCharacter(String charId) async {
    User? user = FirebaseAuth.instance.currentUser;
    CollectionReference characterRef = FirebaseFirestore.instance.collection('usuarios').doc(user!.uid).collection('characters');
    await characterRef.doc(charId).delete();
  }
}