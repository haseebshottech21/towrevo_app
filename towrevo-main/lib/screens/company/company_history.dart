import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/view_model/company_home_screen_view_model.dart';
import 'package:towrevo/widgets/User/drawer_icon.dart';
import 'package:towrevo/widgets/company_history_list.dart';
import 'package:towrevo/widgets/drawer_widget.dart';
import 'package:towrevo/widgets/full_background_image.dart';

class CompanyHistory extends StatefulWidget {
  const CompanyHistory({Key? key}) : super(key: key);

  static const routeName = '/comppany-history';

  @override
  _CompanyHistoryState createState() => _CompanyHistoryState();
}

class _CompanyHistoryState extends State<CompanyHistory> {
  List<Map<String, String>> companyHistory = [
    {
      'user-name': 'User Name 1',
      'user-service': 'Tow Car',
      'user-image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhrlH9QlMjus9pQY0IPfd97FE7RdNVga3MY-lMqsaltgspxx3q_-Bg6wcOJDYGnPy1gIU&usqp=CAU',
      'status': 'Accept',
      'date': '15-Dec-2021',
    },
    {
      'user-name': 'User Name 2',
      'user-service': 'Tow Van',
      'user-image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhrlH9QlMjus9pQY0IPfd97FE7RdNVga3MY-lMqsaltgspxx3q_-Bg6wcOJDYGnPy1gIU&usqp=CAU',
      'status': 'Decline',
      'date': '13-Dec-2021',
    },
    {
      'user-name': 'User Name 3',
      'user-service': 'Tow Truck',
      'user-image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhrlH9QlMjus9pQY0IPfd97FE7RdNVga3MY-lMqsaltgspxx3q_-Bg6wcOJDYGnPy1gIU&usqp=CAU',
      'status': 'Completed',
      'date': '18-Dec-2021',
    },
    {
      'user-name': 'User Name 3',
      'user-service': 'Tow Truck',
      'user-image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhrlH9QlMjus9pQY0IPfd97FE7RdNVga3MY-lMqsaltgspxx3q_-Bg6wcOJDYGnPy1gIU&usqp=CAU',
      'status': 'Completed',
      'date': '18-Dec-2021',
    },
    {
      'user-name': 'User Name 3',
      'user-service': 'Tow Truck',
      'user-image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhrlH9QlMjus9pQY0IPfd97FE7RdNVga3MY-lMqsaltgspxx3q_-Bg6wcOJDYGnPy1gIU&usqp=CAU',
      'status': 'Completed',
      'date': '18-Dec-2021',
    },
  ];

  @override
  void initState() {
    Provider.of<CompanyHomeScreenViewModel>(context, listen: false)
        .getCompanyHistrory();
    super.initState();
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CompanyHomeScreenViewModel>(
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
            drawerIcon(
              context,
              () {
                scaffoldKey.currentState!.openDrawer();
              },
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 20.0,
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  const Center(
                    child: Text(
                      'History',
                      style: TextStyle(
                        fontSize: 22.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  FadeInUp(
                    duration: const Duration(milliseconds: 600),
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
                      child: Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.85,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: provider.companyHistoryList.length,
                              itemBuilder: (ctx, index) {
                                return CompanyHistoryList(
                                  userImage: companyHistory[index]['user-image']
                                      .toString(),
                                  userName: companyHistory[index]['user-name']
                                      .toString(),
                                  userService: companyHistory[index]
                                          ['user-service']
                                      .toString(),
                                  date:
                                      companyHistory[index]['date'].toString(),
                                  status: provider.companyHistoryList[index]
                                              .status ==
                                          1
                                      ? 'Accept'
                                      : provider.companyHistoryList[index]
                                                  .status ==
                                              2
                                          ? 'Declie'
                                          : 'Completed',
                                  colors: provider.companyHistoryList[index]
                                              .status ==
                                          1
                                      ? Colors.green
                                      : provider.companyHistoryList[index]
                                                  .status ==
                                              2
                                          ? Colors.red
                                          : Colors.blueGrey,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );

    // return Scaffold(
    //   key: scaffoldKey,
    //   drawerEnableOpenDragGesture: false,
    //   drawer: const DrawerWidget(),
    //   body: SingleChildScrollView(
    //     physics: const ScrollPhysics(),
    //     child: Stack(
    //       children: [
    //         const FullBackgroundImage(),
    //         drawerIcon(
    //           context,
    //           () {
    //             scaffoldKey.currentState!.openDrawer();
    //           },
    //         ),
    //         Container(
    //           alignment: Alignment.center,
    //           padding: const EdgeInsets.symmetric(
    //             horizontal: 10.0,
    //             vertical: 15.0,
    //           ),
    //           child: Column(
    //             children: [
    //               const SizedBox(
    //                 height: 30,
    //               ),
    //               const Center(
    //                 child: Text(
    //                   'History',
    //                   style: TextStyle(
    //                     fontSize: 22.0,
    //                     color: Colors.white,
    //                     fontWeight: FontWeight.w700,
    //                   ),
    //                 ),
    //               ),
    //               FadeInUp(
    //                 duration: const Duration(milliseconds: 600),
    //                 child: Container(
    //                   padding: const EdgeInsets.symmetric(
    //                     horizontal: 5.0,
    //                     vertical: 5.0,
    //                   ),
    //                   width: MediaQuery.of(context).size.width,
    //                   height: MediaQuery.of(context).size.height * 0.90,
    //                   // decoration: BoxDecoration(
    //                   //   color: const Color(0xFF092848).withOpacity(0.8),
    //                   //   borderRadius: BorderRadius.circular(10),
    //                   // ),
    //                   child: Column(
    //                     children: [
    //                       SizedBox(
    //                         width: MediaQuery.of(context).size.width,
    //                         height: MediaQuery.of(context).size.height * 0.85,
    //                         child: ListView.builder(
    //                           physics: const ScrollPhysics(),
    //                           padding: const EdgeInsets.symmetric(vertical: 10),
    //                           shrinkWrap: true,
    //                           itemCount: provider.companyHistoryList.length,
    //                           itemBuilder: (ctx, index) {
    //                             return CompanyHistoryList(
    //                               userImage: companyHistory[index]['user-image']
    //                                   .toString(),
    //                               userName: companyHistory[index]['user-name']
    //                                   .toString(),
    //                               userService: companyHistory[index]
    //                                       ['user-service']
    //                                   .toString(),
    //                               date:
    //                                   companyHistory[index]['date'].toString(),
    //                               status: provider.companyHistoryList[index]
    //                                           .status ==
    //                                       1
    //                                   ? 'Accept'
    //                                   : provider.companyHistoryList[index]
    //                                               .status ==
    //                                           2
    //                                       ? 'Declie'
    //                                       : 'Completed',
    //                               colors: provider.companyHistoryList[index]
    //                                           .status ==
    //                                       1
    //                                   ? Colors.green
    //                                   : provider.companyHistoryList[index]
    //                                               .status ==
    //                                           2
    //                                       ? Colors.red
    //                                       : Colors.blueGrey,
    //                             );
    //                           },
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               )
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
