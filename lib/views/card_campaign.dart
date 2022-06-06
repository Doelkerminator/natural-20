import 'package:flutter/material.dart';
import 'package:natural_20/models/campaign_model.dart';
import 'package:natural_20/settings/settings_color.dart';

class CardCampaign extends StatelessWidget {
  CardCampaign({Key? key, this.campaign}) : super(key: key);
  Campaign? campaign;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: SettingsColor.secondaryColor,
      margin: const EdgeInsets.all(15),
      elevation: 10,
      child: ClipRRect(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image(
              image: campaign?.imagen != ""
                ? NetworkImage('${campaign?.imagen}')
                : const AssetImage('assets/images/not-available_campaign.png')
                as ImageProvider,
              height: MediaQuery.of(context).size.height / 3.5,   
              alignment: Alignment.topCenter,
              fit: BoxFit.fitWidth,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0),
              child: ListTile(
                title: Text('${campaign?.nombre}', style: TextStyle(color: SettingsColor.textColor)),
                trailing: IconButton(
                  onPressed: () {
                    print(campaign);
                    Navigator.pushNamed(context, "/details_campaign", 
                    arguments: {
                      "id" : campaign!.id,
                      "name": campaign!.nombre,
                      "image": campaign!.imagen,
                      "detail": campaign!.detalles,
                      "creator": campaign!.creador,
                      "notes": campaign!.notas,
                    });
                  },
                  icon: const Icon(Icons.chevron_right), color: SettingsColor.textColor
                ),
              )
            )
          ]
        )
      )
    );
  }
}



