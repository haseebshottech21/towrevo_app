import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/widgets/widgets.dart';
import 'package:towrevo/screens/screens.dart';
import 'package:towrevo/view_model/view_model.dart';

class CompanyHomeScreen extends StatefulWidget {
  static const routeName = 'company-home';
  const CompanyHomeScreen({Key? key}) : super(key: key);

  @override
  _CompanyHomeScreenState createState() => _CompanyHomeScreenState();
}

class _CompanyHomeScreenState extends State<CompanyHomeScreen> {
  @override
  void initState() {
    Provider.of<UserHomeScreenViewModel>(context, listen: false)
        .updateDrawerInfo();
    super.initState();
  }

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
            CompanyPendingScreen(),
            CompanyOngoingScreen(),
          ],
        ),
      ),
    );
  }
}
