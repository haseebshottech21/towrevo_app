import 'package:animate_do/animate_do.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:towrevo/widgets/widgets.dart';

class FAQs extends StatefulWidget {
  static const routeName = '/faqs';
  const FAQs({Key? key}) : super(key: key);

  @override
  State<FAQs> createState() => _FAQsState();
}

class _FAQsState extends State<FAQs> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<Map<String, String>> faqs = [
    {
      'question': 'What services I can request ?',
      'answer':
          '• Towing \n• Battery jump \n• Flat tire replacement \n• Door lock \n• Roadside assistance',
    },
    {
      'question': 'What type of service available ?',
      'answer': '• Hook-Towing \n• Flatbed-Towing \n• Heavy-duty Towing',
    },
    {
      'question': 'How many times I can request ?',
      'answer':
          '• Request is limited 3 time per session.  Otherwise you will blocked ',
    },
    {
      'question': 'Sign up per person ?',
      'answer': '• Each customer can sign up One time. No account sharing. ',
    },
    {
      'question': 'Company with multiple towing drivers ?',
      'answer':
          '• One account each company required. You can dispatch your drivers when you receive a job request',
    },
    {
      'question': 'Is there free trial ?',
      'answer':
          '• We do run different promotions throughout the year \n• Customer pay as you go \n• Tow companies monthly subscription. ',
    },
    {
      'question': 'How to cancel your account ?',
      'answer': 'Please email us at support@towrevo.com ',
    },
    {
      'question': 'How to contact us ? ',
      'answer': 'Please email us at support@towrevo.com ',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawerEnableOpenDragGesture: false,
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Stack(
          children: [
            const FullBackgroundImage(),
            Align(
              alignment: Alignment.topLeft,
              child: backIcon(context, () {
                Navigator.of(context).pop();
              }),
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
                  FadeInDown(
                    duration: const Duration(milliseconds: 600),
                    child: const TowrevoLogoSmall(),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  FadeInUp(
                    duration: const Duration(milliseconds: 600),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5.0,
                        vertical: 5.0,
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.80,
                      child: Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.75,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: faqs.length,
                              itemBuilder: (ctx, index) {
                                return faqContent(
                                  faqs[index]['question'].toString(),
                                  faqs[index]['answer'].toString(),
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
  }
}

FadeInUp faqContent(
  String question,
  String answer,
) {
  return FadeInUp(
    child: Card(
      color: const Color(0xFF092848).withOpacity(0.7),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ExpandablePanel(
          theme: const ExpandableThemeData(
            iconColor: Colors.white,
            iconPadding: EdgeInsets.only(bottom: 10),
          ),
          header: Text(
            question,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          collapsed: Text(
            answer,
            softWrap: true,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          expanded: Text(
            answer,
            softWrap: true,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    ),
  );
}
