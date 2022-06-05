import 'package:flutter/material.dart';
import 'package:natural_20/database/database_firestore.dart';
import 'package:natural_20/models/campaign_model.dart';
import 'package:natural_20/settings/settings_color.dart';
import 'package:natural_20/views/card_campaign.dart';

class CampaignScreen extends StatefulWidget {
  const CampaignScreen({Key? key}) : super(key: key);
  @override
  State<CampaignScreen> createState() => _CampaignScreenState();
}

class _CampaignScreenState extends State<CampaignScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SettingsColor.primaryColor,
      body: FutureBuilder(
        future: DatabaseFirestore.getCampaignsCreates(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Campaign>?> snapshot) {
          Widget newsListSliver;
          if (snapshot.hasError) {
            return const Center(
              child: Text('Ocurrio un error en la solicitud'),
            );
          } else {
            if (snapshot.hasData) {
              newsListSliver = sliverBody(snapshot.data);
            } else {
              newsListSliver = const Center(child: Text("No hay partidas creadas"));
            } 
            return scrollView(newsListSliver);
          }
        }),
    );
  }

  Widget scrollView(Widget bodyCampaigns) {
    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
        headerSliverBuilder: (context, value) {
          return [
            sliverBar(),
            sliverHeader()
          ];
        },
        body: bodyCampaigns,
      )
    );
  }

  Widget sliverHeader() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: StickyTabBarDelegate(
        child: TabBar(
          labelColor: Colors.black,
          controller: tabController,
          tabs: const <Widget>[
            Tab(text: 'Campañas Creadas'),
            Tab(text: 'Campañas en Juego'),
          ],
        ),
      ),
    );
  }

  Widget sliverBar() {
    return SliverAppBar(
      floating: true,
      pinned: true,
      elevation: 0,
      expandedHeight: 250,
      backgroundColor: SettingsColor.secondaryColor,
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: SettingsColor.textColor)),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/add_campaign');
          },
          icon: Icon(Icons.add, color: SettingsColor.textColor))
      ],
      flexibleSpace: FlexibleSpaceBar(
          title: const Text('Campañas'),
          background:
              Image.asset('assets/images/campaignImage.jpg', fit: BoxFit.cover)),
    );
  }

  Widget sliverBody(List<Campaign>? campaigns) {
    return TabBarView(controller: tabController, children: <Widget>[
      ListView.builder(
        itemCount: campaigns?.length,
        itemBuilder: (context, index) {
          Campaign campaigne = campaigns![index];
          return CardCampaign(campaign: campaigne);
        }),
      const Center(child: Text('Campañas en Juego')),
    ]);
  }
}

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;

  StickyTabBarDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(color: Colors.white, child: child);
  }

  @override
  double get maxExtent => child.preferredSize.height;

  @override
  double get minExtent => child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}