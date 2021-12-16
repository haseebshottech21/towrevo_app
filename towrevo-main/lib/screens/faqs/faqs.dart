import 'package:animate_do/animate_do.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      body: Stack(
        children: [
          const FullBackgroundImage(),
          SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                FadeInDown(
                  duration: const Duration(milliseconds: 600),
                  child: const TowrevoLogo(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 5,
                  ),
                  child: Column(
                    children: [
                      // const Text(
                      //   'FAQ\'s',
                      //   style: TextStyle(
                      //     color: Colors.black,
                      //     fontWeight: FontWeight.bold,
                      //     fontSize: 25,
                      //   ),
                      // ),
                      const SizedBox(
                        height: 5,
                      ),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: faqs.length,
                        itemBuilder: (ctx, index) {
                          return faqContent(
                            faqs[index]['question'].toString(),
                            faqs[index]['answer'].toString(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
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
          expanded: const Text(
            'The TowRevo app allows you to select your nearest towing service at your fingertips to help you get back on the road. Whether there is an issue related to a car blocking your way or you are stuck in a middle of a remote highway, our towing and roadside assistance have got your back 24/7.',
            softWrap: true,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    ),
  );
}
