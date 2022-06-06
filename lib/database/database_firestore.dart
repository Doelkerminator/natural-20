import 'dart:convert';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:natural_20/models/campaign_model.dart';
import 'package:crypto/crypto.dart';
import 'package:natural_20/models/notes_model.dart';

import '../models/CharacterModel.dart';

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
    id = md5.convert(bytes1).toString() + randomNumber.toString();
    Campaign? campaign = Campaign(
        id: id,
        nombre: nameCampaign,
        detalles: detailsCampaign,
        imagen: urlImage);
    await newCampaign.doc().set(campaign.toMap());
  }

  static Future<void> updateCampaign(String? id, String? urlImage,
      String nameCampaign, String detailsCampaign) async {
    final post = FirebaseFirestore.instance
        .collection('campania')
        .where("id", isEqualTo: id)
        .limit(1)
        .get()
        .then((QuerySnapshot snapshot) {
      return snapshot.docs[0].reference;
    });
    var batch = FirebaseFirestore.instance.batch();
    batch.update(await post,
        ({'image': urlImage, 'name': nameCampaign, 'detail': detailsCampaign}));
    batch.commit();
  }

  static Future<List<Campaign>> getCampaignsCreates() async {
    List<Campaign> dataCampaigns = [];
    await FirebaseFirestore.instance.collection("campania").get().then((value) {
      for (var i in value.docs) {
        if (i.data()['creator']['uid'] ==
            FirebaseAuth.instance.currentUser?.uid) {
          dataCampaigns.add(Campaign.fromMap(i.data()));
        }
      }
    });
    return dataCampaigns;
  }

  static Future<void> deleteCampaign(String? id) async {
    FirebaseFirestore.instance
        .collection('campania')
        .where("id", isEqualTo: id)
        .limit(1)
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs[0].reference.delete();
    });
  }

  static Future<void> createNote(
      String? idCamp, String title, String desc) async {
    await FirebaseFirestore.instance
        .collection('campania')
        .where('id', isEqualTo: idCamp)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        var bytes1 = utf8.encode(title);
        Random random = Random();
        int randomNumber = random.nextInt(999);
        String id = md5.convert(bytes1).toString() + randomNumber.toString();
        String date = DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now());
        Note nota = Note(id: id, titulo: title, dscNota: desc, fecha: date);
        FirebaseFirestore.instance
            .collection('campania')
            .doc(element.id)
            .collection("notas")
            .add(nota.toMap());
      });
    });
  }

  static Future<void> updateNote(
      String? idCamp, String? idNote, String title, String desc) async {
    await FirebaseFirestore.instance
        .collection('campania')
        .where('id', isEqualTo: idCamp)
        .get()
        .then((value) {
      value.docs.forEach((element) async {
        final post = await FirebaseFirestore.instance
            .collection('campania')
            .doc(element.id)
            .collection("notas")
            .where("id", isEqualTo: idNote)
            .limit(1)
            .get()
            .then((QuerySnapshot snapshot) {
          return snapshot.docs[0].reference;
        });
        var batch = FirebaseFirestore.instance.batch();
        batch.update(post, ({'titulo': title, 'dscNota': desc}));
        batch.commit();
      });
    });
  }

  static Future<void> deleteNote(String? idCamp, String? idNote) async {
    await FirebaseFirestore.instance
        .collection('campania')
        .where('id', isEqualTo: idCamp)
        .limit(1)
        .get()
        .then((value) {
      value.docs.forEach((element) async {
        final post = await FirebaseFirestore.instance
            .collection('campania')
            .doc(element.id)
            .collection("notas")
            .where("id", isEqualTo: idNote)
            .limit(1)
            .get()
            .then((QuerySnapshot snapshot) {
          snapshot.docs[0].reference.delete();
        });
      });
    });
  }

  static Future<List<Note>> getNotesByCampaign(String? idCamp) async {
    String? idC;
    await FirebaseFirestore.instance
        .collection('campania')
        .where('id', isEqualTo: idCamp)
        .get()
        .then((value) {
      for (var element in value.docs) {
        idC = element.id;
      }
    });

    List<Note> dataNotes = [];
    await FirebaseFirestore.instance
        .collection("campania")
        .doc(idC)
        .collection("notas")
        .get()
        .then((value) {
      for (var i in value.docs) {
        dataNotes.add(Note.fromMap(i.data()));
      }
    });
    return dataNotes;
  }

  static Future<void> addChar(
      String? nameUser, String? nameChar, String idCamp) async {
    late Character chara;
    await FirebaseFirestore.instance
        .collection('usuarios')
        .where("name", isEqualTo: nameUser)
        .limit(1)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        FirebaseFirestore.instance
            .collection('usuarios')
            .doc(element.id)
            .collection("characters")
            .where("name", isEqualTo: nameChar)
            .limit(1)
            .get()
            .then((QuerySnapshot snapshot) {
          snapshot.docs[0].reference.get().then((value) async {
            chara = Character(
                uid: value.get("uid"),
                name: value.get("name"),
                level: value.get("level"),
                appearance: value.get("physical")['appereance'],
                playerName: value.get("player_name"));
            String? idC;
            await FirebaseFirestore.instance
                .collection('campania')
                .where('id', isEqualTo: idCamp)
                .get()
                .then((value) {
              for (var element in value.docs) {
                idC = element.id;
              }
            });

            FirebaseFirestore.instance
                .collection("campania")
                .doc(idC)
                .collection("characters")
                .add(chara.toMap());
          });
        });
      });
    });
  }

  static Future<List<Character>> getCharactersByCampaign(String? idCamp) async {
    String? idC;
    await FirebaseFirestore.instance
        .collection('campania')
        .where('id', isEqualTo: idCamp)
        .get()
        .then((value) {
      for (var element in value.docs) {
        idC = element.id;
      }
    });

    List<Character> dataCharacters = [];
    await FirebaseFirestore.instance
        .collection("campania")
        .doc(idC)
        .collection("characters")
        .get()
        .then((value) {
      for (var i in value.docs) {
        dataCharacters.add(Character.fromMap(i.data()));
      }
    });
    return dataCharacters;
  }

  static Future<void> deleteCharacterCampaign(
      String? idCamp, String? idCharacter) async {
    await FirebaseFirestore.instance
        .collection('campania')
        .where('id', isEqualTo: idCamp)
        .limit(1)
        .get()
        .then((value) {
      value.docs.forEach((element) async {
        final post = await FirebaseFirestore.instance
            .collection('campania')
            .doc(element.id)
            .collection("characters")
            .where("uid", isEqualTo: idCharacter)
            .limit(1)
            .get()
            .then((QuerySnapshot snapshot) {
          snapshot.docs[0].reference.delete();
        });
      });
    });
  }

  static Future<void> createCharacter(Character character) async {
    CollectionReference characterRef =
        FirebaseFirestore.instance.collection('usuarios');
    User? user = FirebaseAuth.instance.currentUser;
    print(user!.uid);
    if (user != null) {
      await characterRef
          .doc(user.uid)
          .collection('characters')
          .add(character.toMap());
    }
  }

  static Future<List<Character>?> getUserCharacters() async {
    User? user = FirebaseAuth.instance.currentUser;
    List<Character> characters = [];
    CollectionReference characterRef = FirebaseFirestore.instance
        .collection('usuarios')
        .doc(user!.uid)
        .collection('characters');
    await characterRef.get().then((value) {
      for (var i in value.docs) {
        characters.add(Character.fromMap(i.data() as Map<String, dynamic>));
      }
    });
    return characters;
  }

  static Future<Character?> getCharacter(String charId) async {
    User? user = FirebaseAuth.instance.currentUser;
    CollectionReference characterRef = FirebaseFirestore.instance
        .collection('usuarios')
        .doc(user!.uid)
        .collection('characters');
    var characterDoc = await characterRef.doc(charId).get();
    if (characterDoc.exists) {
      return Character.fromMap(characterDoc.data() as Map<String, dynamic>);
    } else {
      print('Character $charId was not found in ${user.uid} character list');
      return null;
    }
  }

  static Future<void> updateCharacter(
      String charId, Character character) async {
    User? user = FirebaseAuth.instance.currentUser;
    CollectionReference characterRef = FirebaseFirestore.instance
        .collection('usuarios')
        .doc(user!.uid)
        .collection('characters');
    await characterRef.doc(charId).update(character.toMap());
  }

  static Future<void> deleteCharacter(String charId) async {
    User? user = FirebaseAuth.instance.currentUser;
    CollectionReference characterRef = FirebaseFirestore.instance
        .collection('usuarios')
        .doc(user!.uid)
        .collection('characters');
    await characterRef.doc(charId).delete();
  }
}
