import 'package:flutter/material.dart';
import 'package:natural_20/models/campaign_model.dart';

class CardCampaign extends StatelessWidget {
  CardCampaign({Key? key, this.campaign}) : super(key: key);
  Campaign? campaign;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      margin: const EdgeInsets.all(15),
      elevation: 10,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image(
              image: campaign?.imagen != ""
                ? NetworkImage('${campaign?.imagen}')
                : const AssetImage('assets/not-available_campaign.png')
                as ImageProvider,
              height: 184,  
              alignment: Alignment.topCenter,
              fit: BoxFit.fitWidth,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: ListTile(
                title: Text('${campaign?.nombre}'),
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
                  icon: const Icon(Icons.chevron_right)),
              ))
        ])));
  }
}
