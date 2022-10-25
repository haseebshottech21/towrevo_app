import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/screens/delete_my_account.dart';
import 'package:towrevo/screens/payment/user_paymnets.dart';
import 'package:towrevo/utilities/utilities.dart';
import 'package:towrevo/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import '../view_model/view_model.dart';
import 'package:towrevo/screens/screens.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  void initState() {
    getCurrentYear();
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
  String finalDate = '';

  getCurrentYear() {
    var date = DateTime.now().toString();
    var dateParse = DateTime.parse(date);
    var formattedDate = "${dateParse.year}";
    setState(() {
      finalDate = formattedDate.toString();
    });
  }

  checkVerification() async {
    final isVerify = await Utilities().getSharedPreferenceValue('verified');
    if (isVerify == '1') {
      Navigator.of(context).pushNamed(UpdateProfile.routeName);
    } else {
      Fluttertoast.showToast(msg: 'Complete Your Profile Detail');
    }
  }

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
                    editOnPressed: type == '2'
                        ? checkVerification
                        : () {
                            Navigator.of(context)
                                .pushNamed(UpdateProfile.routeName);
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
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                value: companyViewModel.isSwitched,
                                onChanged: (value) => companyViewModel
                                    .changeOnlineStatus(value, context),
                                activeTrackColor: Colors.lightGreenAccent,
                                activeColor: Colors.green,
                              );
                            },
                          );
                  },
                ),
                const Divider(color: Colors.white),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.w),
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
                                ? openUrl('https://towrevo.com')
                                : openUrl('https://towrevo.com/provider');
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
                      DrawerListItem(
                        title: 'Payments',
                        iconsData: FontAwesomeIcons.moneyCheck,
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(UserPaymnets.routeName);
                        },
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20.h),
                        child: FormButtonWidget(
                          formBtnTxt: 'Logout',
                          onPressed: () {
                            Provider.of<LoginViewModel>(context, listen: false)
                                .logoutRequest(context);
                          },
                        ),
                      ),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.white,
                            ),
                            children: [
                              TextSpan(text: 'Copyright © $finalDate, '),
                              const TextSpan(
                                text: 'TowRevo',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Center(
                        child: Text(
                          'All Rights Reserved',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15.h),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      TermAndCondition.routeName,
                      arguments: false,
                    );
                  },
                  child: Center(
                    child: Text(
                      'Term & Condition\nPrivacy Policy',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.0, 1.0],
                        colors: [
                          Color(0xFF0195f7),
                          Color(0xFF083054),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(DeleteMyAccount.routeName);
                      },
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.transparent,
                        primary: Colors.transparent,
                        padding: const EdgeInsets.only(
                          left: 12,
                          right: 12,
                          top: 2,
                          bottom: 2,
                        ),
                      ),
                      child: Text(
                        'Delete Account',
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 12.sp,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
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
