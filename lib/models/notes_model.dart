class Note{
  String? titulo;
  String? dscNota;

  Note({ 
    this.titulo, 
    this.dscNota
  });

  factory Note.fromMap(Map<String, dynamic> noteMap) {
    return Note(
        titulo: noteMap['titulo'],
        dscNota: noteMap['dscNota']);
  }

  Map<String, dynamic> toMap() {
    return {
      "titulo": titulo, 
      "dscNota": dscNota
    };
  }
}