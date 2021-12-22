import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/screens/authentication/signup_company/signup_company_widegts/title_widget.dart';
import 'package:towrevo/screens/term&condiotion/term&conditon_screen.dart';
import 'package:towrevo/utilities.dart';
import 'package:towrevo/view_model/services_and_day_view_model.dart';
import 'package:towrevo/widgets/services_and_days_check_box_widgets/days_check_box_widget.dart';
import 'package:towrevo/widgets/services_and_days_check_box_widgets/services_check_box_widget.dart';
import '../../get_location_screen.dart';
import '/screens/authentication/signup_company/registration_payment_screen.dart';
import '/widgets/background_image.dart';
import '/widgets/form_button_widget.dart';
import '/view_model/get_location_view_model.dart';
import '/view_model/register_company_view_model.dart';

class RegistrationCategoryAndTimingScreen extends StatefulWidget {
  const RegistrationCategoryAndTimingScreen({Key? key}) : super(key: key);

  static const routeName = '/category-and-timing';

  @override
  State<RegistrationCategoryAndTimingScreen> createState() =>
      _RegistrationCategoryAndTimingScreenState();
}

class _RegistrationCategoryAndTimingScreenState
    extends State<RegistrationCategoryAndTimingScreen> {
  Future<void> showDays(BuildContext context) async {
    await showDialog(
        context: context,
        //Notice the use of ChangeNotifierProvider<ReportState>.value
        builder: (_) {
          // final provider = Provider.of<RegisterCompanyViewModel>(context,listen: true);
          print('there');
          return AlertDialog(
            content: Consumer<ServicesAndDaysViewModel>(
                builder: (ctx, provider, neverBuildChild) {
              return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: provider.daysListViewModel.map((item) {
                    return ChangeNotifierProvider.value(
                      value: provider.daysListViewModel[
                          provider.daysListViewModel.indexOf(item)],
                      child: const DaysCheckBoxWidget(),
                    );
                  }).toList());
            }),
          );
        });
  }

  Future<void> showCategories(BuildContext context) async {
    await showDialog(
        context: context,
        //Notice the use of ChangeNotifierProvider<ReportState>.value
        builder: (_) {
          return AlertDialog(
            content: Consumer<ServicesAndDaysViewModel>(
                builder: (ctx, provider, neverBuildChild) {
              return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: provider.serviceListViewModel.map((item) {
                    return ChangeNotifierProvider.value(
                      value: provider.serviceListViewModel[
                          provider.serviceListViewModel.indexOf(item)],
                      child: const ServiceCheckBoxWidget(),
                    );
                  }).toList());
            }),
          );
        });
  }

  void validate() {
    final locationProvider =
        Provider.of<GetLocationViewModel>(context, listen: false);
    final registerProvider =
        Provider.of<RegisterCompanyViewModel>(context, listen: false);
    final daysAndServiceProvider =
        Provider.of<ServicesAndDaysViewModel>(context, listen: false);
    if (locationProvider.latLng != null &&
        daysAndServiceProvider.daysId.isNotEmpty &&
        daysAndServiceProvider.servicesId.isNotEmpty &&
        registerProvider.body['from'] != '' &&
        registerProvider.body['from'] != '') {
      print(registerProvider.body);
      registerProvider.body['services'] =
          json.encode(daysAndServiceProvider.servicesId);
      registerProvider.body['days'] =
          json.encode(daysAndServiceProvider.daysId);
      // registerProvider.body['services'] = daysAndServiceProvider.servicesId;
      // registerProvider.body['days'] = daysAndServiceProvider.daysId;
      Navigator.of(context).pushNamed(RegistrationPaymentScreen.routeName);
    } else {
      Utilities().showToast('Please Fill All Required Fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryColors = Theme.of(context).primaryColor;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(children: [
          const BackgroundImage(),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 15.0),
            child: IconButton(
              icon: const Icon(FontAwesomeIcons.arrowLeft,
                  color: Colors.white, size: 20.0),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
            child: Column(children: [
              const SizedBox(
                height: 50,
              ),
              FadeInDown(
                from: 15,
                delay: const Duration(milliseconds: 500),
                child: companyTitle(),
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Consumer<GetLocationViewModel>(
                        builder: (ctx, getLocation, neverBuildChild) {
                      // print(getLocation.getAddress);
                      return InkWell(
                        onTap: () async {
                          Navigator.of(context).pushNamed(
                            GetLocationScreen.routeName,
                          );
                        },
                        child: FadeInDown(
                          from: 20,
                          delay: const Duration(milliseconds: 550),
                          child: Container(
                            height: getLocation.getAddress.isEmpty ? 50 : null,
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
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
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8,
                                      ),
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
                                        // textAlign: TextAlign.left,
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
                        ),
                      );
                    }),
                    const SizedBox(
                      height: 10,
                    ),
                    Consumer<RegisterCompanyViewModel>(
                        builder: (ctx, timer, neverBuildChild) {
                      return InkWell(
                        onTap: () async {
                          await timer.setTimer(context);
                        },
                        child: FadeInDown(
                          from: 25,
                          delay: const Duration(milliseconds: 570),
                          child: Container(
                            height: 50,
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      FontAwesomeIcons.solidClock,
                                      color: Color(0xFF019aff),
                                      size: 20.0,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8,
                                        horizontal: 5,
                                      ),
                                      width: MediaQuery.of(context).size.width *
                                          0.65,
                                      child: Text(
                                        (timer.timerValues['from'] != '' ||
                                                timer.timerValues['to'] != '')
                                            ? '${(timer.timerValues['from'])} - ${(timer.timerValues['to'])}'
                                            : 'Select Time',
                                        style: GoogleFonts.montserrat(
                                          color: Colors.black,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                    const SizedBox(
                      height: 10,
                    ),
                    Consumer<ServicesAndDaysViewModel>(
                      builder: (ctx, days, neverBuildChild) {
                        return InkWell(
                          onTap: () async {
                            await showDays(context);
                          },
                          child: FadeInDown(
                            from: 25,
                            delay: const Duration(milliseconds: 570),
                            child: Container(
                              height: 50,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        FontAwesomeIcons.solidClock,
                                        color: Color(0xFF019aff),
                                        size: 20.0,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 8,
                                          horizontal: 5,
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.65,
                                        child: Text(
                                          days.getDays(),
                                          style: GoogleFonts.montserrat(
                                            color: Colors.black,
                                          ),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Consumer<ServicesAndDaysViewModel>(
                        builder: (ctx, categories, neverBuildChild) {
                      return InkWell(
                        onTap: () async {
                          await showCategories(context);
                        },
                        child: FadeInDown(
                          from: 30,
                          delay: const Duration(milliseconds: 590),
                          child: Container(
                            height: 55,
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.category_outlined,
                                      color: primaryColors,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      categories.getService(),
                                      style: GoogleFonts.montserrat(
                                        color: Colors.black,
                                      ),
                                    ),
                                    // if(categories.isNotEmpty)
                                    // Wrap(children: categories.map((e) => Text(e[''])).toList(),)
                                    // Container(padding: const EdgeInsets.symmetric(vertical: 8),width: MediaQuery.of(context).size.width*0.65,child: categories.isEmpty?'Select Categories':categories,style: GoogleFonts.montserrat(color: Colors.black,),maxLines: 3,overflow: TextOverflow.ellipsis,)),
                                  ],
                                ),
                                Icon(
                                  Icons.arrow_drop_down_circle_outlined,
                                  color: primaryColors,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                    const SizedBox(
                      height: 5,
                    ),
                    FadeInDown(
                      from: 35,
                      delay: const Duration(milliseconds: 620),
                      child: Row(
                        children: [
                          Consumer<RegisterCompanyViewModel>(builder:
                              (ctx, registerViewModel, _neverBuildChild) {
                            return Checkbox(
                              value:
                                  registerViewModel.isCheckedTermsAndCondition,
                              onChanged: (bool? value) {
                                registerViewModel.toggleTermsAndCondition();
                              },
                            );
                          }),
                          Row(
                            children: [
                              Text(
                                'I Accept',
                                style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13.0),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Term & Condition',
                                        style: GoogleFonts.montserrat(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13.0,
                                            decoration:
                                                TextDecoration.underline),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () =>
                                              Navigator.of(context).pushNamed(
                                                TermAndCondition.routeName,
                                                arguments: true,
                                              )
                                        // Navigator.of(context).pushReplacement(MaterialPageRoute(
                                        // builder: (BuildContext context) => const RegisterAsScreen())),
                                        ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                'and',
                                style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13.0),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Privacy Policy',
                                        style: GoogleFonts.montserrat(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13.0,
                                            decoration:
                                                TextDecoration.underline),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () =>
                                              print('click Privacy Policy')
                                        // Navigator.of(context).pushReplacement(MaterialPageRoute(
                                        // builder: (BuildContext context) => const RegisterAsScreen())),
                                        ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              FadeInDown(
                from: 40,
                delay: const Duration(milliseconds: 650),
                child: Container(
                  margin: const EdgeInsets.only(top: 40),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StepFormButtonBack(
                        () {
                          Navigator.of(context).pop();
                        },
                        'BACK',
                      ),
                      StepFormButtonNext(
                        () {
                          validate();
                        },
                        'NEXT',
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ]),
      ),
    );
  }

  bool _init = true;
  @override
  void didChangeDependencies() async {
    if (_init) {
      final provider =
          Provider.of<RegisterCompanyViewModel>(context, listen: true);
      final locationProvider =
          Provider.of<GetLocationViewModel>(context, listen: false);
      final serviceProvider =
          Provider.of<ServicesAndDaysViewModel>(context, listen: false);
      // provider.categoriesList=[{'car': false}, {'bike': false}, {'truck': false},];
      // provider.daysList=[{'Monday':false},{'Tuesday':false},{'Wednesday':false},{'Thursday':false},{'Friday':false},{'Saturday':false},{'Sunday':false},];
      locationProvider.address = '';
      //services e.g car, bike
      serviceProvider.getServices();

      // get current location
      await locationProvider.getCurrentLocation(context);
    }
    _init = false;
    super.didChangeDependencies();
  }
}
