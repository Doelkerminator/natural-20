import 'package:flutter/material.dart';
import 'package:natural_20/models/CharacterModel.dart';
import 'package:natural_20/providers/add_character_campaign.dart';
import 'package:natural_20/views/tile_character_view.dart';
import '../database/database_firestore.dart';
import '../settings/settings_color.dart';
import '../settings/settings_form.dart';
import 'package:provider/provider.dart';

class ListCharactersByCampaign extends StatefulWidget {
  String idCampaign;
  ListCharactersByCampaign({Key? key, required this.idCampaign}) : super(key: key);

  @override
  State<ListCharactersByCampaign> createState() =>
      _ListCharactersByCampaignState();
}

class _ListCharactersByCampaignState extends State<ListCharactersByCampaign> {
  var txtNameUserController = TextEditingController();
  var txtNameCharController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DatabaseFirestore.getCharactersByCampaign(widget.idCampaign),
      builder: (BuildContext context, AsyncSnapshot<List<Character>?> snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('Ocurrio un error en la solicitud'),
          );
        } else {
          if (snapshot.hasData) {
            return listCharacters(snapshot.data);
          } else {
            return const Center(child: Text("No hay notas creadas"));
          }
        }
      });
  }

  Widget listCharacters(List<Character>? characters) {
    return Stack(
      children: [
        Container(
          color: SettingsColor.primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemBuilder: (context, index) {
                Character character = characters![index];
                return TileCharacterView(character: character);
              },
              itemCount: characters?.length
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
            showDialog(context: context, builder: (context){ return alert(); });
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

  Widget alert() {
    return AlertDialog(
      backgroundColor: SettingsColor.primaryColor,
      title: Text("Añadir personaje a la partida", style: TextStyle(color: SettingsColor.textColor)),
      content: Column(
        children: [
          txtFormFieldNameUserCampaign(),
          const SizedBox(height: 20),
          txtFormFieldNameCharCampaign(),
          const SizedBox(height: 20),
        ]
      ),
      actions: [
        TextButton(
          onPressed: (){
            Navigator.of(context).pop();
          }, 
          child: const Text("Cancelar")
        ),
        TextButton(
          onPressed: () async {
            Navigator.pop(context);
            await DatabaseFirestore.addChar(txtNameUserController.text, txtNameCharController.text, widget.idCampaign);
            setState(() {
              
            });
          }, 
          child: const Text("Guardar")
        )
      ],
    );
  }

  Widget txtFormFieldNameUserCampaign() {
    return TextFormField(
      keyboardType: TextInputType.text,
      controller: txtNameUserController,
      style: const TextStyle(color: Colors.white),
      decoration: SettingsForm.textFieldDecoration('Nombre del usuario'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Este campo no debe de estar vacío.';
        }
        return null;
      },
    );
  }

  Widget txtFormFieldNameCharCampaign() {
    return TextFormField(
      keyboardType: TextInputType.text,
      controller: txtNameCharController,
      style: const TextStyle(color: Colors.white),
      decoration: SettingsForm.textFieldDecoration('Nombre del personaje'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Este campo no debe de estar vacío.';
        }
        return null;
      },
    );
  }
}
