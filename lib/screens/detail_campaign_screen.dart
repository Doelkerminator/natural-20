import 'package:flutter/material.dart';
import 'package:natural_20/models/campaign_model.dart';
import 'package:natural_20/providers/add_note_notifier.dart';
import 'package:natural_20/views/form_campaign_view.dart';
import 'package:natural_20/views/form_note_view.dart';
import 'package:natural_20/views/list_characters_by_campaign.dart';
import 'package:natural_20/views/list_notes_view.dart';
import 'package:provider/provider.dart';
import '../settings/settings_color.dart';

class DetailCampaign extends StatefulWidget {
  const DetailCampaign({Key? key}) : super(key: key);

  @override
  State<DetailCampaign> createState() => _DetailCampaignState();
}

class _DetailCampaignState extends State<DetailCampaign>
    with SingleTickerProviderStateMixin {
  late Map<String, dynamic> campaign;
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    campaign =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        sliverBar(campaign),
        SliverPersistentHeader(
          // TabBar que puede ser techo
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
        SliverFillRemaining(
          child: TabBarView(
            controller: tabController,
            children: <Widget>[
              Center(child: detalles(campaign)),
              notas(campaign['id']),
              characters(campaign['id']),
            ],
          ),
        ),
      ],
    ));
  }

  Widget sliverBar(Map<String, dynamic> camp) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      elevation: 0,
      expandedHeight: MediaQuery.of(context).size.height / 2.2,
      leading: IconButton(
        onPressed: () {
          context.read<AddNoteState>().changeStateToList();
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back, color: SettingsColor.textColor)),
      flexibleSpace: FlexibleSpaceBar(
        title: Text("${camp['name']}"),
        background: Opacity(
          opacity: 0.7,
          child: Container(
            color: Colors.black,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: camp['image'] != "" ? NetworkImage("${camp['image']}") : AssetImage('assets/images/not-available_campaign.png') as ImageProvider,
                  fit: BoxFit.cover
                )
              ),
            )
          ),
        )
      ),
    );
  }

  Widget detalles(Map<String, dynamic> camp) {
    return FormCampaign(objCampaig: Campaign.fromMap(camp));
  }

  Widget notas(String id) {
    Widget not = Container();
    if (context.watch<AddNoteState>().stateNotes == "List") {
      not = ListNotesView(idCampaign: id);
    } else if (context.watch<AddNoteState>().stateNotes == "Create") {
      not = Center(child: FormNote(idCampaign: id));
    } else if (context.watch<AddNoteState>().stateNotes == "Edit") {
      not = Center(
          child: FormNote(
              objNote: context.watch<AddNoteState>().noteE, idCampaign: id));
    }
    return not;
  }

  Widget characters(String id) {
    return ListCharactersByCampaign(idCampaign: id);
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
