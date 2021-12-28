import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/models/services_model.dart';
import 'package:towrevo/view_model/user_home_screen_view_model.dart';
import 'package:towrevo/screens/users/listing_of_companies_screen.dart';
import 'package:towrevo/utilities.dart';
import 'package:towrevo/view_model/get_location_view_model.dart';
import 'package:towrevo/view_model/services_and_day_view_model.dart';
import 'package:towrevo/widgets/User/user_accept_bottom_sheet.dart';
import 'package:towrevo/widgets/User/user_rating_dialogbox.dart';
import 'package:towrevo/widgets/drawer_widget.dart';
import '../get_location_screen.dart';
import '/widgets/background_image.dart';
import '/widgets/form_button_widget.dart';
import '/widgets/towrevo_logo.dart';

class UsersHomeScreen extends StatefulWidget {
  const UsersHomeScreen({Key? key}) : super(key: key);
  static const routeName = '/users-home-screen';

  @override
  _UsersHomeScreenState createState() => _UsersHomeScreenState();
}

class _UsersHomeScreenState extends State<UsersHomeScreen> {
  final getLocation = GetLocationViewModel();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  // Future<void> openBottomSheet() async{
  //           await showBottomSheet(context)
  // }

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<UserHomeScreenViewModel>(context, listen: false);
    // print('bottom sheet : ${UsersHomeScreen.showBottomSheet}');
    // print('Dialog : ${UsersHomeScreen.showDialog}');
    print(provider.bottomSheetData['requestedId']);
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
    return Scaffold(
      key: scaffoldKey,
      drawerEnableOpenDragGesture: false,
      drawer: const DrawerWidget(),
      // bottomSheet: ,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            const BackgroundImage(),
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
                  color: const Color(0xFF092848).withOpacity(0.5),
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
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 20.0,
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  const TowrevoLogo(),
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    'PICKUP LOCATION',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 30.0,
                        letterSpacing: 2),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Just give access to your current location and choose the type of towing vehicle you need',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Consumer<GetLocationViewModel>(
                    builder: (ctx, getLocation, neverBuildChild) {
                      return InkWell(
                        onTap: () async {
                          // await getLocation.getCurrentLocation(context);
                          Navigator.of(context).pushNamed(
                            GetLocationScreen.routeName,
                          );
                        },
                        child: Container(
                          height: getLocation.getAddress.isEmpty ? 50 : null,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: primaryColors,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    width: MediaQuery.of(context).size.width *
                                        0.65,
                                    child: Text(
                                      getLocation.getAddress.isEmpty
                                          ? 'Get Location'
                                          : getLocation.getAddress,
                                      style: GoogleFonts.montserrat(
                                        color: Colors.black,
                                      ),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.my_location,
                                color: primaryColors,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Consumer<ServicesAndDaysViewModel>(
                    builder: (ctx, service, neverBuildChild) {
                      return Container(
                        // width: MediaQuery.of(context).size.width * 0.90,
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: const Color(0xFFfff6f7),
                          borderRadius: BorderRadius.circular(30.0),
                          border: Border.all(color: Colors.black54),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            iconSize: 30,
                            icon: const Icon(
                              FontAwesomeIcons.caretDown,
                              color: Color(0xFF019aff),
                              size: 15.0,
                            ),
                            hint: Row(
                              children: [
                                const Icon(
                                  FontAwesomeIcons.th,
                                  color: Color(0xFF019aff),
                                  size: 20.0,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  'Select Category',
                                  style: GoogleFonts.montserrat(
                                      color: Colors.black),
                                ),
                              ],
                            ),
                            value: service.serviceSelectedValue,
                            borderRadius: BorderRadius.circular(20),
                            dropdownColor:
                                const Color(0xFF019aff).withOpacity(0.9),
                            items: service.serviceListViewModel.map(
                              (ServicesModel value) {
                                return DropdownMenuItem<String>(
                                  value: value.name,
                                  child: Text(value.name),
                                );
                              },
                            ).toList(),
                            onChanged: (value) =>
                                service.changeServiceSelectedValue(value!),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FormButtonWidget(
                    'Next',
                    () {
                      navigateUserHomeScreen();
                    },
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
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
        lngLatProvider.latLng == null) {
      Fluttertoast.showToast(msg: 'Please Fill Required Fields');
      return;
    }
    userHomeScreenProvider.body = {
      'longitude': lngLatProvider.latLng!.longitude.toString(),
      'latitude': lngLatProvider.latLng!.latitude.toString(),
      'time': DateFormat('kk:mm').format(now),
      'day': await Utilities().dayToInt(
        DateFormat('EEEE').format(now),
      ),
      'service': serviceProvider.serviceListViewModel
          .firstWhere((element) =>
              element.name == serviceProvider.serviceSelectedValue!)
          .id,
      'address': lngLatProvider.address
    };
    Navigator.of(context).pushNamed(ListingOfCompaniesScreen.routeName);
  }

  bool _init = true;
  @override
  void didChangeDependencies() async {
    if (_init) {
      await setUpRequestNotification();
      await setupInteracted();

      final serviceProvider =
          Provider.of<ServicesAndDaysViewModel>(context, listen: false);
      serviceProvider.getServices();
      final locationProvider =
          Provider.of<GetLocationViewModel>(context, listen: false);
      locationProvider.address = '';
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
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    print('yes');
    print(initialMessage?.data.toString());
    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      // Navigator.pushNamed(context, RequestScreen.routeName,);

    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        print(message);
        print(message.data['screen']);
        if (message.data['screen'] == 'decline_from_user') {
          Fluttertoast.showToast(msg: 'Time Delayed Request Decline');
        }
        if (message.data['screen'] == 'accept') {
          print(message.data['name']);
          Fluttertoast.showToast(msg: 'Accepted From Company.').then((value) {
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
          Fluttertoast.showToast(msg: 'Decline From Company');
          Navigator.of(context).pop();
        }
        if (message.data['screen'] == 'request') {
          Fluttertoast.showToast(msg: 'User Send Request');

          // Navigator.pushNamed(context, RequestScreen.routeName,);
        }
        if (message.data['screen'] == 'complete') {
          Fluttertoast.showToast(msg: 'Job Complete.').then(
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
    print(message);
    print(message.data);
    if (message.data['screen'] == 'decline_from_user') {
      Fluttertoast.showToast(msg: 'Time Delayed Request Decline');
    }
    if (message.data['screen'] == 'decline_from_company') {
      Fluttertoast.showToast(msg: 'Decline From Company');
      Navigator.of(context).pop();
    }
    if (message.data['screen'] == 'request') {
      Fluttertoast.showToast(msg: 'User Send Request');

      // Navigator.pushNamed(context, RequestScreen.routeName,);
    }
    if (message.data['screen'] == 'accept') {
      Fluttertoast.showToast(msg: 'Accepted From Company').then(
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
      Fluttertoast.showToast(msg: 'Job Complete ').then(
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
