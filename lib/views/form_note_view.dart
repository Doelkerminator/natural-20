import 'package:flutter/material.dart';
import 'package:natural_20/database/database_firestore.dart';
import 'package:natural_20/providers/add_note_notifier.dart';
import 'package:provider/provider.dart';

import '../models/notes_model.dart';

class FormNote extends StatefulWidget {
  Note? objNote;
  String idCampaign;
  FormNote({Key? key, this.objNote, required this.idCampaign}) : super(key: key);

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
    return formAddNote();
  }

  Widget formAddNote() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: IgnorePointer(
            ignoring: context.watch<AddNoteState>().isEnabled,
            child: Column(
              children: [
                txtFormFieldTitleNote(),
                const SizedBox(height: 20),
                txtFormFieldTitleNote(),
                const SizedBox(height: 20),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: context.watch<AddNoteState>().isNotLoading ?
                        Column(
                          children: [
                            ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    await process();
                                  }
                                },
                                child: const Text('Guardar nota'),
                            ),
                            const SizedBox(height: 10),
                            widget.objNote != null ? ElevatedButton(
                            onPressed:() async {
                              await process();
                            },
                            child: const Text("Borrar nota")): Container()
                          ]
                        )
                        : Center(
                            child: Column(
                            children: [
                              const CircularProgressIndicator(),
                              const SizedBox(height: 5),
                              Text(
                                  context.watch<AddNoteState>().loadMessage)
                            ],
                          ))),
              ]
            )
          )
        ),
      ),
    );
  }

  Widget txtFormFieldTitleNote() {
    return TextFormField(
      keyboardType: TextInputType.text,
      controller: txtTitleController,
      decoration: const InputDecoration(
        labelText: 'NTirulo de la nota',
      ),
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
      decoration: const InputDecoration(
        labelText: 'Descripción de la nota',
      ),
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
    if(widget.objNote == null){
      await create();
    } else {
      await delete();
    }
    //await DatabaseFirestore.deleteCampaign(widget.objCampaig?.id);
    context.read<AddNoteState>().loadMessageDelete();
    await Future.delayed(const Duration(seconds: 3), () {});
    context.read<AddNoteState>().chengeEnabled();
    context.read<AddNoteState>().changeLoad();
    context.read<AddNoteState>().recoveryLoadMessage();
    context.read<AddNoteState>().imageStatusNoSelected();
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pushNamed(context, '/list_campaign');
  }

  Future create() async {
    await DatabaseFirestore.createNote(widget.idCampaign);
  }

  Future delete() async {
    
  }
}
