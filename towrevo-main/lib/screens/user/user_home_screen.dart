import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/screens/user/user_notification_utilities.dart/user_side_notinfication_handler.dart';
import 'package:towrevo/utilities/utilities.dart';
import 'package:towrevo/view_model/view_model.dart';
import 'package:towrevo/widgets/widgets.dart';
import 'package:towrevo/screens/screens.dart';
import '../../../utilities/towrevo_appcolor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UsersHomeScreen extends StatefulWidget {
  const UsersHomeScreen({Key? key}) : super(key: key);
  static const routeName = '/users-home-screen';

  @override
  _UsersHomeScreenState createState() => _UsersHomeScreenState();
}

class _UsersHomeScreenState extends State<UsersHomeScreen> {
  final getLocation = GetLocationViewModel();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController describeController = TextEditingController();
  UserSideNotificationHandler userSideNotificationHandler =
      UserSideNotificationHandler();
  @override
  Widget build(BuildContext context) {
    userSideNotificationHandler.checkRatingStatus(context);
    return Scaffold(
      key: scaffoldKey,
      drawerEnableOpenDragGesture: false,
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        // physics: const NeverScrollableScrollPhysics(),
        child: SizedBox(
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
                margin: EdgeInsets.only(top: Platform.isIOS ? 25.h : 15.h),
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(
                  horizontal: 15.w,
                  vertical: 15.h,
                ),
                child: Column(
                  children: [
                    const TowrevoLogoExtraSmall(),
                    SizedBox(height: 8.h),
                    Text(
                      'PICKUP LOCATION',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 26.sp,
                        letterSpacing: 2.w,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      'Just give access to your current location and choose the type of towing vehicle you need',
                      style: GoogleFonts.montserrat(
                        fontSize: Platform.isIOS ? 11.sp : 13.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: Platform.isIOS ? 20.h : 15.h,
                        horizontal: 10.w,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        boxShadow: kElevationToShadow[2],
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: [0.1, 0.9],
                          colors: [
                            Color(0xFF0195f7),
                            Color(0xFF083054),
                          ],
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 5.w),
                              Icon(
                                FontAwesomeIcons.car,
                                color: Colors.white,
                                size: 18.sp,
                              ),
                              SizedBox(width: 6.w),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                width: ScreenUtil().screenWidth * 0.76,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Consumer<ServicesAndDaysViewModel>(
                                    builder: (ctx, service, neverBuildChild) {
                                  return DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      hint: Text(
                                        'Select Vehicle',
                                        style: GoogleFonts.montserrat(
                                          color: Colors.black54,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      iconEnabledColor: AppColors.primaryColor2,
                                      value: service.serviceSelectedValue,
                                      items:
                                          service.serviceListViewModel.map((e) {
                                        return DropdownMenuItem(
                                          value: e.name,
                                          child: Text(
                                            e.name,
                                            style: GoogleFonts.montserrat(
                                              color: Colors.black,
                                              // fontSize: 14,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (value) => service
                                          .changeServiceSelectedValue(value!),
                                    ),
                                  );
                                }),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Consumer<GetLocationViewModel>(
                            builder: (ctx, getLocation, neverBuildChild) {
                              return FromToLocation(
                                fromLocationText:
                                    getLocation.getMyAddress.isEmpty
                                        ? 'Pickup Location'
                                        : getLocation.getMyAddress,
                                fromOnTap: () {
                                  Navigator.of(context).pushNamed(
                                    UserLocationScreen.routeName,
                                    arguments: true,
                                  );
                                },
                                toLocationText:
                                    getLocation.getDestinationAddress.isEmpty
                                        ? 'Drop Location'
                                        : getLocation.getDestinationAddress,
                                toOnTap: () {
                                  Navigator.of(context).pushNamed(
                                    UserLocationScreen.routeName,
                                    arguments: false,
                                  );
                                },
                              );
                            },
                          ),
                          SizedBox(height: 8.h),
                          DescribeProblemField(
                            describeController: describeController,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 13.h),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.r),
                        boxShadow: kElevationToShadow[1],
                        gradient: const LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          stops: [0.1, 0.5],
                          colors: [
                            Color(0xFF0195f7),
                            Color(0xFF083054),
                          ],
                        ),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          navigateUserHomeScreen();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          shadowColor: Colors.transparent,
                          primary: Colors.transparent,
                          minimumSize: Size(
                            ScreenUtil().screenWidth,
                            40.h,
                          ),
                        ),
                        child: Text(
                          'NEXT',
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 20.sp,
                            letterSpacing: 1.w,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Consumer<ServicesAndDaysViewModel>(
                builder: (ctx, loginViewMode, neverUpdate) {
                  return loginViewMode.isLoading
                      ? SizedBox(
                          height: ScreenUtil().screenHeight,
                          child: circularProgress(),
                        )
                      : const SizedBox();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void navigateUserHomeScreen() async {
    final userHomeScreenProvider =
        Provider.of<UserHomeScreenViewModel>(context, listen: false);
    DateTime now = DateTime.now();
    final lngLatProvider =
        Provider.of<GetLocationViewModel>(context, listen: false);
    final serviceProvider =
        Provider.of<ServicesAndDaysViewModel>(context, listen: false);

    if (serviceProvider.serviceSelectedValue == null ||
        lngLatProvider.myCurrentLocation.placeAddress.isEmpty ||
        describeController.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Please Fill Required Fields');
      return;
    } else if (describeController.text.length <= 3) {
      Fluttertoast.showToast(msg: 'Describe problem length must be 3 char');
      return;
    }
    userHomeScreenProvider.body = {
      'longitude':
          lngLatProvider.myCurrentLocation.placeLocation.longitude.toString(),
      'latitude':
          lngLatProvider.myCurrentLocation.placeLocation.latitude.toString(),
      'dest_longitude':
          lngLatProvider.myDestinationLocation.placeAddress.isEmpty
              ? ''
              : lngLatProvider.myDestinationLocation.placeLocation.longitude
                  .toString(),
      'dest_latitude': lngLatProvider.myDestinationLocation.placeAddress.isEmpty
          ? ''
          : lngLatProvider.myDestinationLocation.placeLocation.latitude
              .toString(),
      'time': DateFormat.Hm().format(now),
      'day': await Utilities().dayToInt(DateFormat('EEEE').format(now)),
      'service': serviceProvider.serviceListViewModel
          .firstWhere((element) =>
              element.name == serviceProvider.serviceSelectedValue!)
          .id,
      'address': lngLatProvider.myCurrentLocation.placeAddress,
      'dest_address': lngLatProvider.myDestinationLocation.placeAddress,
      'description': describeController.text.trim()
    };
    Navigator.of(context).pushNamed(ListingOfCompaniesScreen.routeName);
  }

  bool _init = true;
  @override
  void didChangeDependencies() async {
    if (_init) {
      await Utilities().setUpRequestNotification();
      await UserSideNotificationHandler().notificationHandler(context);

      final serviceProvider =
          Provider.of<ServicesAndDaysViewModel>(context, listen: false);
      // serviceProvider.serviceSelectedValue = null;
      serviceProvider.getServices();
      final locationProvider =
          Provider.of<GetLocationViewModel>(context, listen: false);
      // locationProvider.myCurrentLocation.placeAddress = '';
      locationProvider.myDestinationLocation.placeAddress = '';

      // Provider.of<GetLocationViewModel>(context, listen: false)
      //     .getStoreLocationIfExist(context);

      // get current location
      await locationProvider.getStoreLocationIfExist(context);
    }
    _init = false;
    super.didChangeDependencies();
  }
}
