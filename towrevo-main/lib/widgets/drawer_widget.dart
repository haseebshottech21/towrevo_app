import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/screens/aboutus/about_us_screen.dart';
import 'package:towrevo/screens/authentication/change_password/change_password.dart';
import 'package:towrevo/screens/company/company_history.dart';
import 'package:towrevo/screens/company/company_home_screen.dart';
import 'package:towrevo/screens/faqs/faqs.dart';
import 'package:towrevo/screens/term&condiotion/term&conditon_screen.dart';
import 'package:towrevo/screens/users/user_history.dart';
import 'package:towrevo/screens/users/users_home_screen.dart';
import 'package:towrevo/utilities.dart';
import 'package:towrevo/view_model/login_view_model.dart';
import 'drawer_list_item_widget.dart';
import 'drawer_profile.dart';
import 'form_button_widget.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xFF092848),
        child: ListView(
          physics: const ScrollPhysics(),
          // Important: Remove any padding from the ListView.
          // padding: const EdgeInsets.symmetric(horizontal: 10),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DrawerProfile(
                  profileImage:
                      'https://images.pexels.com/photos/1704488/pexels-photo-1704488.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                  profileName: 'Profile Name',
                  profileEmail: 'example@gmail.com',
                  editOnPressed: () {},
                ),
                const Divider(
                  color: Colors.white,
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(
                //     horizontal: 5.0,
                //     vertical: 20,
                //   ),
                //   child: Container(
                //     height: MediaQuery.of(context).size.height * 0.12,
                //     width: MediaQuery.of(context).size.width * 0.30,
                //     decoration: const BoxDecoration(
                //       image: DecorationImage(
                //         image: AssetImage(
                //           'assets/images/logo.png',
                //         ),
                //         fit: BoxFit.fill,
                //       ),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      DrawerListItem(
                        title: 'Home',
                        iconsData: Icons.play_arrow,
                        onPressed: () async {
                          String type = await Utilities()
                              .getSharedPreferenceValue('type');
                          // print(type);
                          // Navigator.of(context).pushNamed(CompanyHistory.routeName);
                          Navigator.of(context).pushNamed(
                            type == '1'
                                ? UsersHomeScreen.routeName
                                : CompanyHomeScreen.routeName,
                          );
                        },
                      ),
                      DrawerListItem(
                        title: 'About Us',
                        iconsData: Icons.play_arrow,
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed(AboutUs.routeName);
                        },
                      ),
                      DrawerListItem(
                        title: 'History',
                        iconsData: Icons.play_arrow,
                        onPressed: () async {
                          String type = await Utilities()
                              .getSharedPreferenceValue('type');
                          // print(type);
                          // Navigator.of(context).pushNamed(CompanyHistory.routeName);
                          Navigator.of(context).pushNamed(
                            type == '1'
                                ? UserHistory.routeName
                                : CompanyHistory.routeName,
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
                          Navigator.of(context)
                              .pushReplacementNamed(FAQs.routeName);
                        },
                      ),
                      DrawerListItem(
                        title: 'Change Password',
                        iconsData: Icons.play_arrow,
                        onPressed: () {
                          // Navigator.of(context)
                          //     .pushReplacementNamed(ChangePassword.routeName);
                        },
                      ),
                      DrawerListItem(
                        title: 'Term & Condition',
                        iconsData: Icons.play_arrow,
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed(TermAndCondition.routeName);
                        },
                      ),
                      // DrawerListItem(
                      //   title: 'Privacy Policy',
                      //   iconsData: Icons.play_arrow,
                      //   onPressed: () {},
                      // ),
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
