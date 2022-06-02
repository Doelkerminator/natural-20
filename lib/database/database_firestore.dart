import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:natural_20/models/campaign_model.dart';

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
    CollectionReference newCampaign =
        FirebaseFirestore.instance.collection('campania');
    Campaign? campaign = Campaign(nombre: nameCampaign, detalles: detailsCampaign, imagen: urlImage);  
    await newCampaign.doc().set(campaign.toMap());
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
}
