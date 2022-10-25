import 'dart:convert';
import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/screens/company/compnay_location_screen.dart';
import 'package:towrevo/utilities/state_city_utility.dart';
import 'package:towrevo/utilities/utilities.dart';
import 'package:towrevo/view_model/view_model.dart';
import 'package:towrevo/widgets/widgets.dart';
import '/error_getter.dart';
// import 'package:towrevo/screens/screens.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);
  static const routeName = '/edit-profile';

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  // final descriptionController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final startAmountController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  String type = '';

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Future.delayed(Duration.zero).then(
      (value) async {
        final provider =
            Provider.of<EditProfileViewModel>(context, listen: false);
        provider.initFields();

        await provider.getEditData(context, descriptionController);
        // _init = true;
        type = await Utilities().getSharedPreferenceValue('type');
        setFields(provider);
      },
    );

    super.initState();
  }

  setFields(EditProfileViewModel provider) async {
    firstNameController.text = (provider.body['first_name'] ?? '').toString();
    if (type == '1') {
      lastNameController.text = (provider.body['last_name'] ?? '').toString();
    }
    emailController.text = (provider.body['email'] ?? '').toString();
    // print(type);
    if (type == '2') {
      startAmountController.text =
          (provider.body['company_info']['starting_price'] ?? '').toString();
    }

    phoneNumberController.text = (provider.body['phone'] ?? '').toString();

    // if (type == '2') {
    //   descriptionController.text =
    //       (provider.body['company_info']['description'] ?? '').toString();
    // }
  }

  validateAndUpdateUserForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    } else {
      final provider =
          Provider.of<EditProfileViewModel>(context, listen: false);
      provider.editProfileFields(
        {
          'first_name': firstNameController.text.trim(),
          'last_name': lastNameController.text.trim(),
          'state': provider.selectedState!,
          'city': provider.selectedCity!,
          if (provider.imagePath.isNotEmpty) 'image': provider.image,
          if (provider.imagePath.isNotEmpty) 'extension': provider.extension,
          'type': type,
        },
        context,
      );
    }
  }

  validateAndUpdateCompanyForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    } else {
      final provider =
          Provider.of<EditProfileViewModel>(context, listen: false);
      final daysAndServiceProvider =
          Provider.of<ServicesAndDaysViewModel>(context, listen: false);

      final locationProvider =
          Provider.of<GetLocationViewModel>(context, listen: false);
      final companyRegisterProvider =
          Provider.of<RegisterCompanyViewModel>(context, listen: false);

      if (daysAndServiceProvider.daysId.isNotEmpty &&
          daysAndServiceProvider.servicesId.isNotEmpty &&
          (companyRegisterProvider.servicesDescription().trim() +
                  (descriptionController.text.isNotEmpty
                      ? 'Other' + descriptionController.text.trim()
                      : ''))
              .isNotEmpty) {
        companyRegisterProvider.body['description'] =
            // companyRegisterProvider.servicesDescription().trim();
            companyRegisterProvider.servicesDescription().trim() +
                (descriptionController.text.isNotEmpty
                    ? 'Other' + descriptionController.text.trim()
                    : '');
        provider.body['services'] =
            json.encode(daysAndServiceProvider.servicesId);
        provider.body['days'] = json.encode(daysAndServiceProvider.daysId);

        provider.editProfileFields(
          {
            'first_name': firstNameController.text.trim(),
            'description':
                companyRegisterProvider.servicesDescription().trim() +
                    (descriptionController.text.isNotEmpty
                        ? 'Other' + descriptionController.text.trim()
                        : ''),
            'state': provider.selectedState!,
            'city': provider.selectedCity!,
            'starting_price': startAmountController.text.trim(),
            if (provider.imagePath.isNotEmpty) 'image': provider.image,
            if (provider.imagePath.isNotEmpty) 'extension': provider.extension,
            if (provider.timerValues['from'].toString().isNotEmpty &&
                provider.timeRadioValue == 1)
              'from': provider.timerValues['from'].toString(),
            if (provider.timerValues['to'].toString().isNotEmpty &&
                provider.timeRadioValue == 1)
              'to': provider.timerValues['to'].toString(),
            if (daysAndServiceProvider.servicesId.isNotEmpty)
              'services': json.encode(
                daysAndServiceProvider.servicesId,
              ),
            if (daysAndServiceProvider.daysId.isNotEmpty)
              'days': json.encode(
                daysAndServiceProvider.daysId,
              ),
            if (locationProvider.myCurrentLocation.placeLocation !=
                const LatLng(0.0, 0.0))
              'latitude': locationProvider
                  .myCurrentLocation.placeLocation.latitude
                  .toString(),
            if (locationProvider.myCurrentLocation.placeLocation !=
                const LatLng(0.0, 0.0))
              'longitude': locationProvider
                  .myCurrentLocation.placeLocation.longitude
                  .toString(),
            'type': type,
          },
          context,
        );

        // bool response = await registerProvider.registerCompany(context);
        // if (response) {
        //   Navigator.of(context)
        //       .pushNamed(RegistrationOTPScreen.routeName, arguments: true);
        // }
      } else {
        Fluttertoast.showToast(msg: 'Please Fill All Required Fields');
      }
    }
  }

  Widget image(EditProfileViewModel imagePicker) {
    if (imagePicker.imagePath.isEmpty) {
      if (imagePicker.body['image'] != null) {
        return ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(4.r),
          ),
          child: Image.network(
            Utilities.imageBaseUrl + imagePicker.body['image'].toString(),
            fit: BoxFit.fill,
          ),
        );
      } else {
        return Icon(
          FontAwesomeIcons.user,
          color: Colors.white.withOpacity(0.5),
          size: 75.0,
        );
      }
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10.r)),
        child: Image.file(
          File(imagePicker.imagePath),
          fit: BoxFit.fill,
        ),
      );
    }
  }

  final descriptionController = TextEditingController();

  // bool _init = true;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EditProfileViewModel>(context, listen: true);
    print(provider.isLoading);
    print('type $type');
    // final locationProvider =
    //     Provider.of<GetLocationViewModel>(context, listen: false);

    // print(locationProvider.getMyAddress.toString());

    // if (_init) {
    //   setFields(provider);
    //   _init = false;
    // }
    return Scaffold(
      // key: scaffoldKey,
      // drawerEnableOpenDragGesture: false,
      // drawer: const DrawerWidget(),
      body: Stack(
        children: [
          const SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: FullBackgroundImage(),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: backIcon(context, () {
                        Navigator.of(context).pop();
                      }),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30.h, left: 25.w),
                      child: Text(
                        'UPDATE PROFILE',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 25.sp,
                          letterSpacing: 1.w,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                provider.isLoading
                    ? Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: ScreenUtil().screenHeight * 0.7,
                          child: circularProgress(),
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 13.w),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              SizedBox(height: 5.h),
                              Consumer<EditProfileViewModel>(
                                  builder: (ctx, imagePicker, neverBuildChild) {
                                // print(imagePicker.body['image']);
                                return FadeInDown(
                                  from: 10,
                                  delay: const Duration(milliseconds: 600),
                                  child: GestureDetector(
                                    onTap: () {
                                      imagePicker.pickImage();
                                    },
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: 120.w,
                                          height: 110.h,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF09365f),
                                            borderRadius:
                                                BorderRadius.circular(6.r),
                                          ),
                                          child: image(imagePicker),
                                        ),
                                        Positioned(
                                          left: 85.w,
                                          top: 80.h,
                                          child: Container(
                                            width: 35.w,
                                            height: 30.h,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF019aff),
                                              borderRadius:
                                                  BorderRadius.circular(4.r),
                                            ),
                                            child: Icon(
                                              FontAwesomeIcons.camera,
                                              color: Colors.white,
                                              size: 17.sp,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                              SizedBox(height: 20.h),
                              FadeInDown(
                                from: 10,
                                delay: const Duration(milliseconds: 650),
                                child: TextFieldForAll(
                                  errorGetter:
                                      ErrorGetter().firstNameErrorGetter,
                                  hintText: 'First Name',
                                  prefixIcon: const Icon(
                                    FontAwesomeIcons.userAlt,
                                    color: Color(0xFF019aff),
                                    size: 20.0,
                                  ),
                                  textEditingController: firstNameController,
                                  textInputType: TextInputType.name,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              if (type == '1')
                                FadeInDown(
                                  from: 20,
                                  delay: const Duration(milliseconds: 670),
                                  child: TextFieldForAll(
                                    errorGetter:
                                        ErrorGetter().lastNameErrorGetter,
                                    hintText: 'Last Name',
                                    prefixIcon: Icon(
                                      FontAwesomeIcons.userAlt,
                                      color: const Color(0xFF019aff),
                                      size: 18.sp,
                                    ),
                                    textEditingController: lastNameController,
                                    textInputType: TextInputType.name,
                                  ),
                                ),
                              if (type == '2')
                                Consumer<RegisterCompanyViewModel>(
                                  builder: (ctx, registerViewModel,
                                      neverBuildChild) {
                                    return SelectorWidget(
                                      context: context,
                                      delayMilliseconds: 570,
                                      title: Utilities.getDesc(
                                        registerViewModel,
                                        descriptionController,
                                      ),
                                      height: registerViewModel
                                              .servicesDescription()
                                              .contains('\n')
                                          ? null
                                          : 50.h,
                                      icon: FontAwesomeIcons.solidBuilding,
                                      // maxlines: 5,
                                      trailingIcon:
                                          Icons.arrow_drop_down_circle_outlined,
                                      onTap: () {
                                        showServiceDescription(
                                          registerViewModel,
                                          context,
                                          false,
                                          descriptionController,
                                        );
                                      },
                                    );
                                  },
                                ),
                              SizedBox(height: 8.h),
                              FadeInDown(
                                from: 25,
                                delay: const Duration(milliseconds: 690),
                                child: TextFieldForAll(
                                  errorGetter: ErrorGetter().emailErrorGetter,
                                  hintText: 'Email Address',
                                  prefixIcon: Icon(
                                    FontAwesomeIcons.solidEnvelopeOpen,
                                    color: const Color(0xFF019aff),
                                    size: 18.sp,
                                  ),
                                  textEditingController: emailController,
                                  fieldDisable: true,
                                  textInputType: TextInputType.emailAddress,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              FadeInDown(
                                from: 30,
                                delay: const Duration(milliseconds: 710),
                                child: PhoneField(
                                  errorGetter:
                                      ErrorGetter().phoneNumberErrorGetter,
                                  fieldDisable: true,
                                  hintText: 'Phone',
                                  textEditingController: phoneNumberController,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              if (type == '2')
                                FadeInDown(
                                  from: 25,
                                  delay: const Duration(milliseconds: 520),
                                  child: TextFieldForAll(
                                    errorGetter:
                                        ErrorGetter().startingPriceErrorGetter,
                                    hintText: 'Starting Price',
                                    prefixIcon: const Icon(
                                      FontAwesomeIcons.dollarSign,
                                      color: Color(0xFF019aff),
                                      size: 20.0,
                                    ),
                                    textEditingController:
                                        startAmountController,
                                    textInputType: TextInputType.number,
                                  ),
                                ),
                              if (type == '2') SizedBox(height: 10.h),
                              if (type == '2')
                                Consumer<GetLocationViewModel>(
                                  builder: (ctx, getLocation, neverBuildChild) {
                                    // print(getLocation.getAddress);
                                    return SelectLocation(
                                      context: context,
                                      delayMilliseconds: 550,
                                      title: getLocation.getMyAddress.isEmpty
                                          ? 'Get Company Location'
                                          : getLocation.getMyAddress,
                                      height: 50.h,
                                      maxlines: 2,
                                      icon: Icons.location_on,
                                      trailingIcon: Icons.my_location,
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                          CompanyLocationScreen.routeName,
                                          arguments: true,
                                        );
                                      },
                                    );
                                  },
                                ),
                              if (type == '2') SizedBox(height: 10.h),
                              if (type == '2')
                                Consumer<EditProfileViewModel>(
                                  builder: (ctx, timer, neverBuildChild) {
                                    return SelectorWidget(
                                      context: context,
                                      delayMilliseconds: 570,
                                      title: timer.timeRadioValue == 0
                                          ? '24 Hours'
                                          : timer.timeRadioValue == 1
                                              ? 'Custom'
                                              : 'Select Time',
                                      height: 50.h,
                                      icon: FontAwesomeIcons.solidClock,
                                      onTap: () {
                                        showTimeDialog();
                                      },
                                    );
                                  },
                                ),
                              if (provider.timeRadioValue == 1)
                                if (type == '2') SizedBox(height: 10.h),
                              if (provider.timeRadioValue == 1)
                                if (type == '2')
                                  Consumer<EditProfileViewModel>(
                                    builder: (ctx, timer, neverBuildChild) {
                                      return SelectorWidget(
                                        context: context,
                                        delayMilliseconds: 750,
                                        // title: (timer.timerValues['from'] !=
                                        //             '' ||
                                        //         timer.timerValues['to'] != '')
                                        //     ? '${(timer.timerValues['from'])} - ${(timer.timerValues['to'])}'
                                        //     : 'Select Custom Time',
                                        title: (timer.timerValues[
                                                        'fromUtilize'] !=
                                                    '' ||
                                                timer.timerValues[
                                                        'toUtilize'] !=
                                                    '')
                                            ? '${(timer.timerValues['fromUtilize'])} - ${(timer.timerValues['toUtilize'])}'
                                            : 'Select Time',
                                        height: 50.h,
                                        icon: FontAwesomeIcons.solidClock,
                                        onTap: () {
                                          timer.setTimer(context);
                                        },
                                      );
                                    },
                                  ),
                              if (type == '2') SizedBox(height: 8.h),
                              if (type == '2')
                                Consumer<ServicesAndDaysViewModel>(
                                  builder: (ctx, days, neverBuildChild) {
                                    return SelectorWidget(
                                      context: context,
                                      delayMilliseconds: 770,
                                      title: days.getDays(),
                                      height: 50.h,
                                      icon: FontAwesomeIcons.calendar,
                                      onTap: () {
                                        showDays(context, false, true);
                                      },
                                    );
                                  },
                                ),
                              if (type == '2') SizedBox(height: 8.h),
                              if (type == '2')
                                Consumer<ServicesAndDaysViewModel>(
                                  builder: (ctx, categories, neverBuildChild) {
                                    return SelectorWidget(
                                      context: context,
                                      delayMilliseconds: 800,
                                      title: categories.getService(),
                                      height: 50.h,
                                      icon: Icons.category_outlined,
                                      trailingIcon:
                                          Icons.arrow_drop_down_circle_outlined,
                                      onTap: () {
                                        showCategories(context, false, true);
                                      },
                                    );
                                  },
                                ),
                              if (type == '2') const SizedBox(height: 10),
                              FadeInDown(
                                from: 55,
                                delay: const Duration(milliseconds: 700),
                                child: Consumer<EditProfileViewModel>(
                                  builder: (ctx, registerUserViewModel,
                                      neverBuildChild) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 20.w,
                                        vertical: 3.h,
                                      ),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(28.r),
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Colors.black45)),
                                      width: double.infinity,
                                      child: DropdownButton(
                                        icon: const Icon(
                                          Icons.location_city,
                                          // size: 18,
                                          color: Color(0xFF019aff),
                                        ),
                                        underline: const SizedBox(),
                                        isExpanded: true,
                                        hint: const Text(
                                          'Select State',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        value:
                                            registerUserViewModel.selectedState,
                                        onChanged: (val) =>
                                            registerUserViewModel
                                                .changeState(val.toString()),
                                        items: usCityState.entries.map((state) {
                                          return DropdownMenuItem(
                                            child: Text(state.key),
                                            value: state.key,
                                          );
                                        }).toList(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: 10.h),
                              FadeInDown(
                                from: 60,
                                delay: const Duration(milliseconds: 700),
                                child: Consumer<EditProfileViewModel>(
                                  builder: (ctx, registerUserViewModel,
                                      neverBuildChild) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 20.w,
                                        vertical: 3.h,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(28.r),
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.black45,
                                        ),
                                      ),
                                      width: double.infinity,
                                      child: DropdownButton(
                                        icon: const Icon(
                                          Icons.location_city,
                                          // size: 18,
                                          color: Color(0xFF019aff),
                                        ),
                                        underline: const SizedBox(),
                                        isExpanded: true,
                                        hint: const Text(
                                          'Select City',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        value:
                                            registerUserViewModel.selectedCity,
                                        onChanged: (val) =>
                                            registerUserViewModel
                                                .changeCity(val.toString()),
                                        items: (registerUserViewModel
                                                        .selectedState ==
                                                    null
                                                ? []
                                                : usCityState[
                                                        registerUserViewModel
                                                            .selectedState]
                                                    as List<String>)
                                            .map((city) {
                                          return DropdownMenuItem(
                                            child: Text(city),
                                            value: city,
                                          );
                                        }).toList(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: 25.h),
                              FadeInUp(
                                from: 20,
                                duration: const Duration(milliseconds: 1200),
                                child: FormButtonWidget(
                                  formBtnTxt: 'UPDATE',
                                  onPressed: () {
                                    if (type == '1') {
                                      validateAndUpdateUserForm();
                                    } else if (type == '2') {
                                      validateAndUpdateCompanyForm();
                                    }
                                  },
                                ),
                              ),
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
        return Consumer<EditProfileViewModel>(
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
