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
import '../../../utilities/towrevo_appcolor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterationCompleteScreen extends StatefulWidget {
  const RegisterationCompleteScreen({Key? key}) : super(key: key);

  static const routeName = '/complete';

  @override
  State<RegisterationCompleteScreen> createState() =>
      _RegisterationCompleteScreenState();
}

class _RegisterationCompleteScreenState
    extends State<RegisterationCompleteScreen> {
  final key = GlobalKey<FormState>();

  void validate(RegisterCompanyViewModel registerProvider) async {
    if (!key.currentState!.validate()) {
      return;
    }
    if (!registerProvider.isCheckedTermsAndCondition) {
      Fluttertoast.showToast(msg: 'Please Accept Term&Conditions');
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
    final locationProvider =
        Provider.of<GetLocationViewModel>(context, listen: false);

    if (locationProvider.myCurrentLocation.placeAddress.isNotEmpty &&
        daysAndServiceProvider.daysId.isNotEmpty &&
        daysAndServiceProvider.servicesId.isNotEmpty) {
      registerProvider.body['services'] =
          json.encode(daysAndServiceProvider.servicesId);
      registerProvider.body['days'] =
          json.encode(daysAndServiceProvider.daysId);
      // registerProvider.body['starting_price'] =
      //     startAmountController.text.trim();

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
        // physics: const NeverScrollableScrollPhysics(),
        child: Stack(
          children: [
            const FullBackgroundImage(),
            backIcon(context, () {
              Navigator.pop(context);
            }),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
              child: Form(
                key: key,
                child: Column(
                  children: [
                    SizedBox(height: 55.h),
                    FadeInDown(
                      from: 15,
                      delay: const Duration(milliseconds: 500),
                      child: const CompanySignUpTitle(),
                    ),
                    SizedBox(height: 40.h),
                    SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SelectorWidget(
                            context: context,
                            delayMilliseconds: 570,
                            title: registerViewModel.timeRadioValue == 0
                                ? '24 Hours'
                                : registerViewModel.timeRadioValue == 1
                                    ? 'Custom'
                                    : 'Select Time',
                            height: 50.h,
                            icon: FontAwesomeIcons.solidClock,
                            onTap: () {
                              showTimeDialog();
                            },
                          ),
                          SizedBox(height: 8.h),
                          if (registerViewModel.timeRadioValue == 1)
                            SelectorWidget(
                              context: context,
                              delayMilliseconds: 570,
                              title: (registerViewModel.timerValues['from'] !=
                                          '' ||
                                      registerViewModel.timerValues['to'] != '')
                                  ? '${(registerViewModel.timerValues['from'])} - ${(registerViewModel.timerValues['to'])}'
                                  : 'Select Custom Time',
                              height: 50.h,
                              icon: FontAwesomeIcons.solidClock,
                              onTap: () {
                                registerViewModel.setTimer(context);
                              },
                            ),
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
                                height: 50.h,
                                icon: FontAwesomeIcons.calendar,
                                onTap: () {
                                  showDays(context, true, false);
                                },
                              );
                            },
                          ),
                          SizedBox(height: 8.h),
                          Consumer<ServicesAndDaysViewModel>(
                              builder: (ctx, categories, neverBuildChild) {
                            return SelectorWidget(
                              context: context,
                              delayMilliseconds: 590,
                              title: categories.getService(),
                              height: 50.h,
                              icon: Icons.category_outlined,
                              trailingIcon:
                                  Icons.arrow_drop_down_circle_outlined,
                              onTap: () {
                                showCategories(context, true, false);
                              },
                            );
                          }),
                          SizedBox(height: 8.h),
                          FadeInDown(
                            from: 35,
                            delay: const Duration(milliseconds: 620),
                            child: Row(
                              children: [
                                Checkbox(
                                  activeColor: const Color(0xFF092848),
                                  value: registerViewModel
                                      .isCheckedTermsAndCondition,
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
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () =>
                                                  Navigator.of(context)
                                                      .pushNamed(
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
                        margin: EdgeInsets.only(top: 10.h),
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
                              signup:
                                  registerViewModel.isLoading ? true : false,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
      // final locationProvider =
      //     Provider.of<GetLocationViewModel>(context, listen: false);
      final serviceProvider =
          Provider.of<ServicesAndDaysViewModel>(context, listen: false);

      // locationProvider.myCurrentLocation.placeAddress = '';
      provider.initializeValues();
      serviceProvider.initializeValues();
      //services e.g car, bike
      serviceProvider.getServices();

      // get current location
      // await locationProvider.getCurrentLocation(context);
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

// class RegistrationCategoryAndTimingScreen extends StatefulWidget {
//   const RegistrationCategoryAndTimingScreen({Key? key}) : super(key: key);

//   static const routeName = '/category-and-timing';

//   @override
//   State<RegistrationCategoryAndTimingScreen> createState() =>
//       _RegistrationCategoryAndTimingScreenState();
// }

// class _RegistrationCategoryAndTimingScreenState
//     extends State<RegistrationCategoryAndTimingScreen> {
//   // final startAmountController = TextEditingController();
//   // Map<String, bool> cityList = {
//   //   'Monday': false,
//   //   'Tuesday': false,
//   //   'Wednesday': false,
//   //   'Thursday': false,
//   //   'Friday': false,
//   //   'Sarturday': false,
//   //   'Sunday': false,
//   // };

//   void validate(RegisterCompanyViewModel registerProvider) async {
//     if (!key.currentState!.validate()) {
//       return;
//     }
//     final locationProvider =
//         Provider.of<GetLocationViewModel>(context, listen: false);
//     if (!registerProvider.isCheckedTermsAndCondition) {
//       Fluttertoast.showToast(msg: 'Please Accept Term&Conditions');
//       return;
//     } else if (registerProvider.timeRadioValue == 1 &&
//         registerProvider.body['from'] == '' &&
//         registerProvider.body['to'] == '') {
//       Fluttertoast.showToast(msg: 'Please Select Custom Time');
//     } else if (registerProvider.timeRadioValue == 0) {
//       registerProvider.body.remove('from');
//       registerProvider.body.remove('to');
//     }
//     final daysAndServiceProvider =
//         Provider.of<ServicesAndDaysViewModel>(context, listen: false);

//     if (locationProvider.myCurrentLocation.placeAddress.isNotEmpty &&
//         daysAndServiceProvider.daysId.isNotEmpty &&
//         daysAndServiceProvider.servicesId.isNotEmpty) {
//       registerProvider.body['services'] =
//           json.encode(daysAndServiceProvider.servicesId);
//       registerProvider.body['days'] =
//           json.encode(daysAndServiceProvider.daysId);
//       // registerProvider.body['starting_price'] =
//       //     startAmountController.text.trim();

//       bool response = await registerProvider.registerCompany(context);
//       if (response) {
//         Navigator.of(context)
//             .pushNamed(RegistrationOTPScreen.routeName, arguments: true);
//       }
//     } else {
//       Fluttertoast.showToast(msg: 'Please Fill All Required Fields');
//     }
//   }

//   final key = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     final registerViewModel =
//         Provider.of<RegisterCompanyViewModel>(context, listen: true);
//     return 
//   }




// }
