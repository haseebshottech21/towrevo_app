import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:towrevo/screens/company/company_pending_screen.dart';
import 'package:towrevo/widgets/drawer_widget.dart';

import 'company_ongoing_screen.dart';

class CompanyHomeScreen extends StatefulWidget {
  static const routeName = 'company-home';
  const CompanyHomeScreen({Key? key}) : super(key: key);

  @override
  _CompanyHomeScreenState createState() => _CompanyHomeScreenState();
}

class _CompanyHomeScreenState extends State<CompanyHomeScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawerEnableOpenDragGesture: true,
        drawer: const DrawerWidget(),
        appBar: AppBar(
          backgroundColor: const Color(0xFF092848),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(icon: FaIcon(FontAwesomeIcons.history)),
              Tab(icon: FaIcon(FontAwesomeIcons.userCheck)),
            ],
          ),
          title: Text('Near By Users'),
        ),
        body: const TabBarView(
          children: [
            CompanyPendingList(),
            CompanyOngoingList(),
          ],
        ),
      ),
    );
    // return DefaultTabController(
    //   length: 5,
    //   child: Scaffold(
    //     drawerEnableOpenDragGesture: true,
    //     drawer: const DrawerWidget(),
    //     body: NestedScrollView(
    //       headerSliverBuilder: (
    //         BuildContext context,
    //         bool innerBoxIsScrolled,
    //       ) {
    //         return [
    //           const SliverAppBar(
    //             backgroundColor: Color(0xFF092848),
    //             title: Text('Tabs Demo'),
    //             pinned: true,
    //             floating: true,
    //             bottom: TabBar(
    //               indicatorSize: TabBarIndicatorSize.label,
    //               isScrollable: true,
    //               tabs: [
    //                 Tab(child: Text('Flight')),
    //                 Tab(child: Text('Train')),
    //                 Tab(child: Text('Car')),
    //                 Tab(child: Text('Cycle')),
    //                 Tab(child: Text('Boat')),
    //               ],
    //             ),
    //           ),
    //         ];
    //       },
    //       body: const TabBarView(
    //         children: <Widget>[
    //           // Icon(Icons.flight, size: 350),
    //           CompanyPendingList(),
    //           Icon(Icons.directions_transit, size: 350),
    //           Icon(Icons.directions_car, size: 350),
    //           Icon(Icons.directions_bike, size: 350),
    //           Icon(Icons.directions_boat, size: 350),
    //         ],
    //       ),
    //     ),
    //   ),
    // );

    // return Scaffold(
    //   key: scaffoldKey,
    //   drawerEnableOpenDragGesture: true,
    //   drawer: const DrawerWidget(),
    //   body: Stack(
    //     children: [
    //       const BackgroundImage(),
    //       provider.isLoading
    //           ? const Center(
    //               child: CircularProgressIndicator(),
    //             )
    //           : provider.requestServiceList.isEmpty
    //               ? const Center(
    //                   child: Text('No Data Found'),
    //                 )
    //               : ListView.builder(
    //                   itemBuilder: (ctx, index) {
    //                     return Card(
    //                       child: Column(
    //                         mainAxisSize: MainAxisSize.min,
    //                         children: <Widget>[
    //                           const ListTile(
    //                             leading: Icon(Icons.album),
    //                             title: Text('The Enchanted Nightingale'),
    //                             subtitle: Text(
    //                                 'Music by Julie Gable. Lyrics by Sidney Stein.'),
    //                           ),
    //                           Row(
    //                             mainAxisAlignment: MainAxisAlignment.end,
    //                             children: <Widget>[
    //                               TextButton(
    //                                 child: const Text('Decline'),
    //                                 onPressed: () {/* ... */},
    //                               ),
    //                               const SizedBox(width: 8),
    //                               TextButton(
    //                                 child: const Text('Accept'),
    //                                 onPressed: () {/* ... */},
    //                               ),
    //                               const SizedBox(width: 8),
    //                             ],
    //                           ),
    //                         ],
    //                       ),
    //                     );
    //                     // return Container(
    //                     //   padding:
    //                     //   const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    //                     //   child: Row(
    //                     //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     //     children: [
    //                     //       Flexible(
    //                     //         flex: 7,
    //                     //         child: Row(
    //                     //           children: [
    //                     //             ClipOval(
    //                     //               child: Image.asset(
    //                     //                 // user.profilePicture,
    //                     //                 'assets/images/bg2.jpg',
    //                     //                 width: 60,
    //                     //                 height: 65,
    //                     //                 fit: BoxFit.cover,
    //                     //               ),
    //                     //             ),
    //                     //             Container(
    //                     //               padding: const EdgeInsets.only(left: 10),
    //                     //               child: Column(
    //                     //                   mainAxisSize: MainAxisSize.min,
    //                     //                   mainAxisAlignment: MainAxisAlignment.start,
    //                     //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                     //                   children: [
    //                     //                     Text(
    //                     //                       'Love Kumar',
    //                     //                       style:
    //                     //                       Theme.of(context).textTheme.bodyText1,
    //                     //                     ),
    //                     //                     const SizedBox(
    //                     //                       height: 2,
    //                     //                     ),
    //                     //                     Container(
    //                     //                       height: null,
    //                     //                       width: 200,
    //                     //                       child: const Text(
    //                     //                         'Tariq Road, Pakistan Employee Co-operative Housing Society, Jamshed Town 75100, Pakistan',
    //                     //                         maxLines: 3,
    //                     //                         overflow: TextOverflow.ellipsis,
    //                     //                         softWrap: true,
    //                     //
    //                     //                       ),
    //                     //                     ),
    //                     //                   ]),
    //                     //             ),
    //                     //           ],
    //                     //         ),
    //                     //       ),
    //                     //       Flexible(
    //                     //         flex: 3,
    //                     //         child: Container(
    //                     //           constraints: const BoxConstraints(maxWidth: 100),
    //                     //           child: Row(
    //                     //             children: [
    //                     //               IconButton(
    //                     //                 onPressed: () {},
    //                     //                 icon: const CircleAvatar(
    //                     //                   maxRadius: 20,
    //                     //                   child: Icon(
    //                     //                     Icons.check_outlined,
    //                     //                   ),
    //                     //                 ),
    //                     //               ),
    //                     //               IconButton(
    //                     //                 onPressed: () {},
    //                     //                 icon: const CircleAvatar(
    //                     //                   backgroundColor: Colors.black12,
    //                     //                   maxRadius: 20,
    //                     //                   child: Icon(
    //                     //                     Icons.clear,
    //                     //                     color: Colors.black54,
    //                     //                   ),
    //                     //                 ),
    //                     //               ),
    //                     //             ],
    //                     //           ),),
    //                     //       )
    //                     //     ],
    //                     //   ),
    //                     // );
    //                   },
    //                   itemCount: provider.requestServiceList.length,
    //                 ),
    //       Padding(
    //         padding: const EdgeInsets.only(left: 10.0, top: 15.0),
    //         child: IconButton(
    //           icon: const Icon(Icons.menu, size: 20.0),
    //           onPressed: () {
    //             scaffoldKey.currentState!.openDrawer();
    //           },
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
