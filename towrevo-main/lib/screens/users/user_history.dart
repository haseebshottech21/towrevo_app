import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/view_model/user_home_screen_view_model.dart';
import 'package:towrevo/widgets/Loaders/no_user.dart';
import 'package:towrevo/widgets/User/drawer_icon.dart';
import 'package:towrevo/widgets/User/user_history_list.dart';
import 'package:towrevo/widgets/circular_progress_indicator.dart';
import 'package:towrevo/widgets/drawer_widget.dart';
import 'package:towrevo/widgets/full_background_image.dart';

class UserHistory extends StatefulWidget {
  const UserHistory({Key? key}) : super(key: key);
  static const routeName = '/user-history';

  @override
  _UserHistoryState createState() => _UserHistoryState();
}

class _UserHistoryState extends State<UserHistory> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async {
      await Provider.of<UserHomeScreenViewModel>(context, listen: false)
          .getUserHistory();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserHomeScreenViewModel>(
      context,
      listen: true,
    );

    return Scaffold(
      key: scaffoldKey,
      drawerEnableOpenDragGesture: false,
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Stack(
          children: [
            const FullBackgroundImage(),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      drawerIcon(
                        context,
                        () {
                          scaffoldKey.currentState!.openDrawer();
                        },
                      ),
                      const SizedBox(width: 45),
                      Center(
                        child: Text(
                          'MY HISTORY',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 28.0,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                FadeInUp(
                  from: 40,
                  duration: const Duration(milliseconds: 500),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                      vertical: 10.0,
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.90,
                    // decoration: BoxDecoration(
                    //   color: const Color(0xFF092848).withOpacity(0.8),
                    //   borderRadius: BorderRadius.circular(10),
                    // ),
                    child: (provider.isLoading ||
                            provider.userHistoryList.isEmpty)
                        ? Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.50,
                              child: provider.isLoading
                                  ? circularProgress()
                                  : noDataImage(
                                      context,
                                      'NO USER HISTORY',
                                      'assets/images/towing.png',
                                    ),
                            ),
                          )
                        : Expanded(
                            // width: MediaQuery.of(context).size.width,
                            // height:
                            //     MediaQuery.of(context).size.height * 0.85,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: provider.userHistoryList.length,
                              itemBuilder: (ctx, index) {
                                print(' length : ' +
                                    provider.userHistoryList.length.toString());
                                return UserHistoryList(
                                  companyImage:
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhrlH9QlMjus9pQY0IPfd97FE7RdNVga3MY-lMqsaltgspxx3q_-Bg6wcOJDYGnPy1gIU&usqp=CAU',
                                  companyName: provider
                                      .userHistoryList[index].companyName,
                                  companyService: provider
                                      .userHistoryList[index].serviceName,
                                  date: provider.userHistoryList[index].date,
                                  // date: '12-12-31',
                                );
                              },
                            ),
                          ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
