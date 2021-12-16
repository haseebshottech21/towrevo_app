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
          title: const Text('Near By Users'),
        ),
        body: const TabBarView(
          children: [
            CompanyPendingList(),
            CompanyOngoingList(),
          ],
        ),
      ),
    );
  }
}
