
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:natural_20/settings/settings_color.dart';

import '../models/CharacterModel.dart';

class CharacterListTile extends StatelessWidget {
  CharacterListTile({Key? key, this.character}) : super(key:key);

  Character? character;

  @override
  Widget build(BuildContext context) {
    print(character!.level);
    return InkWell(
      child: ListTile(
          leading: CircleAvatar(
            foregroundColor: Colors.black,
            backgroundImage: NetworkImage((character!.appearance != null ? character!.appearance! : 'https://firebasestorage.googleapis.com/v0/b/natural-20-dbb1f.appspot.com/o/imagesCharacters%2Fdefault.jpg?alt=media'))
          ),
          title: Text(character!.name!, style: TextStyle(color: SettingsColor.textColor, fontSize: 24)),
          subtitle: Text('${character!.race} - ${character!.classe}', style: const TextStyle(color: Colors.white, fontSize: 18)),
          trailing: Text('LV ${character!.level}', style: const TextStyle(color: Colors.white))
      ),
    );
  }
}