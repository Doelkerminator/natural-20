import 'package:natural_20/models/notes_model.dart';

class Campaign{
  String? nombre;
  String? imagen;
  String? detalles;
  List<Note>? notas;

  Campaign({
    this.nombre,
    this.imagen,
    this.detalles,
  });

  factory Campaign.fromMap(Map<String, dynamic> map){
    return Campaign(
      nombre: map['nombre'],
      imagen: map['imagen'],
      detalles: map['detalles'],
    );
  }
}