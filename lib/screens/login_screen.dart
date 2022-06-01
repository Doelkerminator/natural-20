import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:natural_20/Auth/AuthenticatorFacebook.dart';
import 'package:natural_20/Auth/AuthenticatorGoogle.dart';
import 'package:natural_20/Auth/AuthenticatorTwittter.dart';
import 'package:natural_20/providers/login_notifier.dart';
import 'package:natural_20/screens/menu_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var screenSizes = MediaQuery.of(context).size;
    Divider _divider = const Divider(height: 10);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Natural 20")
      ),
      body: SingleChildScrollView(
        child: IgnorePointer(
          ignoring: context.watch<LoginState>().enabledButtons,
          child: Column(
            children: [
              const SizedBox(height: 24),
              Image.asset("assets/logo.png", width: screenSizes.width / 1.5),
              gAuthButton(),  
              _divider,
              fAuthButton(),
              _divider,
              tAuthButton(),
              _divider
            ]
          )
        )
      )
    );
  }

  Widget gAuthButton(){
    return GoogleAuthButton(
      isLoading: context.watch<LoginState>().isLoading1,
      onPressed: () async {
        context.read<LoginState>().changeEnabledButtons();
        context.read<LoginState>().changeLoad1();
        if(await AuthenticatorGoogle.initSession(context: context) != null){
          context.read<LoginState>().changeEnabledButtons();
          context.read<LoginState>().changeLoad1();
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const MenuScreen()), (route) => false);
          context.read<LoginState>().changeEnabledButtons();
          context.read<LoginState>().changeLoad1();
        }
        context.read<LoginState>().changeLoad1();
        context.read<LoginState>().changeEnabledButtons();
      },
      style: const AuthButtonStyle(
        buttonType: null,
        iconType: null,
      ),
    );
  }

  Widget fAuthButton(){
    return FacebookAuthButton(
      isLoading: context.watch<LoginState>().isLoading2,
      onPressed: () async {
        context.read<LoginState>().changeEnabledButtons();
        context.read<LoginState>().changeLoad2();
        if(await AuthenticatorFacebook.initSession(context: context) != null){
          context.read<LoginState>().changeEnabledButtons();
          context.read<LoginState>().changeLoad2();
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const MenuScreen()), (route) => false);
          context.read<LoginState>().changeEnabledButtons();
          context.read<LoginState>().changeLoad2();
        }
        context.read<LoginState>().changeLoad2();
        context.read<LoginState>().changeEnabledButtons();
      },
      style: const AuthButtonStyle(
        buttonType: null,
        iconType: null,
      )
    );
  }

  Widget tAuthButton(){
    return TwitterAuthButton(
      isLoading: context.watch<LoginState>().isLoading3,
      onPressed: () async {
        context.read<LoginState>().changeEnabledButtons();
        context.read<LoginState>().changeLoad3();
        if(await AuthenticatorTwitter.initSession(context: context) != null){
          context.read<LoginState>().changeEnabledButtons();
          context.read<LoginState>().changeLoad3();
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const MenuScreen()), (route) => false);
          context.read<LoginState>().changeEnabledButtons();
          context.read<LoginState>().changeLoad3();
        }
        context.read<LoginState>().changeLoad3();
        context.read<LoginState>().changeEnabledButtons();
      },
      style: const AuthButtonStyle(
        buttonType: null,
        iconType: null,
      )
    );
  }
}

