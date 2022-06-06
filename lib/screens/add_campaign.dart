import 'package:natural_20/views/form_campaign_view.dart';
import 'package:flutter/material.dart';
import 'package:natural_20/settings/settings_color.dart';

class AddCampaignScreen extends StatefulWidget {
  const AddCampaignScreen({Key? key}) : super(key: key);
  @override
  State<AddCampaignScreen> createState() => _AddCampaignScreenState();
}

class _AddCampaignScreenState extends State<AddCampaignScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SettingsColor.primaryColor,
      appBar: AppBar(
        backgroundColor: SettingsColor.secondaryColor,
        title: const Text('Crear Campaña'),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: SettingsColor.textColor)),
      ),
      body: FormCampaign());
  }
}
