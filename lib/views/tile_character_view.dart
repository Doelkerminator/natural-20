import 'package:flutter/material.dart';
import 'package:natural_20/database/database_firestore.dart';
import 'package:natural_20/models/CharacterModel.dart';
import 'package:natural_20/settings/settings_color.dart';
import 'package:provider/provider.dart';
import 'package:natural_20/providers/add_note_notifier.dart';

import '../providers/add_character_campaign.dart';

class TileCharacterView extends StatefulWidget {
  TileCharacterView({Key? key, this.character, this.idCampaign})
      : super(key: key);
  Character? character;
  String? idCampaign;

  @override
  State<TileCharacterView> createState() => _TileCharacterView();
}

class _TileCharacterView extends State<TileCharacterView> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text('${widget.character?.name}', style: TextStyle(color: SettingsColor.textColor)),
        subtitle: Text('Level ${widget.character?.level}', style: TextStyle(color: SettingsColor.textColor)),
        leading: CircleAvatar(
            foregroundColor: Colors.black,
            backgroundImage: NetworkImage((widget.character!.appearance != null
                ? widget.character!.appearance!
                : 'https://firebasestorage.googleapis.com/v0/b/natural-20-dbb1f.appspot.com/o/imagesCharacters%2Fdefault.jpg?alt=media'))),
        trailing: SizedBox(
            width: MediaQuery.of(context).size.width / 7.5,
            child: optionButtons()));
  }

  Widget optionButtons() {
    return Row(children: [
      IconButton(
          onPressed: () async {
            await DatabaseFirestore.deleteCharacterCampaign(
                widget.idCampaign, widget.character?.uid);
            setState(() {
              
            });
          },
          icon: Icon(Icons.delete, color: SettingsColor.textColor)),
    ]);
  }
}
