
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:natural_20/api/dnd_api.dart';

import '../settings/settings_color.dart';

class EnciclopediaScreen extends StatefulWidget{
  const EnciclopediaScreen({Key? key}) : super(key: key);

  @override
  State<EnciclopediaScreen> createState() => _EnciclopediaState();
}

class _EnciclopediaState extends State<EnciclopediaScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: DnDApi.getMonsterList(),
        builder: (BuildContext context, AsyncSnapshot<List<Map<String, String>>?> snapshot) {
          if(snapshot.hasError) {
            return const Center(child: Text('xd'));
          }
          else {
            if(snapshot.connectionState == ConnectionState.done) {
              List<Map<String, String>> monsters = snapshot.data!;
              return CustomScrollView(slivers: <Widget>[
                SliverAppBar(
                  floating: true,
                  leading: IconButton(
                      onPressed: () => {
                        Navigator.pop(context)
                      },
                      icon: Icon(Icons.arrow_back, color: SettingsColor.textColor)),
                  title: const Text('Enciclopedia'),
                  backgroundColor: Colors.green,
                  expandedHeight: 200.0,
                  flexibleSpace: FlexibleSpaceBar(
                      background:
                      Image.asset('assets/campaignImage.jpg', fit: BoxFit.cover)),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                          (BuildContext context, index) {
                        return Text(monsters[index]['name']!);
                      },
                      childCount: monsters.length
                  )
                )
              ]);
            }
            else {
              return const Center(child: CircularProgressIndicator());
            }
          }
        }
      )
    );
  }
}