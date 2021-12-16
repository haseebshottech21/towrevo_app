import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:towrevo/widgets/drawer_widget.dart';
import 'package:towrevo/widgets/full_background_image.dart';
import 'package:towrevo/widgets/towrevo_logo.dart';

class TermAndCondition extends StatefulWidget {
  static const routeName = '/terms-and-condition';
  const TermAndCondition({Key? key}) : super(key: key);

  @override
  State<TermAndCondition> createState() => _TermAndConditionState();
}

class _TermAndConditionState extends State<TermAndCondition> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<Map<String, String>> termAndConditon = [
    {
      'title': 'Agreement of Use',
      'description':
          'Please read these Terms of Service ("Agreement", "Terms of Service") carefully before using TowRevo (the site) and TowRevo App (associated application) operated by TowRevo LLC. \n\nBy accessing or using the Site or App in any manner, including, but not limited to, visiting or browsing the Site or the App or contributing content or other materials to the Site or App, you agree to be bound by these Terms of Service. Capitalized terms are defined in this Agreement.',
    },
    {
      'title': 'Intellectual Property',
      'description':
          'The Site, the App, and its original content, features, and functionality are owned by TowRevo LLC and are protected by international copyright, trademark, patent, trade secret, and other intellectual property or proprietary rights laws.',
    },
    {
      'title': 'Links to Other Sites or Apps',
      'description':
          'Our Site or App may contain links to third-party sites that are not owned or controlled by TowRevo LLC. TowRevo LLC assumes no responsibility for the content, privacy policies, or practices of any third-party sites or services. We strongly advise you to read the terms and conditions and privacy policy of any third-party site that you visit or app that you use.'
    },
    {
      'title': 'Governing Law',
      'description':
          'This Agreement (and any further rules, policies, or guidelines incorporated by reference) shall be governed and construed in accordance with the laws of the United States without giving effect to any principles of conflicts of law.'
    },
    {
      'title': 'Termination',
      'description':
          'We may terminate your access to the Site or the App without cause or notice, which may result in the forfeiture and destruction of all information associated with you.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawerEnableOpenDragGesture: false,
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            const FullBackgroundImage(),
            Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
                top: 30.0,
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
                  padding: EdgeInsets.zero,
                  icon: const FaIcon(
                    FontAwesomeIcons.bars,
                    color: Colors.white,
                    size: 15.0,
                  ),
                  onPressed: () {
                    scaffoldKey.currentState!.openDrawer();
                  },
                ),
              ),
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
                    height: 15,
                  ),
                  FadeInDown(
                    duration: const Duration(milliseconds: 600),
                    child: const TowrevoLogo(),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  FadeInUp(
                    duration: const Duration(milliseconds: 600),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15.0,
                        vertical: 10.0,
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.72,
                      decoration: BoxDecoration(
                        color: const Color(0xFF092848).withOpacity(0.8),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Center(
                              child: Text(
                                'Term & Condition',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 25,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.60,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: termAndConditon.length,
                              itemBuilder: (ctx, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    titleTermAndCond(
                                      termAndConditon[index]['title']
                                          .toString(),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    descTermAndCond(
                                      termAndConditon[index]['description']
                                          .toString(),
                                    ),
                                  ],
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

Text titleTermAndCond(String title) {
  return Text(
    title,
    style: const TextStyle(
      color: Colors.blue,
      fontStyle: FontStyle.italic,
      fontSize: 22,
    ),
  );
}

Text descTermAndCond(String desc) {
  return Text(
    desc,
    style: const TextStyle(
      color: Colors.white,
      fontSize: 14,
    ),
  );
}
