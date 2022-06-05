import 'package:flutter/material.dart';
import 'package:natural_20/screens/campaign_screen.dart';
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
        drawer: const DrawerView(),
        body: SingleChildScrollView(
            child: Center(
                child: Column(children: [
          const SizedBox(height: 24),
          Image.asset("assets/logo.png", width: screenSizes.width / 1.5),
          const SizedBox(height: 50),
          radial()
        ]))));
  }

  Widget radial() {
    return Column(children: [
      TextButton(
        child: const Text("Enciclopedia"),
        onPressed: () {
          Navigator.pushNamed(context, '/encyclopedia');
        }
      ),
      TextButton(child: const Text("Personajes"),
        onPressed: () {
          Navigator.pushNamed(context, '/characters');
        }
      ),
      TextButton(
          child: const Text("Partida"),
          onPressed: () {
            Navigator.pushNamed(context, '/list_campaign');
          }),
      TextButton(child: Text("Dado"), onPressed: () {}),
    ]);
  }
}
