import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var screenSizes = MediaQuery.of(context).size;
    Divider _divider = const Divider(height: 10);
    return MaterialApp(
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Natural 20")
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 24),
              Image.asset("assets/logo.png", width: screenSizes.width / 1.5),
              GoogleAuthButton(
                onPressed: () {
                  // your implementation
                  setState(() {
                    isLoading = !isLoading;
                  });
                },
                darkMode: true,
                isLoading: isLoading,
                style: const AuthButtonStyle(
                  buttonType: null,
                  iconType: null,
                ),
              ),  
              _divider,
              FacebookAuthButton(
                onPressed: () {},
                darkMode: true,
                isLoading: isLoading,
                style: const AuthButtonStyle(
                  buttonType: null,
                  iconType: null,
                ),
              ),
              _divider,
              TwitterAuthButton(
                onPressed: () {},
                darkMode: true,
                isLoading: isLoading,
                style: const AuthButtonStyle(
                  buttonType: null,
                  iconType: null,
                ),
              )
            ]
          )
        )
      )
    );
  }
}

