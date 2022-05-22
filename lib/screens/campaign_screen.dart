import 'package:flutter/material.dart';
import 'package:natural_20/settings/settings_color.dart';

import 'add_campaign.dart';

class CampaignScreen extends StatefulWidget {
  const CampaignScreen({ Key? key }) : super(key: key);
  @override
  State<CampaignScreen> createState() => _CampaignScreenState();
}

class _CampaignScreenState extends State<CampaignScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark
      ),
      home: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              leading: IconButton(onPressed: (){ Navigator.pop(context); }, icon: Icon(Icons.arrow_back, color: SettingsColor.textColor)),
              actions: [IconButton(onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => const AddCampaignScreen())); }, icon: Icon(Icons.add, color: SettingsColor.textColor))],
              title: Text('SliverAppBar'),
              backgroundColor: Colors.green,
              expandedHeight: 200.0,
              flexibleSpace: FlexibleSpaceBar(background: Image.asset('assets/campaignImage.jpg', fit: BoxFit.cover))
            ),
            SliverFixedExtentList(
              itemExtent: 150.0,
              delegate: SliverChildListDelegate(
                [
                  Container(color: Colors.red),
                  Container(color: Colors.purple),
                  Container(color: Colors.green),
                  Container(color: Colors.orange),
                  Container(color: Colors.yellow),
                  Container(color: Colors.pink),
                ]
              )
            )
          ]
        )
      )
    );
  }
}