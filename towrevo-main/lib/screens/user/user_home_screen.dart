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
                margin: const EdgeInsets.only(top: 15),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 20.0,
                ),
                child: Column(
                  children: [
                    const TowrevoLogoExtraSmall(),
                    const SizedBox(height: 8),
                    Text(
                      'PICKUP LOCATION',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 30.0,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Just give access to your current location and choose the type of towing vehicle you need',
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
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
                              const SizedBox(width: 5),
                              const Icon(
                                FontAwesomeIcons.car,
                                color: Colors.white,
                                size: 20.0,
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                width: MediaQuery.of(context).size.width * 0.76,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Consumer<ServicesAndDaysViewModel>(
                                    builder: (ctx, service, neverBuildChild) {
                                  return DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      hint: Text(
                                        'Select Vehicle',
                                        style: GoogleFonts.montserrat(
                                          color: Colors.black54,
                                          fontSize: 15,
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
                          const SizedBox(height: 10),
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
                          const SizedBox(height: 10),
                          DescribeProblemField(
                            describeController: describeController,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: kElevationToShadow[10],
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
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          shadowColor: Colors.transparent,
                          primary: Colors.transparent,
                          minimumSize: Size(
                            MediaQuery.of(context).size.width * 0.95,
                            50,
                          ),
                        ),
                        child: Text(
                          'NEXT',
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 20.0,
                            letterSpacing: 1,
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
                          height: MediaQuery.of(context).size.height,
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
      'day': await Utilities().dayToInt(
        DateFormat('EEEE').format(now),
      ),
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
      serviceProvider.serviceSelectedValue = null;
      serviceProvider.getServices();
      final locationProvider =
          Provider.of<GetLocationViewModel>(context, listen: false);
      locationProvider.myCurrentLocation.placeAddress = '';
      locationProvider.myDestinationLocation.placeAddress = '';

      // get current location
      await locationProvider.getCurrentLocation(context);
    }
    _init = false;
    super.didChangeDependencies();
  }
}
