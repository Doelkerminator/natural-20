
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/CharacterModel.dart';

class CharacterListTile extends StatelessWidget {
  CharacterListTile({Key? key, this.character}) : super(key:key);

  Character? character;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListTile(
          leading: CircleAvatar(
            foregroundColor: Colors.black,
            child: FadeInImage(
              height: 50,
              width: 50,
              placeholder: const AssetImage('assets/load.gif'),
              image: NetworkImage((character!.appearance != '' ? character!.appearance! : 'gs://natural-20-dbb1f.appspot.com/imagesCharacters/default.jpg')),
              fadeInDuration: const Duration(milliseconds: 1000),
            ),
          ),
          title: Text(character!.name!),
          subtitle: Text('${character!.race} - ${character!.classe}'),
          trailing: Text('LV ${character!.level}')
      ),
    );
  }
}