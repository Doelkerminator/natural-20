import 'package:flutter/material.dart';
import 'package:natural_20/screens/login_screen.dart';
import 'package:natural_20/screens/menu_screen.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/login': (BuildContext context) => const LoginScreen(),
    '/menu': (BuildContext context) => const MenuScreen(),
  };
}