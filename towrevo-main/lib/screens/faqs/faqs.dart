import 'package:animate_do/animate_do.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:towrevo/widgets/User/drawer_icon.dart';
import 'package:towrevo/widgets/drawer_widget.dart';
import 'package:towrevo/widgets/full_background_image.dart';
import 'package:towrevo/widgets/towrevo_logo.dart';

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
      'question': 'Question',
      'answer':
          'Please read these Terms of Service ("Agreement", "Terms of Service") carefully before using TowRevo (the site) and TowRevo App (associated application) operated by TowRevo LLC. \n\nBy accessing or using the Site or App in any manner, including, but not limited to, visiting or browsing the Site or the App or contributing content or other materials to the Site or App, you agree to be bound by these Terms of Service. Capitalized terms are defined in this Agreement.',
    },
    {
      'question': 'Question',
      'answer':
          'Please read these Terms of Service ("Agreement", "Terms of Service") carefully before using TowRevo (the site) and TowRevo App (associated application) operated by TowRevo LLC. \n\nBy accessing or using the Site or App in any manner, including, but not limited to, visiting or browsing the Site or the App or contributing content or other materials to the Site or App, you agree to be bound by these Terms of Service. Capitalized terms are defined in this Agreement.',
    },
    {
      'question': 'Question',
      'answer':
          'Please read these Terms of Service ("Agreement", "Terms of Service") carefully before using TowRevo (the site) and TowRevo App (associated application) operated by TowRevo LLC. \n\nBy accessing or using the Site or App in any manner, including, but not limited to, visiting or browsing the Site or the App or contributing content or other materials to the Site or App, you agree to be bound by these Terms of Service. Capitalized terms are defined in this Agreement.',
    },
    {
      'question': 'Question',
      'answer':
          'Please read these Terms of Service ("Agreement", "Terms of Service") carefully before using TowRevo (the site) and TowRevo App (associated application) operated by TowRevo LLC. \n\nBy accessing or using the Site or App in any manner, including, but not limited to, visiting or browsing the Site or the App or contributing content or other materials to the Site or App, you agree to be bound by these Terms of Service. Capitalized terms are defined in this Agreement.',
    },
    {
      'question': 'Question',
      'answer':
          'Please read these Terms of Service ("Agreement", "Terms of Service") carefully before using TowRevo (the site) and TowRevo App (associated application) operated by TowRevo LLC. \n\nBy accessing or using the Site or App in any manner, including, but not limited to, visiting or browsing the Site or the App or contributing content or other materials to the Site or App, you agree to be bound by these Terms of Service. Capitalized terms are defined in this Agreement.',
    },
    {
      'question': 'Question',
      'answer':
          'Please read these Terms of Service ("Agreement", "Terms of Service") carefully before using TowRevo (the site) and TowRevo App (associated application) operated by TowRevo LLC. \n\nBy accessing or using the Site or App in any manner, including, but not limited to, visiting or browsing the Site or the App or contributing content or other materials to the Site or App, you agree to be bound by these Terms of Service. Capitalized terms are defined in this Agreement.',
    },
    {
      'question': 'Question',
      'answer':
          'Please read these Terms of Service ("Agreement", "Terms of Service") carefully before using TowRevo (the site) and TowRevo App (associated application) operated by TowRevo LLC. \n\nBy accessing or using the Site or App in any manner, including, but not limited to, visiting or browsing the Site or the App or contributing content or other materials to the Site or App, you agree to be bound by these Terms of Service. Capitalized terms are defined in this Agreement.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawerEnableOpenDragGesture: false,
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
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
                    height: 15,
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
                      // decoration: BoxDecoration(
                      //   color: const Color(0xFF092848).withOpacity(0.8),
                      //   borderRadius: BorderRadius.circular(10),
                      // ),
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

    // return Scaffold(
    //   key: scaffoldKey,
    //   drawerEnableOpenDragGesture: false,
    //   drawer: const DrawerWidget(),
    //   body: Stack(
    //     children: [
    //       const FullBackgroundImage(),
    //       SingleChildScrollView(
    //         physics: const ScrollPhysics(),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             drawerIcon(
    //               context,
    //               () {
    //                 scaffoldKey.currentState!.openDrawer();
    //               },
    //             ),
    //             FadeInDown(
    //               duration: const Duration(milliseconds: 600),
    //               child: const TowrevoLogoSmall(),
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.symmetric(
    //                 vertical: 15,
    //                 horizontal: 5,
    //               ),
    //               child: Column(
    //                 children: [
    //                   // const Text(
    //                   //   'FAQ\'s',
    //                   //   style: TextStyle(
    //                   //     color: Colors.black,
    //                   //     fontWeight: FontWeight.bold,
    //                   //     fontSize: 25,
    //                   //   ),
    //                   // ),
    //                   const SizedBox(
    //                     height: 5,
    //                   ),
    //                   ListView.builder(
    //                     physics: const NeverScrollableScrollPhysics(),
    //                     padding: EdgeInsets.zero,
    //                     shrinkWrap: true,
    //                     itemCount: faqs.length,
    //                     itemBuilder: (ctx, index) {
    //                       return faqContent(
    //                         faqs[index]['question'].toString(),
    //                         faqs[index]['answer'].toString(),
    //                       );
    //                     },
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ],
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }
}

FadeInUp faqContent(
  String question,
  String answer,
) {
  return FadeInUp(
    child: Card(
      // elevation: 6,
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
            maxLines: 2,
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
