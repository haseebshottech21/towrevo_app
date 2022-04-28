import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/widgets/widgets.dart';
import 'package:towrevo/view_model/view_model.dart';
import 'package:towrevo/screens/screens.dart';
import '../../../utilities/state_city_utility.dart';
import '../../../utilities/towrevo_appcolor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegistrationCategoryAndTimingScreen extends StatefulWidget {
  const RegistrationCategoryAndTimingScreen({Key? key}) : super(key: key);

  static const routeName = '/category-and-timing';

  @override
  State<RegistrationCategoryAndTimingScreen> createState() =>
      _RegistrationCategoryAndTimingScreenState();
}

class _RegistrationCategoryAndTimingScreenState
    extends State<RegistrationCategoryAndTimingScreen> {
  Map<String, bool> cityList = {
    'Monday': false,
    'Tuesday': false,
    'Wednesday': false,
    'Thursday': false,
    'Friday': false,
    'Sarturday': false,
    'Sunday': false,
  };
  Future<void> showDays(BuildContext context) async {
    final daysProvider =
        Provider.of<ServicesAndDaysViewModel>(context, listen: false);
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15.r),
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Select Days',
              ),
              FaIcon(FontAwesomeIcons.calendarDay)
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                daysProvider.clearDaysList();
                Navigator.pop(context, null);
              },
              child: const Text(
                'Cancle',
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, cityList);
              },
              child: const Text(
                'Done',
              ),
            ),
          ],
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
      },
    );
  }

  Future<void> showCategories(BuildContext context) async {
    final servicesProvider =
        Provider.of<ServicesAndDaysViewModel>(context, listen: false);
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15.r),
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Select Categories',
              ),
              FaIcon(FontAwesomeIcons.servicestack)
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                servicesProvider.clearServicesList();
                Navigator.pop(context, null);
              },
              child: const Text(
                'Cancel',
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, cityList);
              },
              child: const Text(
                'Done',
              ),
            ),
          ],
          content: Consumer<ServicesAndDaysViewModel>(
            builder: (ctx, provider, neverBuildChild) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: provider.serviceListViewModel.map(
                  (item) {
                    return ChangeNotifierProvider.value(
                      value: provider.serviceListViewModel[
                          provider.serviceListViewModel.indexOf(item)],
                      child: const ServiceCheckBoxWidget(),
                    );
                  },
                ).toList(),
              );
            },
          ),
        );
      },
    );
  }

  void validate() async {
    final locationProvider =
        Provider.of<GetLocationViewModel>(context, listen: false);
    final registerProvider =
        Provider.of<RegisterCompanyViewModel>(context, listen: false);
    if (!registerProvider.isCheckedTermsAndCondition) {
      Fluttertoast.showToast(msg: 'Please Accept Term&Conditions');
      return;
    } else if (registerProvider.selectedState == null ||
        registerProvider.selectedCity == null) {
      Fluttertoast.showToast(msg: 'Please Select State And City');
      return;
    }
    // print(registerProvider.body);
    final daysAndServiceProvider =
        Provider.of<ServicesAndDaysViewModel>(context, listen: false);
    // print(daysAndServiceProvider.daysId);
    // print(daysAndServiceProvider.servicesId);

    if (locationProvider.myCurrentLocation.placeAddress.isNotEmpty &&
        daysAndServiceProvider.daysId.isNotEmpty &&
        daysAndServiceProvider.servicesId.isNotEmpty &&
        registerProvider.body['from'] != '' &&
        registerProvider.body['to'] != '') {
      print(registerProvider.body);

      registerProvider.body['services'] =
          json.encode(daysAndServiceProvider.servicesId);
      registerProvider.body['days'] =
          json.encode(daysAndServiceProvider.daysId);
      // Navigator.of(context).pushNamed(RegistrationPaymentScreen.routeName);

      bool response = await registerProvider.registerCompany(context);
      if (response) {
        Navigator.of(context)
            .pushNamed(RegistrationOTPScreen.routeName, arguments: true);
      }
    } else {
      Fluttertoast.showToast(msg: 'Please Fill All Required Fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryColors = Theme.of(context).primaryColor;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(children: [
          const FullBackgroundImage(),
          backIcon(context, () {
            Navigator.pop(context);
          }),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
            child: Column(children: [
              SizedBox(height: 20.h),
              FadeInDown(
                from: 15,
                delay: const Duration(milliseconds: 500),
                child: const CompanySignUpTitle(),
              ),
              SizedBox(height: 18.h),
              SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Consumer<GetLocationViewModel>(
                        builder: (ctx, getLocation, neverBuildChild) {
                      // print(getLocation.getAddress);
                      return InkWell(
                        onTap: () async {
                          // Navigator.of(context).pushNamed(
                          //   GetLocationScreen.routeName,
                          // );
                          Navigator.of(context).pushNamed(
                            UserLocationScreen.routeName,
                            arguments: true,
                          );
                        },
                        child: FadeInDown(
                          from: 20,
                          delay: const Duration(milliseconds: 550),
                          child: Container(
                            height:
                                getLocation.getMyAddress.isEmpty ? 50.h : null,
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(30.r),
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
                                    SizedBox(width: 10.w),
                                    Center(
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        height: 40.h,
                                        // padding: const EdgeInsets.symmetric(
                                        //   vertical: 8,
                                        // ),
                                        width: ScreenUtil().screenWidth * 0.65,
                                        child: Text(
                                          getLocation.getMyAddress.isEmpty
                                              ? 'Get Company Location'
                                              : getLocation.getMyAddress,
                                          style: GoogleFonts.montserrat(
                                            color: Colors.black,
                                          ),
                                          maxLines: 2,
                                          // textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                        ),
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
                    SizedBox(height: 8.h),
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
                              height: 40.h,
                              padding: EdgeInsets.symmetric(horizontal: 15.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30.r),
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
                                      SizedBox(width: 10.w),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 8.h,
                                          horizontal: 5.w,
                                        ),
                                        width: ScreenUtil().screenWidth * 0.65,
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
                      },
                    ),
                    SizedBox(height: 8.h),
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
                              height: 40.h,
                              padding: EdgeInsets.symmetric(horizontal: 15.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30.r),
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
                                      SizedBox(width: 10.w),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 8.h,
                                          horizontal: 5.w,
                                        ),
                                        width: ScreenUtil().screenWidth * 0.65,
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
                    SizedBox(height: 8.h),
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
                            height: 40.h,
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(30.r),
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
                                    SizedBox(width: 10.w),
                                    Text(
                                      categories.getService(),
                                      style: GoogleFonts.montserrat(
                                        color: Colors.black,
                                      ),
                                    ),
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
                    SizedBox(height: 8.h),
                    FadeInDown(
                      from: 70,
                      delay: const Duration(milliseconds: 700),
                      child: Consumer<RegisterCompanyViewModel>(
                        builder: (ctx, registerUserViewModel, neverBuildChild) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: 3.h,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(28.r),
                              color: Colors.white,
                              border: Border.all(color: Colors.black45),
                            ),
                            width: double.infinity,
                            child: DropdownButton(
                                underline: const SizedBox(),
                                isExpanded: true,
                                hint: const Text(
                                  'Select State',
                                  style: TextStyle(color: Colors.black),
                                ),
                                value: registerUserViewModel.selectedState,
                                onChanged: (val) => registerUserViewModel
                                    .changeState(val.toString()),
                                items: usCityState.entries.map((state) {
                                  return DropdownMenuItem(
                                    child: Text(state.key),
                                    value: state.key,
                                  );
                                }).toList()),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 8.h),
                    FadeInDown(
                      from: 70,
                      delay: const Duration(milliseconds: 700),
                      child: Consumer<RegisterCompanyViewModel>(
                        builder: (ctx, registerUserViewModel, neverBuildChild) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: 3.h,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(28.r),
                                color: Colors.white,
                                border: Border.all(color: Colors.black45)),
                            width: double.infinity,
                            child: DropdownButton(
                                underline: const SizedBox(),
                                isExpanded: true,
                                hint: const Text(
                                  'Select City',
                                  style: TextStyle(color: Colors.black),
                                ),
                                value: registerUserViewModel.selectedCity,
                                onChanged: (val) => registerUserViewModel
                                    .changeCity(val.toString()),
                                items:
                                    (registerUserViewModel.selectedState == null
                                            ? []
                                            : usCityState[registerUserViewModel
                                                .selectedState] as List<String>)
                                        .map((state) {
                                  return DropdownMenuItem(
                                    child: Text(state),
                                    value: state,
                                  );
                                }).toList()),
                          );
                        },
                      ),
                    ),
                    FadeInDown(
                      from: 35,
                      delay: const Duration(milliseconds: 620),
                      child: Row(
                        children: [
                          Consumer<RegisterCompanyViewModel>(builder:
                              (ctx, registerViewModel, _neverBuildChild) {
                            return Checkbox(
                              activeColor: const Color(0xFF092848),
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
                                  fontSize: 11.sp,
                                ),
                              ),
                              SizedBox(width: 3.w),
                              RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                      text:
                                          'Term & Condition and Privacy Policay',
                                      style: GoogleFonts.montserrat(
                                        color: AppColors.primaryColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10.sp,
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () =>
                                            Navigator.of(context).pushNamed(
                                              TermAndCondition.routeName,
                                              arguments: true,
                                            ),
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
              SizedBox(height: 8.h),
              FadeInDown(
                from: 40,
                delay: const Duration(milliseconds: 650),
                child: Container(
                  margin: EdgeInsets.only(top: 15.h),
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StepFormButtonBack(
                        () {
                          Navigator.of(context).pop();
                        },
                        'BACK',
                      ),
                      Consumer<RegisterCompanyViewModel>(
                        builder: ((context, registerCompany, child) {
                          return StepFormButtonNext(
                            onPressed: () {
                              validate();
                            },
                            text: 'SIGNUP',
                            signup: registerCompany.isLoading ? true : false,
                          );
                        }),
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

      locationProvider.myCurrentLocation.placeAddress = '';
      provider.initializeValues();
      serviceProvider.initializeValues();
      //services e.g car, bike
      serviceProvider.getServices();

      // get current location
      await locationProvider.getCurrentLocation(context);
    }
    _init = false;
    super.didChangeDependencies();
  }
}
