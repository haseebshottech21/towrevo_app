import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
// import 'package:towrevo/widgets/services_days_and_description_check_box/selector_widget.dart';
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
  // Future<void> showDays(BuildContext context) async {
  //   final daysProvider =
  //       Provider.of<ServicesAndDaysViewModel>(context, listen: false);
  //   await showDialog(
  //     barrierDismissible: false,
  //     context: context,
  //     builder: (_) {
  //       return AlertDialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.all(
  //             Radius.circular(15.r),
  //           ),
  //         ),
  //         title: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: const [
  //             Text(
  //               'Select Days',
  //             ),
  //             FaIcon(FontAwesomeIcons.calendarDay)
  //           ],
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             onPressed: () {
  //               daysProvider.clearDaysList();
  //               Navigator.pop(context, null);
  //             },
  //             child: const Text(
  //               'Cancle',
  //             ),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pop(context, cityList);
  //             },
  //             child: const Text(
  //               'Done',
  //             ),
  //           ),
  //         ],
  //         content: Consumer<ServicesAndDaysViewModel>(
  //             builder: (ctx, provider, neverBuildChild) {
  //           return Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: provider.daysListViewModel.map((item) {
  //                 return ChangeNotifierProvider.value(
  //                   value: provider.daysListViewModel[
  //                       provider.daysListViewModel.indexOf(item)],
  //                   child: const DaysCheckBoxWidget(),
  //                 );
  //               }).toList());
  //         }),
  //       );
  //     },
  //   );
  // }

  // Future<void> showCategories(BuildContext context) async {
  //   final servicesProvider =
  //       Provider.of<ServicesAndDaysViewModel>(context, listen: false);
  //   await showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (_) {
  //       return AlertDialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.all(
  //             Radius.circular(15.r),
  //           ),
  //         ),
  //         title: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: const [
  //             Text(
  //               'Select Categories',
  //             ),
  //             FaIcon(FontAwesomeIcons.servicestack)
  //           ],
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             onPressed: () {
  //               servicesProvider.clearServicesList();
  //               Navigator.pop(context, null);
  //             },
  //             child: const Text(
  //               'Cancel',
  //             ),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pop(context, cityList);
  //             },
  //             child: const Text(
  //               'Done',
  //             ),
  //           ),
  //         ],
  //         content: Consumer<ServicesAndDaysViewModel>(
  //           builder: (ctx, provider, neverBuildChild) {
  //             return Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: provider.serviceListViewModel.map(
  //                 (item) {
  //                   return ChangeNotifierProvider.value(
  //                     value: provider.serviceListViewModel[
  //                         provider.serviceListViewModel.indexOf(item)],
  //                     child: const ServiceCheckBoxWidget(),
  //                   );
  //                 },
  //               ).toList(),
  //             );
  //           },
  //         ),
  //       );
  //     },
  //   );
  // }

  void validate(RegisterCompanyViewModel registerProvider) async {
    final locationProvider =
        Provider.of<GetLocationViewModel>(context, listen: false);
    if (!registerProvider.isCheckedTermsAndCondition) {
      Fluttertoast.showToast(msg: 'Please Accept Term&Conditions');
      return;
    } else if (registerProvider.selectedState == null ||
        registerProvider.selectedCity == null) {
      Fluttertoast.showToast(msg: 'Please Select State And City');
      return;
    } else if (registerProvider.timeRadioValue == 1 &&
        registerProvider.body['from'] == '' &&
        registerProvider.body['to'] == '') {
      Fluttertoast.showToast(msg: 'Please Select Custom Time');
    } else if (registerProvider.timeRadioValue == 0) {
      registerProvider.body.remove('from');
      registerProvider.body.remove('to');
    }
    final daysAndServiceProvider =
        Provider.of<ServicesAndDaysViewModel>(context, listen: false);

    if (locationProvider.myCurrentLocation.placeAddress.isNotEmpty &&
        daysAndServiceProvider.daysId.isNotEmpty &&
        daysAndServiceProvider.servicesId.isNotEmpty) {
      registerProvider.body['services'] =
          json.encode(daysAndServiceProvider.servicesId);
      registerProvider.body['days'] =
          json.encode(daysAndServiceProvider.daysId);

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
    final registerViewModel =
        Provider.of<RegisterCompanyViewModel>(context, listen: true);
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
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
                          return SelectorWidget(
                            context: context,
                            // maxlines: 3,
                            delayMilliseconds: 550,
                            title: getLocation.getMyAddress.isEmpty
                                ? 'Get Company Location'
                                : getLocation.getMyAddress,
                            height:
                                getLocation.getMyAddress.isEmpty ? 40.h : 45.h,
                            icon: Icons.location_on,
                            trailingIcon: Icons.my_location,
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                UserLocationScreen.routeName,
                                arguments: true,
                              );
                            },
                          );
                        },
                      ),
                      SizedBox(height: 8.h),
                      SelectorWidget(
                        context: context,
                        delayMilliseconds: 570,
                        title: registerViewModel.timeRadioValue == 0
                            ? '24 Hours'
                            : registerViewModel.timeRadioValue == 1
                                ? 'Custom'
                                : 'Select Time',
                        height: 40.h,
                        icon: FontAwesomeIcons.solidClock,
                        onTap: () {
                          showTimeDialog();
                        },
                      ),
                      // InkWell(
                      //   onTap: () async {
                      //     showTimeDialog();
                      //   },
                      //   child: FadeInDown(
                      //     from: 25,
                      //     delay: const Duration(milliseconds: 570),
                      //     child: Container(
                      //       height: 40.h,
                      //       padding: EdgeInsets.symmetric(horizontal: 15.w),
                      //       decoration: BoxDecoration(
                      //         color: Colors.white,
                      //         borderRadius: BorderRadius.all(
                      //           Radius.circular(30.r),
                      //         ),
                      //       ),
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           Row(
                      //             children: [
                      //               const Icon(
                      //                 FontAwesomeIcons.solidClock,
                      //                 color: Color(0xFF019aff),
                      //                 size: 20.0,
                      //               ),
                      //               SizedBox(width: 10.w),
                      //               Container(
                      //                 padding: EdgeInsets.symmetric(
                      //                   vertical: 8.h,
                      //                   horizontal: 5.w,
                      //                 ),
                      //                 width: ScreenUtil().screenWidth * 0.65,
                      //                 child: Text(
                      //                   registerViewModel.timeRadioValue == 0
                      //                       ? '24 Hours'
                      //                       : registerViewModel.timeRadioValue ==
                      //                               1
                      //                           ? 'Custom'
                      //                           : 'Select Time',
                      //                   style: GoogleFonts.montserrat(
                      //                     color: Colors.black,
                      //                   ),
                      //                   maxLines: 2,
                      //                   overflow: TextOverflow.ellipsis,
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(height: 8.h),
                      if (registerViewModel.timeRadioValue == 1)
                        SelectorWidget(
                          context: context,
                          delayMilliseconds: 570,
                          title: (registerViewModel.timerValues['from'] != '' ||
                                  registerViewModel.timerValues['to'] != '')
                              ? '${(registerViewModel.timerValues['from'])} - ${(registerViewModel.timerValues['to'])}'
                              : 'Select Custom Time',
                          height: 40.h,
                          icon: FontAwesomeIcons.solidClock,
                          onTap: () {
                            registerViewModel.setTimer(context);
                          },
                        ),
                      // InkWell(
                      //   onTap: () async {
                      //     await registerViewModel.setTimer(context);
                      //   },
                      //   child: FadeInDown(
                      //     from: 25,
                      //     delay: const Duration(milliseconds: 570),
                      //     child: Container(
                      //       height: 40.h,
                      //       padding: EdgeInsets.symmetric(horizontal: 15.w),
                      //       decoration: BoxDecoration(
                      //         color: Colors.white,
                      //         borderRadius: BorderRadius.all(
                      //           Radius.circular(30.r),
                      //         ),
                      //       ),
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           Row(
                      //             children: [
                      //               const Icon(
                      //                 FontAwesomeIcons.solidClock,
                      //                 color: Color(0xFF019aff),
                      //                 size: 20.0,
                      //               ),
                      //               SizedBox(width: 10.w),
                      //               Container(
                      //                 padding: EdgeInsets.symmetric(
                      //                   vertical: 8.h,
                      //                   horizontal: 5.w,
                      //                 ),
                      //                 width: ScreenUtil().screenWidth * 0.65,
                      //                 child: Text(
                      //                   (registerViewModel.timerValues['from'] !=
                      //                               '' ||
                      //                           registerViewModel
                      //                                   .timerValues['to'] !=
                      //                               '')
                      //                       ? '${(registerViewModel.timerValues['from'])} - ${(registerViewModel.timerValues['to'])}'
                      //                       : 'Select Custom Time',
                      //                   style: GoogleFonts.montserrat(
                      //                     color: Colors.black,
                      //                   ),
                      //                   maxLines: 2,
                      //                   overflow: TextOverflow.ellipsis,
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      if (registerViewModel.timeRadioValue != 1)
                        const SizedBox(),
                      if (registerViewModel.timeRadioValue == 1)
                        SizedBox(height: 8.h),
                      Consumer<ServicesAndDaysViewModel>(
                        builder: (ctx, days, neverBuildChild) {
                          return SelectorWidget(
                            context: context,
                            delayMilliseconds: 570,
                            title: days.getDays(),
                            height: 45.h,
                            icon: FontAwesomeIcons.calendar,
                            onTap: () {
                              showDays(context, true);
                            },
                          );
                          // return InkWell(
                          //   onTap: () async {
                          //     await showDays(context, true);
                          //   },
                          //   child: FadeInDown(
                          //     from: 25,
                          //     delay: const Duration(milliseconds: 570),
                          //     child: Container(
                          //       height: 40.h,
                          //       padding: EdgeInsets.symmetric(horizontal: 15.w),
                          //       decoration: BoxDecoration(
                          //         color: Colors.white,
                          //         borderRadius: BorderRadius.all(
                          //           Radius.circular(30.r),
                          //         ),
                          //       ),
                          //       child: Row(
                          //         mainAxisAlignment:
                          //             MainAxisAlignment.spaceBetween,
                          //         children: [
                          //           Row(
                          //             children: [
                          //               const Icon(
                          //                 FontAwesomeIcons.solidClock,
                          //                 color: Color(0xFF019aff),
                          //                 size: 20.0,
                          //               ),
                          //               SizedBox(width: 10.w),
                          //               Container(
                          //                 padding: EdgeInsets.symmetric(
                          //                   vertical: 8.h,
                          //                   horizontal: 5.w,
                          //                 ),
                          //                 width: ScreenUtil().screenWidth * 0.65,
                          //                 child: Text(
                          //                   days.getDays(),
                          //                   style: GoogleFonts.montserrat(
                          //                     color: Colors.black,
                          //                   ),
                          //                   maxLines: 3,
                          //                   overflow: TextOverflow.ellipsis,
                          //                 ),
                          //               ),
                          //             ],
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          // );
                        },
                      ),
                      SizedBox(height: 8.h),
                      Consumer<ServicesAndDaysViewModel>(
                          builder: (ctx, categories, neverBuildChild) {
                        return SelectorWidget(
                          context: context,
                          delayMilliseconds: 590,
                          title: categories.getService(),
                          height: 40.h,
                          icon: Icons.category_outlined,
                          trailingIcon: Icons.arrow_drop_down_circle_outlined,
                          onTap: () {
                            showCategories(context, true);
                          },
                        );
                        // return InkWell(
                        //   onTap: () async {
                        //     await showCategories(context, true);
                        //   },
                        //   child: FadeInDown(
                        //     from: 30,
                        //     delay: const Duration(milliseconds: 590),
                        //     child: Container(
                        //       height: 40.h,
                        //       padding: EdgeInsets.symmetric(horizontal: 12.w),
                        //       decoration: BoxDecoration(
                        //         color: Colors.white,
                        //         borderRadius: BorderRadius.all(
                        //           Radius.circular(30.r),
                        //         ),
                        //       ),
                        //       child: Row(
                        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           Row(
                        //             children: [
                        //               Icon(
                        //                 Icons.category_outlined,
                        //                 color: primaryColors,
                        //               ),
                        //               SizedBox(width: 10.w),
                        //               Text(
                        //                 categories.getService(),
                        //                 style: GoogleFonts.montserrat(
                        //                   color: Colors.black,
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //           Icon(
                        //             Icons.arrow_drop_down_circle_outlined,
                        //             color: primaryColors,
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // );
                      }),
                      SizedBox(height: 8.h),
                      FadeInDown(
                        from: 70,
                        delay: const Duration(milliseconds: 700),
                        child: Container(
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
                              value: registerViewModel.selectedState,
                              onChanged: (val) =>
                                  registerViewModel.changeState(val.toString()),
                              items: usCityState.entries.map((state) {
                                return DropdownMenuItem(
                                  child: Text(state.key),
                                  value: state.key,
                                );
                              }).toList()),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      FadeInDown(
                        from: 70,
                        delay: const Duration(milliseconds: 700),
                        child: Container(
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
                            value: registerViewModel.selectedCity,
                            onChanged: (val) =>
                                registerViewModel.changeCity(val.toString()),
                            items: (registerViewModel.selectedState == null
                                    ? []
                                    : usCityState[registerViewModel
                                        .selectedState] as List<String>)
                                .map(
                              (state) {
                                return DropdownMenuItem(
                                  child: Text(state),
                                  value: state,
                                );
                              },
                            ).toList(),
                          ),
                        ),
                      ),
                      FadeInDown(
                        from: 35,
                        delay: const Duration(milliseconds: 620),
                        child: Row(
                          children: [
                            Checkbox(
                              activeColor: const Color(0xFF092848),
                              value:
                                  registerViewModel.isCheckedTermsAndCondition,
                              onChanged: (bool? value) {
                                registerViewModel.toggleTermsAndCondition();
                              },
                            ),
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
                        StepFormButtonNext(
                          onPressed: () {
                            validate(registerViewModel);
                          },
                          text: 'SIGNUP',
                          signup: registerViewModel.isLoading ? true : false,
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ),
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

  showTimeDialog() {
    showDialog(
      context: context,
      builder: (_) {
        return Consumer<RegisterCompanyViewModel>(
          builder: (context, value, child) {
            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RadioListTile(
                    value: 0,
                    groupValue: value.timeRadioValue,
                    onChanged: (val) {
                      value.changeTimeRadio(
                        int.parse(
                          val.toString(),
                        ),
                      );
                      // print(val.toString());
                    },
                    title: const Text('24 Hours'),
                  ),
                  RadioListTile(
                    value: 1,
                    groupValue: value.timeRadioValue,
                    onChanged: (val) {
                      value.changeTimeRadio(
                        int.parse(
                          val.toString(),
                        ),
                      );
                      // print(val.toString());
                    },
                    title: const Text('Custom'),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Ok'),
                )
              ],
            );
          },
        );
      },
    );
  }
}
