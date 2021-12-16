import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/screens/aboutus/about_us_screen.dart';
import 'package:towrevo/screens/authentication/change_password/change_password.dart';
import 'package:towrevo/screens/company/company_history.dart';
import 'package:towrevo/screens/faqs/faqs.dart';
import 'package:towrevo/screens/term&condiotion/term&conditon_screen.dart';
import 'package:towrevo/view_model/login_view_model.dart';
import 'drawer_list_item_widget.dart';
import 'form_button_widget.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xFF092848),
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          // Important: Remove any padding from the ListView.
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5.0,
                    vertical: 20,
                  ),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.12,
                    width: MediaQuery.of(context).size.width * 0.30,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/logo.png',
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                DrawerListItem(
                  title: 'Home',
                  iconsData: Icons.play_arrow,
                  onPressed: () {
                    
                  },
                ),
                DrawerListItem(
                  title: 'About Us',
                  iconsData: Icons.play_arrow,
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(AboutUs.routeName);
                  },
                ),
                DrawerListItem(
                  title: 'History',
                  iconsData: Icons.play_arrow,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CompanyHistory(),
                      ),
                    );
                  },
                ),
                DrawerListItem(
                  title: 'Contact Us',
                  iconsData: Icons.play_arrow,
                  onPressed: () {},
                ),
                DrawerListItem(
                  title: 'FAQ\'s',
                  iconsData: Icons.play_arrow,
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(FAQs.routeName);
                  },
                ),
                DrawerListItem(
                  title: 'Change Password',
                  iconsData: Icons.play_arrow,
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(ChangePassword.routeName);
                  },
                ),
                DrawerListItem(
                  title: 'Term & Condition',
                  iconsData: Icons.play_arrow,
                  onPressed: () {
                     Navigator.of(context).pushReplacementNamed(TermAndCondition.routeName);
                  },
                ),
                DrawerListItem(
                  title: 'Privacy Policy',
                  iconsData: Icons.play_arrow,
                  onPressed: () {
                    
                  },
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 30),
                  child: FormButtonWidget(
                    'Logout',
                    () {
                      Provider.of<LoginViewModel>(context, listen: false)
                          .logoutRequest(context);
                    },
                  ),
                ),
                Center(
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                      ),
                      children: [
                        TextSpan(text: 'Copyright © 2021, '),
                        TextSpan(
                          text: 'Towrevo',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                const Center(
                  child: Text(
                    'All Rights Reserved',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );

    // return Drawer(
    //   child: Container(
    //     color: const Color(0xFF092848),
    //     child: Container(
    //       height: MediaQuery.of(context).size.height,
    //       padding: const EdgeInsets.symmetric(horizontal: 15),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         mainAxisSize: MainAxisSize.max,
    //         children: [
    //           Container(
    //             margin: const EdgeInsets.symmetric(vertical: 10),
    //             alignment: Alignment.centerLeft,
    //             child: Image.asset(
    //               'assets/images/logo.png',
    //               width: 150,
    //               height: 100,
    //             ),
    //           ),
    //           const SizedBox(
    //             height: 30,
    //           ),
    //           DrawerListItem(
    //             title: 'Home',
    //             iconsData: Icons.play_arrow,
    //             onPressed: () {},
    //           ),
    //           DrawerListItem(
    //             title: 'About us',
    //             iconsData: Icons.play_arrow,
    //             onPressed: () {
    //               Navigator.push(
    //                 context,
    //                 MaterialPageRoute(
    //                   builder: (context) => const AboutUs(),
    //                 ),
    //               );
    //             },
    //           ),
    //           DrawerListItem(
    //             title: 'Contact us',
    //             iconsData: Icons.play_arrow,
    //             onPressed: () {},
    //           ),
    //           DrawerListItem(
    //             title: 'FAQ\'s',
    //             iconsData: Icons.play_arrow,
    //             onPressed: () {
    //               Navigator.push(
    //                 context,
    //                 MaterialPageRoute(
    //                   builder: (context) => const FAQs(),
    //                 ),
    //               );
    //             },
    //           ),
    //           DrawerListItem(
    //             title: 'Change Password',
    //             iconsData: Icons.play_arrow,
    //             onPressed: () {},
    //           ),
    //           DrawerListItem(
    //             title: 'Terms and Condition',
    //             iconsData: Icons.play_arrow,
    //             onPressed: () {
    //               Navigator.push(
    //                 context,
    //                 MaterialPageRoute(
    //                   builder: (context) => const TermAndCondition(),
    //                 ),
    //               );
    //             },
    //           ),
    //           DrawerListItem(
    //             title: 'Privacy Policy',
    //             iconsData: Icons.play_arrow,
    //             onPressed: () {},
    //           ),
    //           Container(
    //               margin: const EdgeInsets.symmetric(vertical: 0),
    //               child: FormButtonWidget('Logout', () {
    //                 Provider.of<LoginViewModel>(context, listen: false)
    //                     .logoutRequest(context);
    //               })),
    //           RichText(
    //             text: const TextSpan(
    //               style: TextStyle(
    //                 fontSize: 14.0,
    //                 color: Colors.white,
    //               ),
    //               children: [
    //                 TextSpan(text: 'Copyright © 2021, '),
    //                 TextSpan(
    //                   text: 'Towrevo',
    //                   style: TextStyle(fontWeight: FontWeight.bold),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           const SizedBox(
    //             height: 2,
    //           ),
    //           const Center(
    //             child: Text(
    //               'All Rights Reserved',
    //               style: TextStyle(
    //                 fontSize: 14.0,
    //                 color: Colors.white,
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
