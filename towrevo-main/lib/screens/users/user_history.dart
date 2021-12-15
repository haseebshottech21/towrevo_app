import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:towrevo/screens/users/users_home_screen.dart';
import 'package:towrevo/widgets/User/user_history_list.dart';
import 'package:towrevo/widgets/full_background_image.dart';

class UserHistory extends StatefulWidget {
  const UserHistory({Key? key}) : super(key: key);

  @override
  _UserHistoryState createState() => _UserHistoryState();
}

class _UserHistoryState extends State<UserHistory> {
  List<Map<String, String>> userHistory = [
    {
      'company-name': 'Company 1',
      'company-service': 'Tow Car',
      'company-image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhrlH9QlMjus9pQY0IPfd97FE7RdNVga3MY-lMqsaltgspxx3q_-Bg6wcOJDYGnPy1gIU&usqp=CAU',
      'date': '15-Dec-2021',
    },
    {
      'company-name': 'Company 2',
      'company-service': 'Tow Car',
      'company-image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhrlH9QlMjus9pQY0IPfd97FE7RdNVga3MY-lMqsaltgspxx3q_-Bg6wcOJDYGnPy1gIU&usqp=CAU',
      'date': '15-Dec-2021',
    },
    {
      'company-name': 'Company 3',
      'company-service': 'Tow Car',
      'company-image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhrlH9QlMjus9pQY0IPfd97FE7RdNVga3MY-lMqsaltgspxx3q_-Bg6wcOJDYGnPy1gIU&usqp=CAU',
      'date': '15-Dec-2021',
    },
    {
      'company-name': 'Company 4',
      'company-service': 'Tow Car',
      'company-image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhrlH9QlMjus9pQY0IPfd97FE7RdNVga3MY-lMqsaltgspxx3q_-Bg6wcOJDYGnPy1gIU&usqp=CAU',
      'date': '15-Dec-2021',
    },
    {
      'company-name': 'Company 5',
      'company-service': 'Tow Car',
      'company-image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhrlH9QlMjus9pQY0IPfd97FE7RdNVga3MY-lMqsaltgspxx3q_-Bg6wcOJDYGnPy1gIU&usqp=CAU',
      'date': '15-Dec-2021',
    },
    {
      'company-name': 'Company 6',
      'company-service': 'Tow Car',
      'company-image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhrlH9QlMjus9pQY0IPfd97FE7RdNVga3MY-lMqsaltgspxx3q_-Bg6wcOJDYGnPy1gIU&usqp=CAU',
      'date': '15-Dec-2021',
    },
    {
      'company-name': 'Company 7',
      'company-service': 'Tow Car',
      'company-image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhrlH9QlMjus9pQY0IPfd97FE7RdNVga3MY-lMqsaltgspxx3q_-Bg6wcOJDYGnPy1gIU&usqp=CAU',
      'date': '15-Dec-2021',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 2,
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back, color: Colors.white),
      //     onPressed: () =>
      //         Navigator.of(context).pushNamed(UsersHomeScreen.routeName),
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
                        // Navigator.of(context)
                        //     .pushNamed(UsersHomeScreen.routeName);
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
                  itemCount: userHistory.length,
                  itemBuilder: (ctx, index) {
                    return UserHistoryList(
                      companyImage:
                          userHistory[index]['company-image'].toString(),
                      companyName:
                          userHistory[index]['company-name'].toString(),
                      companyService:
                          userHistory[index]['company-service'].toString(),
                      date: userHistory[index]['date'].toString(),
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
