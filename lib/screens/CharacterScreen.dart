import 'package:flutter/material.dart';
import 'package:natural_20/database/database_firestore.dart';
import 'package:natural_20/settings/settings_color.dart';
import 'package:natural_20/views/CharacterListTile.dart';

import '../models/CharacterModel.dart';

class CharacterScreen extends StatefulWidget {
  const CharacterScreen({Key? key}) : super(key:key);

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SettingsColor.primaryColor,
      body: FutureBuilder(
        future: DatabaseFirestore.getUserCharacters(),
        builder: (BuildContext context, AsyncSnapshot<List<Character>?> snapshot) {
          Widget newListSliver;
          if (snapshot.hasError) {
            print(snapshot.error);
            return const Center(
              child: Text('Ocurrió un error en la solicitud')
            );
          }
          else {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data != []) {
                newListSliver = characterList(snapshot.data);
              }
              else {
                print('oof');
                newListSliver = Center(child: Text('No hay personajes creados', style: TextStyle(color: SettingsColor.textColor),));
              }
              return characterBody(newListSliver);
            }
            else {
              return const Center(child: CircularProgressIndicator());
            }
          }
        },
      ),
    );
  }

  ListView characterList(List<Character>? characters) {
    return ListView.separated(
      itemCount: characters!.length,
      itemBuilder: (context, index) {
        return CharacterListTile(character: characters[index]);
      },
      separatorBuilder: (context, index) => const Divider(color: Colors.black12,)
    );
  }

  Widget characterBody(Widget characterList) {
    return NestedScrollView(
      headerSliverBuilder: (context, value) {
        return [
          SliverAppBar(
            backgroundColor: SettingsColor.secondaryColor,
            floating: true,
            pinned: true,
            elevation: 0,
            expandedHeight: 250,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back, color: SettingsColor.textColor,),
            ),
            flexibleSpace: FlexibleSpaceBar(
                title: const Text('Personajes'),
                background: Image.asset('assets/images/characterImage.jpg', fit: BoxFit.cover)
            ),
          )
        ];
      },
      body: Stack(
        children: [
          characterList,
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 20, 20),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/character_form');
                },
                child: const Icon(Icons.add, color: Colors.white),
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(60,60),
                    shape: const CircleBorder(),
                    primary: SettingsColor.secondaryColor
                ),
              )
            )
          )
        ]
      )
    );
  }
}