import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/utitlites/utilities.dart';
import 'package:towrevo/view_model/company_home_screen_view_model.dart';
import 'package:towrevo/view_model/login_view_model.dart';
import 'package:towrevo/view_model/user_home_screen_view_model.dart';
import 'package:towrevo/widgets/User/user_empty_icon.dart';
import 'package:towrevo/widgets/profile_image_circle.dart';
import 'package:url_launcher/url_launcher.dart';
import 'drawer_list_item_widget.dart';
import 'drawer_profile.dart';
import 'form_button_widget.dart';
import 'package:towrevo/screens/screens.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then(
      (value) async {
        final provider =
            Provider.of<UserHomeScreenViewModel>(context, listen: false);

        Provider.of<CompanyHomeScreenViewModel>(context, listen: false)
            .checkOnlineStatus();

        provider.updateDrawerInfo();
        type = await provider.getType();
      },
    );
    //comment

    super.initState();
  }

  String type = '';

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
                Consumer<UserHomeScreenViewModel>(
                    builder: (ctx, drawer, neverBuildChild) {
                  // print(drawer.drawerInfo['email']);
                  return DrawerProfile(
                    // profileImage: drawer.drawerInfo['image']
                    //         .toString()
                    //         .isNotEmpty
                    //     ? Utilities.imageBaseUrl +
                    //         drawer.drawerInfo['image'].toString()
                    //     : 'https://images.pexels.com/photos/1704488/pexels-photo-1704488.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                    profileImage:
                        drawer.drawerInfo['image'].toString().isNotEmpty
                            ? profileImageCircle(
                                context,
                                Utilities.imageBaseUrl +
                                    drawer.drawerInfo['image'].toString(),
                              )
                            : userEmptyProfile(context),
                    profileName: drawer.drawerInfo['name'].toString().isNotEmpty
                        ? drawer.drawerInfo['name'].toString().trim()
                        : 'Profile Name',
                    profileEmail:
                        drawer.drawerInfo['email'].toString().isNotEmpty
                            ? drawer.drawerInfo['email'].toString()
                            : 'example@gmail.com',
                    editOnPressed: () {
                      Navigator.of(context).pushNamed(UpdateProfile.routeName);
                    },
                  );
                }),
                Consumer<UserHomeScreenViewModel>(
                  builder: (ctx, drawer, neverBuildChild) {
                    return type == '1'
                        ? const SizedBox()
                        : Consumer<CompanyHomeScreenViewModel>(
                            builder: (ctx, companyViewModel, neverBuildChild) {
                              // print(companyViewModel.isSwitched);
                              return SwitchListTile(
                                title: Text(
                                  !companyViewModel.isSwitched
                                      ? 'Offline'
                                      : 'Online',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                value: companyViewModel.isSwitched,
                                onChanged: (value) =>
                                    companyViewModel.changeOnlineStatus(value),
                                activeTrackColor: Colors.lightGreenAccent,
                                activeColor: Colors.green,
                              );
                            },
                          );
                  },
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
                        iconsData: FontAwesomeIcons.home,
                        onPressed: () async {
                          Navigator.of(context).pushReplacementNamed(
                            type == '1'
                                ? UsersHomeScreen.routeName
                                : CompanyHomeScreen.routeName,
                          );
                        },
                      ),
                      Consumer<UserHomeScreenViewModel>(
                          builder: (ctx, drawer, neverBuildChild) {
                        return DrawerListItem(
                          title: type == '1' ? 'About Us' : 'Provider',
                          iconsData: FontAwesomeIcons.infoCircle,
                          onPressed: () {
                            // print(type);
                            type == '1'
                                ? openUrl(
                                    'https://myprojectstaging.net/html/towrevo/index.php')
                                : openUrl(
                                    'https://myprojectstaging.net/html/towrevo/provider.php');
                            // Navigator.of(context).pushNamed(AboutUs.routeName);
                          },
                        );
                      }),

                      DrawerListItem(
                        title: 'History',
                        iconsData: FontAwesomeIcons.history,
                        onPressed: () async {
                          Navigator.of(context).pushNamed(
                            type == '1'
                                ? UserHistoryTow.routeName
                                : CompanyHistoryScreen.routeName,
                          );
                        },
                      ),
                      DrawerListItem(
                        title: 'Contact Us',
                        iconsData: FontAwesomeIcons.solidAddressBook,
                        onPressed: () {
                          Navigator.of(context).pushNamed(ContactUs.routeName);
                        },
                      ),
                      DrawerListItem(
                        title: 'FAQ\'s',
                        iconsData: FontAwesomeIcons.solidQuestionCircle,
                        onPressed: () {
                          Navigator.of(context).pushNamed(FAQs.routeName);
                        },
                      ),
                      DrawerListItem(
                        title: 'Change Password',
                        iconsData: FontAwesomeIcons.lock,
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(ChangePasswordScreen.routeName);
                        },
                      ),

                      // DrawerListItem(
                      //   title: 'Term & Condition',
                      //   iconsData: FontAwesomeIcons.clipboardCheck,
                      //   onPressed: () {
                      //     Navigator.of(context).pushNamed(
                      //       TermAndCondition.routeName,
                      //       arguments: false,
                      //     );
                      //   },
                      // ),

                      // DrawerListItem(
                      //   title: 'Privacy Policy',
                      //   iconsData: Icons.play_arrow,
                      //   onPressed: () {},
                      // ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 25),
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
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      TermAndCondition.routeName,
                      arguments: false,
                    );
                  },
                  child: const Center(
                    child: Text(
                      'Term & Condition\nPrivacy Policy',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                        // decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
