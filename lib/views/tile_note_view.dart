import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:natural_20/providers/add_note_notifier.dart';
import '../models/notes_model.dart';

class TileNoteView extends StatefulWidget {
  TileNoteView({Key? key, this.note}) : super(key: key);
  Note? note;

  @override
  State<TileNoteView> createState() => _TileNoteViewState();
}

class _TileNoteViewState extends State<TileNoteView> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text('${widget.note?.fecha}'),
        subtitle: Text('${widget.note?.titulo}'),
        leading: const Icon(Icons.note_sharp, color: Colors.black),
        trailing: SizedBox(
            width: MediaQuery.of(context).size.width / 7,
            child: optionButtons()));
  }

  Widget optionButtons() {
    return Row(children: [
      IconButton(
          onPressed: () {
            context.read<AddNoteState>().changeNoteE(widget.note);
            context.read <AddNoteState>().changeStateToEdit();
          },
          icon: const Icon(Icons.edit)),
    ]);
  }
}
