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
              newsListSliver = const SliverToBoxAdapter(
                  child: CircularProgressIndicator());
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
              Image.asset('assets/campaignImage.jpg', fit: BoxFit.cover)),
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
    return child;
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

/*import 'dart:math';
import 'package:flutter/material.dart';

class CampaignScreen extends StatefulWidget {
  final String title;

  const CampaignScreen({Key? key, required this.title}) : super(key: key);

  @override
  _CampaignScreenState createState() => _CampaignScreenState();
}

class _CampaignScreenState extends State<CampaignScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    this.tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            elevation: 0,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(this.widget.title),
              background: Image.network(
                'http://img1.mukewang.com/5c18cf540001ac8206000338.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: StickyTabBarDelegate(
              child: TabBar(
                labelColor: Colors.black,
                controller: this.tabController,
                tabs: <Widget>[
                  Tab(text: 'Home'),
                  Tab(text: 'Profile'),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: this.tabController,
              children: <Widget>[
                Center(child: Text('Content of Home')),
                Center(child: Text('Content of Profile')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}*/


