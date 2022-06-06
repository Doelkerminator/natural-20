import 'package:flutter/material.dart';
import 'package:natural_20/database/database_firestore.dart';
import 'package:natural_20/settings/settings_color.dart';
import 'package:provider/provider.dart';
import 'package:natural_20/providers/add_note_notifier.dart';
import '../models/notes_model.dart';

class TileNoteView extends StatefulWidget {
  TileNoteView({Key? key, this.note, this.idCampaign}) : super(key: key);
  Note? note;
  String? idCampaign;

  @override
  State<TileNoteView> createState() => _TileNoteViewState();
}

class _TileNoteViewState extends State<TileNoteView> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${widget.note?.fecha}', style: TextStyle(color: SettingsColor.textColor)),
      subtitle: Text('${widget.note?.titulo}', style: TextStyle(color: SettingsColor.textColor)),
      leading: Icon(Icons.note_sharp, color: SettingsColor.textColor),
      trailing: SizedBox(
        width: MediaQuery.of(context).size.width / 3.7,
        child: optionButtons()));
  }

  Widget optionButtons() {
    return Row(children: [
      IconButton(
        onPressed: () {
          context.read<AddNoteState>().changeNoteE(widget.note);
          context.read <AddNoteState>().changeStateToEdit();
        },
        icon: Icon(Icons.edit, color: SettingsColor.textColor)
      ),
      IconButton(
        onPressed: () async {
          await DatabaseFirestore.deleteNote(widget.idCampaign, widget.note?.id);
          print("jpg");
          context.read <AddNoteState>().changeStateToList();
        },
        icon: Icon(Icons.delete, color: SettingsColor.textColor)
      ),
    ]);
  }
}
