import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/utilities/utilities.dart';
import 'package:towrevo/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import '../view_model/view_model.dart';
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
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Consumer<UserHomeScreenViewModel>(
                    builder: (ctx, drawer, neverBuildChild) {
                  return DrawerProfile(
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
                            type == '1'
                                ? openUrl('http://towrevo.com/index.php')
                                : openUrl('http://towrevo.com/provider.php');
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
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
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
