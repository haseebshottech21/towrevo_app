import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/screens/colors/towrevo_appcolor.dart';
import 'package:towrevo/screens/users/user_location_screen.dart';
import 'package:towrevo/view_model/user_home_screen_view_model.dart';
import 'package:towrevo/screens/users/listing_of_companies_screen.dart';
import 'package:towrevo/utilities.dart';
import 'package:towrevo/view_model/get_location_view_model.dart';
import 'package:towrevo/view_model/services_and_day_view_model.dart';
import 'package:towrevo/widgets/User/describe_field.dart';
import 'package:towrevo/widgets/User/drawer_icon.dart';
import 'package:towrevo/widgets/User/from_to_location.dart';
import 'package:towrevo/widgets/User/user_accept_bottom_sheet.dart';
import 'package:towrevo/widgets/User/user_rating_dialogbox.dart';
import 'package:towrevo/widgets/circular_progress_indicator.dart';
import 'package:towrevo/widgets/drawer_widget.dart';
import 'package:towrevo/widgets/full_background_image.dart';
import 'package:towrevo/widgets/show_snackbar.dart';
import 'package:towrevo/widgets/towrevo_logo.dart';
// import '/widgets/towrevo_logo.dart';

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

  // Future<void> openBottomSheet() async{
  //           await showBottomSheet(context)
  // }

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<UserHomeScreenViewModel>(context, listen: false);
    // print('bottom sheet : ${UsersHomeScreen.showBottomSheet}');
    // print('Dialog : ${UsersHomeScreen.showDialog}');
    // print(provider.bottomSheetData['requestedId']);
    if (provider.bottomSheetData['requested']) {
      Future.delayed(Duration.zero).then(
        (value) async {
          Map<String, String> map = await provider.getRequestStatusData(
              provider.bottomSheetData['requestedId'].toString());
          if (map.isNotEmpty) {
            await openBottomSheet(
              context,
              map['companyName'].toString(),
            );
          }
        },
      ).then(
        (value) {
          provider.bottomSheetData = {
            'requestedId': '',
            'requested': false,
          };
        },
      );
    }

    if (provider.ratingData['requested']) {
      Future.delayed(Duration.zero).then(
        (value) async {
          Map<String, String> map = await provider.getRequestStatusData(
            provider.ratingData['requestedId'].toString(),
          );
          await showDialog(
            context: context,
            builder: (_) {
              return UserRatingDialog(
                reqId: provider.ratingData['requestedId'].toString(),
                companyName: map['companyName'].toString(),
                serviceName: map['serviceName'].toString(),
              );
            },
          ).then((value) {
            provider.ratingData = {
              'requestedId': '',
              'requested': false,
            };
          });
        },
      );
    }

    final primaryColors = Theme.of(context).primaryColor;
    // return Scaffold(
    //   key: scaffoldKey,
    //   drawerEnableOpenDragGesture: false,
    //   drawer: const DrawerWidget(),
    //   // bottomSheet: ,
    //   body: SingleChildScrollView(
    //     child: Stack(
    //       children: [
    //         const BackgroundImage(),
    //         drawerIconSecond(
    //           context,
    //           () {
    //             scaffoldKey.currentState!.openDrawer();
    //           },
    //         ),
    //         Container(
    //           alignment: Alignment.center,
    //           padding: const EdgeInsets.symmetric(
    //             horizontal: 20.0,
    //             vertical: 20.0,
    //           ),
    //           child: Column(
    //             children: [
    //               const SizedBox(
    //                 height: 15,
    //               ),
    //               const TowrevoLogo(),
    //               const SizedBox(
    //                 height: 50,
    //               ),
    //               Text(
    //                 'PICKUP LOCATION',
    //                 textAlign: TextAlign.center,
    //                 style: GoogleFonts.montserrat(
    //                     color: Colors.white,
    //                     fontWeight: FontWeight.w600,
    //                     fontSize: 30.0,
    //                     letterSpacing: 2),
    //               ),
    //               const SizedBox(
    //                 height: 10,
    //               ),
    //               const Text(
    //                 'Just give access to your current location and choose the type of towing vehicle you need',
    //                 style: TextStyle(
    //                   fontSize: 16,
    //                   fontWeight: FontWeight.w600,
    //                 ),
    //                 textAlign: TextAlign.center,
    //               ),
    //               const SizedBox(
    //                 height: 20,
    //               ),
    //               Consumer<GetLocationViewModel>(
    //                 builder: (ctx, getLocation, neverBuildChild) {
    //                   return InkWell(
    //                     onTap: () async {
    //                       // await getLocation.getCurrentLocation(context);
    //                       // Navigator.of(context).pushNamed(
    //                       //   GetLocationScreen.routeName,
    //                       // );
    //                       Navigator.of(context).pushNamed(
    //                         UserLocationScreen.routeName,
    //                         arguments: true,
    //                       );
    //                     },
    //                     child: Container(
    //                       height: getLocation.getAddress.isEmpty ? 50 : null,
    //                       padding: const EdgeInsets.symmetric(horizontal: 10),
    //                       decoration: const BoxDecoration(
    //                           color: Colors.white,
    //                           borderRadius:
    //                               BorderRadius.all(Radius.circular(30))),
    //                       child: Row(
    //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                         children: [
    //                           Row(
    //                             children: [
    //                               Icon(
    //                                 Icons.location_on,
    //                                 color: primaryColors,
    //                               ),
    //                               const SizedBox(
    //                                 width: 10,
    //                               ),
    //                               Container(
    //                                 padding:
    //                                     const EdgeInsets.symmetric(vertical: 8),
    //                                 width: MediaQuery.of(context).size.width *
    //                                     0.65,
    //                                 child: Text(
    //                                   getLocation.getAddress.isEmpty
    //                                       ? 'Get Location'
    //                                       : getLocation.getAddress,
    //                                   style: GoogleFonts.montserrat(
    //                                     color: Colors.black,
    //                                   ),
    //                                   maxLines: 3,
    //                                   overflow: TextOverflow.ellipsis,
    //                                 ),
    //                               ),
    //                             ],
    //                           ),
    //                           Icon(
    //                             Icons.my_location,
    //                             color: primaryColors,
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                   );
    //                 },
    //               ),
    //               const SizedBox(
    //                 height: 10,
    //               ),
    //               Consumer<ServicesAndDaysViewModel>(
    //                 builder: (ctx, service, neverBuildChild) {
    //                   return Container(
    //                     // width: MediaQuery.of(context).size.width * 0.90,
    //                     height: 50,
    //                     padding: const EdgeInsets.symmetric(horizontal: 20),
    //                     decoration: BoxDecoration(
    //                       color: const Color(0xFFfff6f7),
    //                       borderRadius: BorderRadius.circular(30.0),
    //                       border: Border.all(color: Colors.black54),
    //                     ),
    //                     child: DropdownButtonHideUnderline(
    //                       child: DropdownButton<String>(
    //                         isExpanded: true,
    //                         iconSize: 30,
    //                         icon: const Icon(
    //                           FontAwesomeIcons.caretDown,
    //                           color: Color(0xFF019aff),
    //                           size: 15.0,
    //                         ),
    //                         hint: Row(
    //                           children: [
    //                             const Icon(
    //                               FontAwesomeIcons.th,
    //                               color: Color(0xFF019aff),
    //                               size: 20.0,
    //                             ),
    //                             const SizedBox(
    //                               width: 15,
    //                             ),
    //                             Text(
    //                               'Select Category',
    //                               style: GoogleFonts.montserrat(
    //                                   color: Colors.black),
    //                             ),
    //                           ],
    //                         ),
    //                         value: service.serviceSelectedValue,
    //                         borderRadius: BorderRadius.circular(20),
    //                         dropdownColor:
    //                             const Color(0xFF019aff).withOpacity(0.9),
    //                         items: service.serviceListViewModel.map(
    //                           (ServicesModel value) {
    //                             return DropdownMenuItem<String>(
    //                               value: value.name,
    //                               child: Text(value.name),
    //                             );
    //                           },
    //                         ).toList(),
    //                         onChanged: (value) =>
    //                             service.changeServiceSelectedValue(value!),
    //                       ),
    //                     ),
    //                   );
    //                 },
    //               ),
    //               const SizedBox(
    //                 height: 10,
    //               ),
    //               FormButtonWidget(
    //                 'Next',
    //                 () {
    //                   navigateUserHomeScreen();
    //                 },
    //               ),
    //               const SizedBox(
    //                 height: 50,
    //               ),
    //               const SizedBox(
    //                 height: 10,
    //               ),
    //             ],
    //           ),
    //         ),
    //         Consumer<ServicesAndDaysViewModel>(
    //           builder: (ctx, loginViewMode, neverUpdate) {
    //             return loginViewMode.isLoading
    //                 ? SizedBox(
    //                     height: MediaQuery.of(context).size.height,
    //                     child: circularProgress())
    //                 : const SizedBox();
    //           },
    //         )
    //       ],
    //     ),
    //   ),
    // );

    return Scaffold(
      key: scaffoldKey,
      drawerEnableOpenDragGesture: false,
      drawer: const DrawerWidget(),
      // bottomSheet: ,
      body: SingleChildScrollView(
        // physics: NeverScrollableScrollPhysics(),
        child: SizedBox(
          // height: MediaQuery.of(context).size.height,
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
                      // style: TextStyle(
                      //   fontSize: 16,
                      //   fontWeight: FontWeight.w600,
                      // ),
                      style: GoogleFonts.montserrat(
                        // color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 15),
                    Container(
                      // height: MediaQuery.of(context).size.height * 0.48,
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 10,
                      ),
                      // color: Colors.white,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        // color: const Color(0xFF003e66).withOpacity(0.8),
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
                          const SizedBox(height: 10),
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
                                  // vertical: 10,
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
                                      // dropdownColor: AppColors.primaryColor2,
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
              // Positioned(
              //   bottom: 20,
              //   left: 20,
              //   right: 20,
              //   child: Container(
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(30),
              //       boxShadow: kElevationToShadow[10],
              //       gradient: const LinearGradient(
              //         begin: Alignment.bottomLeft,
              //         end: Alignment.topRight,
              //         stops: [0.1, 0.5],
              //         colors: [
              //           Color(0xFF0195f7),
              //           Color(0xFF083054),
              //         ],
              //       ),
              //     ),
              //     child: ElevatedButton(
              //       onPressed: () {
              //         navigateUserHomeScreen();
              //       },
              //       style: ElevatedButton.styleFrom(
              //         elevation: 10,
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(30.0),
              //         ),
              //         shadowColor: Colors.transparent,
              //         primary: Colors.transparent,
              //         minimumSize: Size(
              //           MediaQuery.of(context).size.width * 0.90,
              //           50,
              //         ),
              //       ),
              //       child: Text(
              //         'NEXT',
              //         style: GoogleFonts.montserrat(
              //           color: Colors.white,
              //           fontWeight: FontWeight.w400,
              //           fontSize: 20.0,
              //           letterSpacing: 1,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
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
      'dest_longitude': lngLatProvider
          .myDestinationLocation.placeLocation.longitude
          .toString(),
      'dest_latitude': lngLatProvider
          .myDestinationLocation.placeLocation.latitude
          .toString(),
      'time': DateFormat('kk:mm').format(now),
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

  // @override
  // void initState() {
  //   Future.delayed(Duration.zero).then((value) async {
  //     await setUpRequestNotification();
  //     await setupInteracted();

  //     final serviceProvider =
  //         Provider.of<ServicesAndDaysViewModel>(context, listen: false);
  //     serviceProvider.changeServiceSelectedValue(null);
  //     serviceProvider.getServices();
  //     final locationProvider =
  //         Provider.of<GetLocationViewModel>(context, listen: false);
  //     locationProvider.myCurrentLocation.placeAddress = '';
  //     locationProvider.myDestinationLocation.placeAddress = '';
  //     //services e.g car, bike
  //     // get current location
  //     await locationProvider.getCurrentLocation(context);
  //   });

  //   super.initState();
  // }

  bool _init = true;
  @override
  void didChangeDependencies() async {
    if (_init) {
      await setUpRequestNotification();
      await setupInteracted();

      final serviceProvider =
          Provider.of<ServicesAndDaysViewModel>(context, listen: false);
      serviceProvider.serviceSelectedValue = null;
      serviceProvider.getServices();
      final locationProvider =
          Provider.of<GetLocationViewModel>(context, listen: false);
      locationProvider.myCurrentLocation.placeAddress = '';
      locationProvider.myDestinationLocation.placeAddress = '';
      //services e.g car, bike
      // get current location
      await locationProvider.getCurrentLocation(context);
    }
    _init = false;
    super.didChangeDependencies();
  }

  Future<void> setUpRequestNotification() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  Future<void> setupInteracted() async {
    final provider =
        Provider.of<UserHomeScreenViewModel>(context, listen: false);

    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        if (message.data['screen'] == 'accept') {
          // print(message.data['name']);

          showSnackBar(
            context: context,
            title: 'Request Accept From Company',
            labelText: '',
            onPress: () {},
          ).then((value) {
            provider.bottomSheetData = {
              'requestedId': message.data['id'],
              'requested': true,
            };
            Navigator.of(context).pushNamedAndRemoveUntil(
              UsersHomeScreen.routeName,
              (route) => false,
            );
          });
        }
        if (message.data['screen'] == 'decline_from_company') {
          // Fluttertoast.showToast(msg: 'Decline From Company');
          showSnackBar(
            context: context,
            title: 'Decline From Company',
            labelText: 'Ok',
            onPress: () {},
          );
          Navigator.of(context).pop();
        }
        if (message.data['screen'] == 'request') {
          // Fluttertoast.showToast(msg: 'User Send Request');
          showSnackBar(
            context: context,
            title: 'User Send Request',
            labelText: 'Ok',
            onPress: () {},
          );

          // Navigator.pushNamed(context, RequestScreen.routeName,);
        }
        if (message.data['screen'] == 'complete') {
          // Fluttertoast.showToast(msg: 'Job Complete.')
          showSnackBar(
            context: context,
            title: 'Job Complete Successfully',
            labelText: '',
            onPress: () {},
          ).then(
            (value) {
              provider.rating = 0;

              provider.ratingData = {
                'requestedId': message.data['id'],
                'requested': true,
              };
              provider.bottomSheetData = {
                'requestedId': '',
                'requested': false,
              };
              Navigator.of(context).pushNamedAndRemoveUntil(
                UsersHomeScreen.routeName,
                (route) => false,
              );
            },
          );
        }
      },
    );
  }

  void _handleMessage(RemoteMessage message) {
    final provider =
        Provider.of<UserHomeScreenViewModel>(context, listen: false);
    // print(message);
    // print(message.data);
    if (message.data['screen'] == 'decline_from_user') {
      // Fluttertoast.showToast(msg: 'Time Delayed Request Decline');
      showSnackBar(
        context: context,
        title: 'Time Delayed Request Decline',
        labelText: '',
        onPress: () {},
      );
    }
    if (message.data['screen'] == 'decline_from_company') {
      // Fluttertoast.showToast(msg: 'Decline From Company');
      showSnackBar(
        context: context,
        title: 'Decline From Company',
        labelText: '',
        onPress: () {},
      );
      Navigator.of(context).pop();
    }
    if (message.data['screen'] == 'request') {
      // Fluttertoast.showToast(msg: 'User Send Request');
      showSnackBar(
        context: context,
        title: 'User Send Request',
        labelText: '',
        onPress: () {},
      );

      // Navigator.pushNamed(context, RequestScreen.routeName,);
    }
    if (message.data['screen'] == 'accept') {
      // Fluttertoast.showToast(msg: 'Accepted From Company');
      showSnackBar(
        context: context,
        title: 'Accepted From Company',
        labelText: '',
        onPress: () {},
      ).then(
        (value) {
          provider.bottomSheetData = {
            'requestedId': message.data['id'],
            'requested': true,
          };
          Navigator.of(context).pushNamedAndRemoveUntil(
              UsersHomeScreen.routeName, (route) => false);
        },
      );
    }
    if (message.data['screen'] == 'complete') {
      // Fluttertoast.showToast(msg: 'Job Complete ');
      showSnackBar(
        context: context,
        title: 'Job Complete Successfully',
        labelText: '',
        onPress: () {},
      ).then(
        (value) {
          provider.rating = 0;

          provider.ratingData = {
            'requestedId': message.data['id'],
            'requested': true,
          };
          provider.bottomSheetData = {
            'requestedId': '',
            'requested': false,
          };

          Navigator.of(context).pushNamedAndRemoveUntil(
            UsersHomeScreen.routeName,
            (route) => false,
          );
        },
      );
    }
  }
}
