import 'package:flutter/material.dart';
import 'package:natural_20/database/database_firestore.dart';
import 'package:natural_20/views/tile_note_view.dart';
import 'package:provider/provider.dart';
import '../models/notes_model.dart';
import '../providers/add_note_notifier.dart';
import '../settings/settings_color.dart';

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
    return Stack(
      children: [
        Container(
          color: SettingsColor.primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemBuilder: (context, index) {
                Note note = notes![index];
                return TileNoteView(note: note, );
              },
              itemCount: notes?.length
            ),
          ),
        ),
        circularButton()
      ],
    );
  }

  Widget circularButton(){
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 20, 20),
        child: ElevatedButton(
          onPressed: () {
            context.read<AddNoteState>().changeStateToCreate();
          },
          child: const Icon(Icons.add, color: Colors.white),
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(60,60),
            shape: const CircleBorder(),
            primary: SettingsColor.tertiaryColor
          ),
        )
      )
    );
  }
}
