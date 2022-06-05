class Note{
  String? id;
  String? titulo;
  String? dscNota;
  String? fecha;


  Note({ 
    this.id,
    this.titulo, 
    this.dscNota,
    this.fecha
  });

  factory Note.fromMap(Map<String, dynamic> noteMap) {
    return Note(
      id: noteMap['id'],
      titulo: noteMap['titulo'],
      dscNota: noteMap['dscNota'],
      fecha: noteMap['fecha']);
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "titulo": titulo, 
      "dscNota": dscNota,
      "fecha": fecha
    };
  }
}