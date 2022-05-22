import 'package:flutter/material.dart';
import 'package:natural_20/views/drawer_view.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({ Key? key }) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    var screenSizes = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Menú Principal')),
        drawer: const DrawerView(),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 24),
                Image.asset("assets/logo.png", width: screenSizes.width / 1.5),
                const SizedBox(height: 50),
                radial()
              ]
            )
          )
        )
      )
    );
  }

  Widget radial(){
    return Column(
      children: [
        TextButton(child: Text("Enciclopedia"), onPressed: () {}),
        TextButton(child: Text("Personajes"), onPressed: () {}),
        TextButton(child: Text("Partida"), onPressed: () {}),
        TextButton(child: Text("Dado"), onPressed: () {}),
        TextButton(child: Text("Ei"), onPressed: () {})
      ]
    );
  }
}