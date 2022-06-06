import 'package:flutter/material.dart';
import 'package:natural_20/database/database_firestore.dart';
import 'package:natural_20/providers/add_note_notifier.dart';
import 'package:natural_20/settings/settings_color.dart';
import 'package:natural_20/settings/settings_form.dart';
import 'package:provider/provider.dart';

import '../models/notes_model.dart';
import '../settings/SettingsButtons.dart';

class FormNote extends StatefulWidget {
  Note? objNote;
  String idCampaign;
  FormNote({Key? key, this.objNote, required this.idCampaign})
      : super(key: key);

  @override
  State<FormNote> createState() => _FormNoteState();
}

class _FormNoteState extends State<FormNote> {
  late bool isEnabled;
  var txtTitleController = TextEditingController();
  var txtDesctiptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.objNote != null) {
      txtTitleController.text = widget.objNote!.titulo!;
      txtDesctiptionController.text = widget.objNote!.dscNota!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: SettingsColor.primaryColor,
      child: formAddNote()
    );
  }

  Widget formAddNote() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
            child: IgnorePointer(
                ignoring: context.watch<AddNoteState>().isNotEnabled,
                child: Column(children: [
                  txtFormFieldTitleNote(),
                  const SizedBox(height: 20),
                  txtFormFieldDescriptionNote(),
                  const SizedBox(height: 20),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: context.watch<AddNoteState>().isNotLoading
                          ? Column(children: [
                              ElevatedButton(
                                style: SettingsButtons.buttonStyle1(),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    await process();
                                  }
                                },
                                child: const Text('Guardar nota'),
                              ),
                            ])
                          : Center(
                              child: Column(
                              children: [
                                const CircularProgressIndicator(),
                                const SizedBox(height: 5),
                                Text(context.watch<AddNoteState>().loadMessage)
                              ],
                            ))),
                ]))),
      ),
    );
  }

  Widget txtFormFieldTitleNote() {
    return TextFormField(
      keyboardType: TextInputType.text,
      controller: txtTitleController,
      decoration: SettingsForm.textFieldDecoration("Titulo de la nota"),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Este campo no debe de estar vacío.';
        }
        return null;
      },
    );
  }

  Widget txtFormFieldDescriptionNote() {
    return TextFormField(
      keyboardType: TextInputType.text,
      controller: txtDesctiptionController,
      maxLines: 8,
      decoration: SettingsForm.textFieldDecoration("Descripcion de la nota"),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Este campo no debe de estar vacío.';
        }
        return null;
      },
    );
  }

  Future process() async {
    context.read<AddNoteState>().changeLoad();
    context.read<AddNoteState>().chengeEnabled();
    await create();
    context.read<AddNoteState>().loadMessageComplete();
    await Future.delayed(const Duration(seconds: 3), () {});
    context.read<AddNoteState>().chengeEnabled();
    context.read<AddNoteState>().changeLoad();
    context.read<AddNoteState>().recoveryLoadMessage();
    context.read<AddNoteState>().changeStateToList();
  }

  Future create() async {
    if (widget.objNote == null) {
      await DatabaseFirestore.createNote(widget.idCampaign,
          txtTitleController.text, txtDesctiptionController.text);
    } else {
      await DatabaseFirestore.updateNote(widget.idCampaign, widget.objNote?.id,
          txtTitleController.text, txtDesctiptionController.text);
    }
  }

  Future delete() async {}
}
