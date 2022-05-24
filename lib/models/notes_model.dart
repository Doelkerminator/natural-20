class Note{
  String? titulo;
  String? dscNota;
  DateTime? fecha;


  Note({ 
    this.titulo, 
    this.dscNota,
    this.fecha
  });

  factory Note.fromMap(Map<String, dynamic> noteMap) {
    return Note(
        titulo: noteMap['titulo'],
        dscNota: noteMap['dscNota'],
        fecha: noteMap['fecha']);
  }

  Map<String, dynamic> toMap() {
    return {
      "titulo": titulo, 
      "dscNota": dscNota,
      "fecha": fecha
    };
  }
}