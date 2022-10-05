import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/screens/company/compnay_location_screen.dart';
// import 'package:towrevo/screens/screens.dart';
import '../../error_getter.dart';
import '../../utilities/state_city_utility.dart';
import '../../utilities/utilities.dart';
import '../../view_model/get_location_view_model.dart';
import '../../view_model/register_company_view_model.dart';
import '../../view_model/services_and_day_view_model.dart';
import '../../widgets/back_icon.dart';
import '../../widgets/background_image.dart';
import '../../widgets/services_days_and_description_check_box/selector_widget.dart';
import '../../widgets/services_days_and_description_check_box/show_check_box_dialog.dart';
import '../../widgets/text_form_fields.dart';
import 'company_home_screen.dart';
// import '../user/user_location_screen.dart';
// import '../user/user_location_screen.dart';

class CompanyVerificationFormScreen extends StatefulWidget {
  const CompanyVerificationFormScreen({Key? key}) : super(key: key);

  static const routeName = '/company-verification-form';

  @override
  State<CompanyVerificationFormScreen> createState() =>
      _CompanyVerificationFormScreenState();
}

class _CompanyVerificationFormScreenState
    extends State<CompanyVerificationFormScreen> {
  final companyDescriptionController = TextEditingController();
  final companyEINNumberController = TextEditingController();
  final companyStartAmountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool signupComplete = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    final serviceProvider =
        Provider.of<ServicesAndDaysViewModel>(context, listen: false);
    final provider =
        Provider.of<RegisterCompanyViewModel>(context, listen: false);
    provider.verificationInitalize();
    final locationProvider =
        Provider.of<GetLocationViewModel>(context, listen: false);
    // locationProvider.myCurrentLocation.placeAddress = '';

    provider.initStateAndCountry();
    serviceProvider.initializeValues();
    serviceProvider.getServices();
    await locationProvider.getStoreLocationIfExist(context);
  }

  void validateAndVerify() async {
    final companySignUpProvider =
        Provider.of<RegisterCompanyViewModel>(context, listen: false);
    final daysAndServiceProvider =
        Provider.of<ServicesAndDaysViewModel>(context, listen: false);
    final locationProvider =
        Provider.of<GetLocationViewModel>(context, listen: false);
    if (!_formKey.currentState!.validate()) {
      return;
    } else if (companySignUpProvider.servicesDescription().isEmpty) {
      Fluttertoast.showToast(msg: 'Please Select Company Service');
      return;
    } else if (locationProvider.myCurrentLocation.placeAddress == 'null') {
      Fluttertoast.showToast(msg: 'Please Select Location');
      return;
    } else if (companySignUpProvider.selectedState == null ||
        companySignUpProvider.selectedCity == null) {
      Fluttertoast.showToast(msg: 'Please Select State And City');
      return;
    } else {
      companySignUpProvider.verificationBody['starting_price'] =
          companyStartAmountController.text;
      companySignUpProvider.verificationBody['ein_number'] =
          companyEINNumberController.text;
      companySignUpProvider.verificationBody['description'] =
          companySignUpProvider.servicesDescription().trim() +
              (companyDescriptionController.text.isNotEmpty
                  ? 'Other' + companyDescriptionController.text.trim()
                  : '');
      companySignUpProvider.verificationBody['services'] =
          json.encode(daysAndServiceProvider.servicesId);
      companySignUpProvider.verificationBody['latitude'] =
          locationProvider.myCurrentLocation.placeLocation.latitude.toString();
      companySignUpProvider.verificationBody['longitude'] =
          locationProvider.myCurrentLocation.placeLocation.longitude.toString();
      companySignUpProvider.verificationBody['days'] =
          json.encode(daysAndServiceProvider.daysId);
      companySignUpProvider.verificationBody['state'] =
          companySignUpProvider.selectedState;
      companySignUpProvider.verificationBody['city'] =
          companySignUpProvider.selectedCity;

      // print(companySignUpProvider.verificationBody);
      // print(locationProvider.myCurrentLocation.placeAddress);
      bool response = await companySignUpProvider.updateVerfiedCompany(context);
      // print(response);
      if (response) {
        Navigator.of(context).pushNamed(CompanyHomeScreen.routeName);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final registerViewModel =
        Provider.of<RegisterCompanyViewModel>(context, listen: true);
    return Scaffold(
      body: Stack(
        children: [
          const FullBackgroundImage(),
          // backIcon(context, () {
          //   Navigator.pop(context);
          // }),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                backIcon(context, () {
                  Navigator.pop(context);
                }),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 15.h,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'VERIFCATION FORM',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 26.0,
                            letterSpacing: 1.5,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        FadeInDown(
                          from: 25,
                          delay: const Duration(milliseconds: 550),
                          child: TextFieldForAll(
                            errorGetter: ErrorGetter().startingPriceErrorGetter,
                            hintText: 'Starting Price',
                            prefixIcon: const Icon(
                              FontAwesomeIcons.dollarSign,
                              color: Color(0xFF019aff),
                              size: 20.0,
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            textEditingController: companyStartAmountController,
                            textInputType: TextInputType.number,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        // EIN Number Field
                        FadeInDown(
                          from: 25,
                          delay: const Duration(milliseconds: 550),
                          child: TextFieldForAll(
                            errorGetter: ErrorGetter().isEINNumberValid,
                            hintText: 'EIN Business Number',
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(9),
                            ],
                            prefixIcon: const Icon(
                              FontAwesomeIcons.idBadge,
                              color: Color(0xFF019aff),
                              size: 20.0,
                            ),
                            textEditingController: companyEINNumberController,
                            textInputType: TextInputType.number,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Consumer<RegisterCompanyViewModel>(
                          builder: (ctx, registerViewModel, neverBuildChild) {
                            return SelectorWidget(
                              context: context,
                              delayMilliseconds: 570,
                              title: Utilities.getDesc(
                                registerViewModel,
                                companyDescriptionController,
                              ),
                              height: registerViewModel
                                      .servicesDescription()
                                      .contains('\n')
                                  ? null
                                  : 50.h,
                              icon: FontAwesomeIcons.solidBuilding,
                              // trailingIcon: FontAwesomeIcons.solidBuilding,
                              onTap: () {
                                showServiceDescription(
                                  registerViewModel,
                                  context,
                                  true,
                                  companyDescriptionController,
                                );
                              },
                            );
                          },
                        ),
                        SizedBox(height: 8.h),
                        Consumer<GetLocationViewModel>(
                          builder: (ctx, getLocation, neverBuildChild) {
                            // print(
                            //     'loc ${getLocation.myCurrentLocation.placeAddress}');
                            return SelectLocation(
                              context: context,
                              delayMilliseconds: 570,
                              title: getLocation
                                          .myCurrentLocation.placeAddress ==
                                      ''
                                  ? 'Company Location'
                                  : getLocation.myCurrentLocation.placeAddress,
                              height: 50.h,
                              maxlines: 2,
                              icon: Icons.location_on,
                              trailingIcon: Icons.my_location,
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  CompanyLocationScreen.routeName,
                                  // arguments: true,
                                );
                              },
                            );
                          },
                        ),
                        SizedBox(height: 8.h),
                        // SelectorWidget(
                        //   context: context,
                        //   delayMilliseconds: 570,
                        //   title: registerViewModel.timeRadioValue == 0
                        //       ? '24 Hours'
                        //       : registerViewModel.timeRadioValue == 1
                        //           ? 'Custom'
                        //           : 'Select Time',
                        //   height: 50.h,
                        //   icon: FontAwesomeIcons.solidClock,
                        //   onTap: () {
                        //     showTimeDialog();
                        //   },
                        // ),
                        // SizedBox(height: 8.h),
                        // if (registerViewModel.timeRadioValue == 1)
                        //   SelectorWidget(
                        //     context: context,
                        //     delayMilliseconds: 570,
                        //     title: (registerViewModel.timerValues['from'] !=
                        //                 '' ||
                        //             registerViewModel.timerValues['to'] != '')
                        //         ? '${(registerViewModel.timerValues['from'])} - ${(registerViewModel.timerValues['to'])}'
                        //         : 'Select Custom Time',
                        //     height: 50.h,
                        //     icon: FontAwesomeIcons.solidClock,
                        //     onTap: () {
                        //       registerViewModel.setTimer(context);
                        //     },
                        //   ),
                        // if (registerViewModel.timeRadioValue != 1)
                        //   const SizedBox(),
                        // if (registerViewModel.timeRadioValue == 1)
                        //   SizedBox(height: 8.h),
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
                          },
                        ),
                        SizedBox(height: 8.h),
                        FadeInDown(
                          from: 70,
                          delay: const Duration(milliseconds: 590),
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
                                onChanged: (val) => registerViewModel
                                    .changeState(val.toString()),
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
                          delay: const Duration(milliseconds: 610),
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
                        SizedBox(height: 16.h),
                        // Consumer<RegisterCompanyViewModel>(
                        //     builder: (context, viewModel, _) {
                        //   print(viewModel.isLoading);
                        //   return
                        Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [0.1, 0.7],
                              colors: [
                                Color(0xFF0195f7),
                                Color(0xFF083054),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                              shadowColor: Colors.transparent,
                              primary: Colors.transparent,
                              minimumSize: Size(
                                MediaQuery.of(context).size.width,
                                MediaQuery.of(context).size.height * 0.045,
                              ),
                            ),
                            onPressed: () {
                              validateAndVerify();
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 10,
                                bottom: 10,
                              ),
                              child: registerViewModel.isLoading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2.0,
                                      ),
                                    )
                                  : Text(
                                      'SUBMIT',
                                      style: GoogleFonts.montserrat(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17.0,
                                        letterSpacing: 1.0,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        // }),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
