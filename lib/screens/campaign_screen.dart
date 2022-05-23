import 'package:flutter/material.dart';
import 'package:natural_20/database/database_firestore.dart';
import 'package:natural_20/settings/settings_color.dart';
import 'add_campaign.dart';

class CampaignScreen extends StatefulWidget {
  const CampaignScreen({Key? key}) : super(key: key);
  @override
  State<CampaignScreen> createState() => _CampaignScreenState();
}

class _CampaignScreenState extends State<CampaignScreen> {
  late var allData;

  @override
  Widget build(BuildContext context) {
    print(DatabaseFirestore.getAllCampaigns());
    return Scaffold(
        body: CustomScrollView(slivers: <Widget>[
      SliverAppBar(
          floating: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back, color: SettingsColor.textColor)),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/add_campaign');
                },
                icon: Icon(Icons.add, color: SettingsColor.textColor))
          ],
          title: const Text('Campañas'),
          backgroundColor: Colors.green,
          expandedHeight: 200.0,
          flexibleSpace: FlexibleSpaceBar(
              background:
                  Image.asset('assets/campaignImage.jpg', fit: BoxFit.cover))),
      SliverFixedExtentList(
          itemExtent: 150.0,
          delegate: SliverChildListDelegate([
            Container(color: Colors.red),
            Container(color: Colors.purple),
            Container(color: Colors.green),
            Container(color: Colors.orange),
            Container(color: Colors.yellow),
            Container(color: Colors.pink),
          ]))
    ]));
  }
}
