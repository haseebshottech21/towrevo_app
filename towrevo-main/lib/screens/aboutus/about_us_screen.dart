import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:towrevo/widgets/User/drawer_icon.dart';
import 'package:towrevo/widgets/drawer_widget.dart';
import 'package:towrevo/widgets/full_background_image.dart';
import 'package:towrevo/widgets/towrevo_logo.dart';

class AboutUs extends StatefulWidget {
  static const routeName = '/about-us';
  const AboutUs({Key? key}) : super(key: key);

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<Map<String, String>> aboutUs = [
    {
      'title': 'Towing And Roadside Assistance At Your Fingertips',
      'description':
          'The TowRevo app allows you to select your nearest towing service at your fingertips to help you get back on the road. Whether there is an issue related to a car blocking your way or you are stuck in a middle of a remote highway, our towing and roadside assistance have got your back 24/7.',
    },
    {
      'title': 'Get A Tow Agent In Just 15 Minutes',
      'description':
          'Waiting hours for your towing company can be troublesome. Have a flat tire, a battery or engine failure, or a lockout; with TowRevo’s prompt and affordable service, our nearest towing agent will get to you in just 15 minutes. To us, you are our priority.',
    },
    {
      'title': 'Sign up for free',
      'description':
          'Sign up today for free without any membership fees or hidden charges to get full towing and transportation service across the United States, operating 24/7. We deal with various vehicles ranging from light-duty motorbikes & sedans to heavy-duty tractors and cranes.',
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
            drawerIconSecond(
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
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Center(
                              child: Text(
                                'Why TowRevo?',
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
                            height: MediaQuery.of(context).size.height * 0.62,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.vertical,
                              physics: const ScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: aboutUs.length,
                              itemBuilder: (ctx, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    aboutUsTitle(
                                      aboutUs[index]['title'].toString(),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    aboutUsDescription(
                                      aboutUs[index]['description'].toString(),
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

Text aboutUsTitle(String title) {
  return Text(
    title,
    style: const TextStyle(
      color: Colors.blue,
      fontStyle: FontStyle.italic,
      fontSize: 22,
    ),
  );
}

Text aboutUsDescription(String desc) {
  return Text(
    desc,
    style: const TextStyle(
      color: Colors.white,
      fontSize: 14,
    ),
  );
}
