import 'package:flutter/material.dart';
import 'package:natural_20/screens/add_campaign.dart';
import 'package:natural_20/screens/campaign_screen.dart';
import 'package:natural_20/screens/enciclopedia_screen.dart';
import 'package:natural_20/screens/login_screen.dart';
import 'package:natural_20/screens/menu_screen.dart';
import '../screens/detail_campaign_screen.dart';
import '../screens/CharacterEdit.dart';
import '../screens/CharacterScreen.dart';
import '../screens/detail_campaign_screen.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/login': (context) => const LoginScreen(),
    '/menu': (context) => const MenuScreen(),
    '/list_campaign': (context) => const CampaignScreen(),
    '/add_campaign': (context) => const AddCampaignScreen(),
    '/encyclopedia': (context) => const EnciclopediaScreen(),
    '/details_campaign': (context) => const DetailCampaign(),
    '/characters': (context) => const CharacterScreen(),
    '/character_form': (context) => const CharacterEditScreen()
  };
}