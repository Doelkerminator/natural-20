import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:natural_20/models/campaign_model.dart';
import 'package:crypto/crypto.dart';

class DatabaseFirestore {
  static Future<bool> checkIfDocExists(String docId) async {
    try {
      CollectionReference collection =
          FirebaseFirestore.instance.collection('usuarios');
      var doc = await collection.doc(docId).get();
      return doc.exists;
    } catch (e) {
      throw e;
    }
  }

  static Future<void> createUser(User user) async {
    CollectionReference newUser =
        FirebaseFirestore.instance.collection('usuarios');
    await newUser.doc(user.uid).set({
      "name": user.displayName,
      "email": user.email,
      "photo": user.photoURL,
      "provider": user.providerData[0].providerId,
      "uid": user.uid,
      "characters": []
    });
  }

  static Future<void> createCampaign(
      String? urlImage, String nameCampaign, String detailsCampaign) async {
    late String id;    
    CollectionReference newCampaign =
        FirebaseFirestore.instance.collection('campania');
    var bytes1 = utf8.encode(nameCampaign);
    Random random = Random();
    int randomNumber = random.nextInt(999);
    id = sha256.convert(bytes1).toString() + randomNumber.toString();
    Campaign? campaign = Campaign(id: id, nombre: nameCampaign, detalles: detailsCampaign, imagen: urlImage);  
    await newCampaign.doc().set(campaign.toMap());
  }

  static Future<void> updateCampaign(String? id, String? urlImage, String nameCampaign, String detailsCampaign) async {
    final post = FirebaseFirestore.
      instance.
      collection('campania').
      where("id", isEqualTo: id).
      limit(1).
      get().
      then((QuerySnapshot snapshot){
        return snapshot.docs[0].reference;
      });
    var batch = FirebaseFirestore.instance.batch();
    batch.update(await post, ({'image': urlImage, 'name': nameCampaign, 'detail': detailsCampaign}));
    batch.commit();
  }

  static Future<List<Campaign>> getCampaignsCreates() async {
    List<Campaign> dataCampaigns = [];
    await FirebaseFirestore.instance.collection("campania").get().then((value) {
      for (var i in value.docs) {
        if(i.data()['creator']['uid'] == FirebaseAuth.instance.currentUser?.uid){
          dataCampaigns.add(Campaign.fromMap(i.data()));
        }
      }
    });
    return dataCampaigns;
  }

  static Future<void> deleteCampaign(String? id) async {
    FirebaseFirestore.
      instance.
      collection('campania').
      where("id", isEqualTo: id).
      limit(1).
      get().
      then((QuerySnapshot snapshot){
        snapshot.docs[0].reference.delete();
      });
  }

  static Future<void> createNote(String? id) async{
    FirebaseFirestore.
      instance.
      collection('campania').
      where("id", isEqualTo: id).
      limit(1).
      get().
      then((QuerySnapshot snapshot){
        print(snapshot.docs[0].reference.get());
      });
  }
}
