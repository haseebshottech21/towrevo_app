import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/view_model/company_home_screen_view_model.dart';
import 'package:towrevo/widgets/company_history_list.dart';
import 'package:towrevo/widgets/full_background_image.dart';
import 'company_home_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<CompanyHomeScreenViewModel>(context, listen: true);
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 2,
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back, color: Colors.white),
      //     onPressed: () =>
      //         Navigator.of(context).pushNamed(CompanyHomeScreen.routeName),
      //   ),
      //   backgroundColor: const Color(0xFF092848),
      //   centerTitle: true,
      //   title: const Text(
      //     'History',
      //     style: TextStyle(
      //       fontSize: 22.0,
      //       color: Colors.white,
      //       fontWeight: FontWeight.w700,
      //     ),
      //   ),
      // ),
      body: Stack(
        children: [
          const FullBackgroundImage(),
          SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                    top: 20.0,
                  ),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.095,
                    padding: const EdgeInsets.all(0.5),
                    decoration: BoxDecoration(
                      color: const Color(0xFF092848).withOpacity(0.6),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(CompanyHomeScreen.routeName);
                      },
                      icon: const FaIcon(
                        FontAwesomeIcons.arrowLeft,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  ),
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
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shrinkWrap: true,
                  itemCount: provider.companyHistoryList.length,
                  itemBuilder: (ctx, index) {
                    return CompanyHistoryList(
                      userImage: companyHistory[index]['user-image'].toString(),
                      userName: companyHistory[index]['user-name'].toString(),
                      userService:
                          companyHistory[index]['user-service'].toString(),
                      date: companyHistory[index]['date'].toString(),
                      status: provider.companyHistoryList[index].status == 1
                          ? 'Accept'
                          : provider.companyHistoryList[index].status == 2
                              ? 'Declie'
                              : 'Completed',
                      colors: provider.companyHistoryList[index].status == 1
                          ? Colors.green
                          : provider.companyHistoryList[index].status == 2
                              ? Colors.red
                              : Colors.blueGrey,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
