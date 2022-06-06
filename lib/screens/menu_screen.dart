import 'package:flutter/material.dart';
import 'package:natural_20/screens/campaign_screen.dart';
import 'package:natural_20/settings/SettingsButtons.dart';
import 'package:natural_20/settings/settings_color.dart';
import 'package:natural_20/views/drawer_view.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    var screenSizes = MediaQuery.of(context).size;
    return Scaffold(
    backgroundColor: SettingsColor.primaryColor,
      drawer: const DrawerView(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/images/logo.png", width: screenSizes.width / 1.5),
              const SizedBox(height: 50),
              radial()
            ]
          ),
        ),
      )
    );
  }

  Widget radial() {
    return Column(children: [
      ElevatedButton(
        style: SettingsButtons.buttonStyle1(),
        child: const Text("Enciclopedia"),
        onPressed: () {
          Navigator.pushNamed(context, '/encyclopedia');
        }
      ),
      ElevatedButton(
        child: const Text("Personajes"),
        style: SettingsButtons.buttonStyle1(),
        onPressed: () {
          Navigator.pushNamed(context, '/characters');
        }
      ),
      ElevatedButton(
          child: const Text("Partida"),
          style: SettingsButtons.buttonStyle1(),
          onPressed: () {
            Navigator.pushNamed(context, '/list_campaign');
          }),
      ElevatedButton(
        style: SettingsButtons.buttonStyle1(),
        child: Text("Dado"),
        onPressed: () {}),
    ]);
  }
}
