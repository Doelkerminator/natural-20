import 'package:natural_20/models/notes_model.dart';

class Campaign{
  String? juego;
  String? nombre;
  bool? edicion;
  String? imagen;
  String? detalles;
  String? notasPrivadas;
  List<Note>? notas;

  Campaign({
    this.juego,
    this.nombre,
    this.edicion,
    this.imagen,
    this.detalles,
    this.notasPrivadas
  });

  factory Campaign.fromMap(Map<String, dynamic> map){
    return Campaign(
      juego: map['juego'],
      nombre: map['nombre'],
      edicion: map['edicion'],
      imagen: map['imagen'],
      detalles: map['detalles'],
      notasPrivadas: map['notasPrivadas'],
    );
  }
}