import 'package:firebase_auth/firebase_auth.dart';
import 'package:natural_20/models/usuario_model.dart';
import 'notes_model.dart';

class Campaign {
  String? nombre;
  String? imagen;
  String? detalles;
  UserModel? creador;
  List<Note>? notas;

  Campaign({this.nombre, this.imagen, this.detalles, this.creador});

  factory Campaign.fromMap(Map<String, dynamic> map) {
    return Campaign(
      nombre: map['name'],
      imagen: map['image'] ?? 'Not Image',
      detalles: map['detail'],
      creador: UserModel.fromMap(map['creator']));
  }

  Map<String, dynamic> toMap() {
    return {
      "name": nombre,
      "detail": detalles,
      "image": imagen,
      "creator": {
        "name": FirebaseAuth.instance.currentUser?.displayName,
        "email": FirebaseAuth.instance.currentUser?.email,
        "photo": FirebaseAuth.instance.currentUser?.photoURL,
        "provider": FirebaseAuth.instance.currentUser?.providerData[0].providerId,
        "uid": FirebaseAuth.instance.currentUser?.uid,
      }
    };
  }
}
