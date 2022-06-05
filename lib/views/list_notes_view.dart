import 'package:flutter/widgets.dart';
import 'package:natural_20/database/database_firestore.dart';
import 'package:natural_20/views/tile_note_view.dart';
import '../models/notes_model.dart';

class ListNotesView extends StatefulWidget {
  String idCampaign;
  ListNotesView({Key? key, required this.idCampaign}) : super(key: key);

  @override
  State<ListNotesView> createState() => _ListNotesViewState();
}

class _ListNotesViewState extends State<ListNotesView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: DatabaseFirestore.getNotesByCampaign(widget.idCampaign),
        builder: (BuildContext context, AsyncSnapshot<List<Note>?> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Ocurrio un error en la solicitud'),
            );
          } else {
            if (snapshot.hasData) {
              return listNotes(snapshot.data);
            } else {
              return const Center(child: Text("No hay notas creadas"));
            }
          }
        });
  }

  Widget listNotes(List<Note>? notes) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          Note note = notes![index];
          return TileNoteView(note: note);
        },
        itemCount: notes?.length
      ),
    );
  }
}
