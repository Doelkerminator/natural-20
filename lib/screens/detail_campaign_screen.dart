import 'package:flutter/material.dart';
import '../settings/settings_color.dart';

class DetailCampaign extends StatefulWidget {
  const DetailCampaign({Key? key}) : super(key: key);

  @override
  State<DetailCampaign> createState() => _DetailCampaignState();
}

class _DetailCampaignState extends State<DetailCampaign> with SingleTickerProviderStateMixin {
  late Map<String, dynamic> campaign;
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    campaign = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          sliverBar(campaign),
          SliverPersistentHeader (// TabBar que puede ser techo
            pinned: true,
            delegate: StickyTabBarDelegate(
              child: TabBar(
                labelColor: Colors.black,
                controller: tabController,
                tabs: const [
                  Tab(text: 'Detalles'),
                  Tab(text: 'Notas'),
                  Tab(text: 'Personajes'),
                ],
              ),
            ),
          ),
          SliverFillRemaining (// contenido suplementario restante TabBarView
            child: TabBarView(
              controller: this.tabController,
              children: <Widget>[
                Center(child: Text('Content of Home')),
                Center(child: Text('Content of Profile')),
                Center(child: Text('Content of Profile')),
              ],
            ),
          ),
        ],
      )
    );
  }

  Widget sliverBar(Map<String, dynamic> camp) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      elevation: 0,
      expandedHeight: MediaQuery.of(context).size.height / 2.2,
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: SettingsColor.textColor)),
      flexibleSpace: FlexibleSpaceBar(
          title: Text("${camp['name']}"),
          background:
              camp['image'] != "" ? Image.network("${camp['image']}", fit: BoxFit.cover) 
              : Image.asset('assets/not-available_campaign.png', fit: BoxFit.cover)),
    );
  }

  Widget Detalles(){
    
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

