import 'dart:convert';
import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/utilities/state_city_utility.dart';
import 'package:towrevo/utilities/utilities.dart';
import 'package:towrevo/view_model/view_model.dart';
import 'package:towrevo/widgets/widgets.dart';
import '/error_getter.dart';
import 'package:towrevo/screens/screens.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);
  static const routeName = '/edit-profile';

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
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

        await provider.getEditData(context);
        _init = true;
        type = await Utilities().getSharedPreferenceValue('type');
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
    phoneNumberController.text = (provider.body['phone'] ?? '').toString();

    if (type == '2') {
      descriptionController.text =
          (provider.body['company_info']['description'] ?? '').toString();
    }
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

      provider.editProfileFields(
        {
          'first_name': firstNameController.text.trim(),
          'description': descriptionController.text.trim(),
          'state': provider.selectedState!,
          'city': provider.selectedCity!,
          if (provider.imagePath.isNotEmpty) 'image': provider.image,
          if (provider.imagePath.isNotEmpty) 'extension': provider.extension,
          if (provider.timerValues['from'].toString().isNotEmpty)
            'from': provider.timerValues['from'].toString(),
          if (provider.timerValues['to'].toString().isNotEmpty)
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
    }
  }

  Widget image(EditProfileViewModel imagePicker) {
    if (imagePicker.imagePath.isEmpty) {
      if (imagePicker.body['image'] != null) {
        return ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
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
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: Image.file(
          File(imagePicker.imagePath),
          fit: BoxFit.fill,
        ),
      );
    }
  }

  Future<void> showCategories(BuildContext context) async {
    await showDialog(
      context: context,
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
      },
    );
  }

  Future<void> showDays(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (_) {
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
      },
    );
  }

  bool _init = true;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EditProfileViewModel>(context, listen: true);

    if (_init) {
      setFields(provider);
      _init = false;
    }
    return Scaffold(
      key: scaffoldKey,
      drawerEnableOpenDragGesture: false,
      drawer: const DrawerWidget(),
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
                      margin: const EdgeInsets.only(top: 40, left: 45),
                      child: Text(
                        'EDIT PROFILE',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 28.0,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                provider.isLoading
                    ? Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: circularProgress(),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
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
                                          width: 120,
                                          height: 120,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF09365f),
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          child: image(imagePicker),
                                        ),
                                        Positioned(
                                          left: 85,
                                          top: 85,
                                          child: Container(
                                            width: 35,
                                            height: 35,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF019aff),
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            child: const Icon(
                                              FontAwesomeIcons.camera,
                                              color: Colors.white,
                                              size: 18.0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                              const SizedBox(
                                height: 20,
                              ),
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
                              const SizedBox(
                                height: 10,
                              ),
                              if (type == '1')
                                FadeInDown(
                                  from: 20,
                                  delay: const Duration(milliseconds: 670),
                                  child: TextFieldForAll(
                                    errorGetter:
                                        ErrorGetter().lastNameErrorGetter,
                                    hintText: 'Last Name',
                                    prefixIcon: const Icon(
                                      FontAwesomeIcons.userAlt,
                                      color: Color(0xFF019aff),
                                      size: 20.0,
                                    ),
                                    textEditingController: lastNameController,
                                    textInputType: TextInputType.name,
                                  ),
                                ),
                              if (type == '2')
                                FadeInDown(
                                  from: 20,
                                  delay: const Duration(milliseconds: 670),
                                  child: CompanyTextAreaField(
                                    errorGetter: ErrorGetter()
                                        .companyDescriptionErrorGetter,
                                    hintText: 'Company Description',
                                    prefixIcon: const Icon(
                                      FontAwesomeIcons.solidBuilding,
                                      color: Color(0xFF019aff),
                                      size: 20.0,
                                    ),
                                    textEditingController:
                                        descriptionController,
                                  ),
                                ),
                              const SizedBox(
                                height: 10,
                              ),
                              FadeInDown(
                                from: 25,
                                delay: const Duration(milliseconds: 690),
                                child: TextFieldForAll(
                                  errorGetter: ErrorGetter().emailErrorGetter,
                                  hintText: 'Email Address',
                                  prefixIcon: const Icon(
                                    FontAwesomeIcons.solidEnvelopeOpen,
                                    color: Color(0xFF019aff),
                                    size: 20.0,
                                  ),
                                  textEditingController: emailController,
                                  fieldDisable: true,
                                  textInputType: TextInputType.emailAddress,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
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
                              const SizedBox(
                                height: 10,
                              ),
                              if (type == '2')
                                Consumer<GetLocationViewModel>(builder:
                                    (ctx, getLocation, neverBuildChild) {
                                  return InkWell(
                                    onTap: () async {
                                      Navigator.of(context).pushNamed(
                                        UserLocationScreen.routeName,
                                        arguments: true,
                                      );
                                    },
                                    child: FadeInDown(
                                      from: 35,
                                      delay: const Duration(milliseconds: 730),
                                      child: Container(
                                        height: getLocation.getMyAddress.isEmpty
                                            ? 50
                                            : null,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
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
                                                  Icons.location_on,
                                                  color: Color(0xFF019aff),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 8,
                                                  ),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.65,
                                                  child: Text(
                                                    getLocation.getMyAddress
                                                            .isEmpty
                                                        ? 'Get Location'
                                                        : getLocation
                                                            .getMyAddress,
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      color: Colors.black,
                                                    ),
                                                    maxLines: 3,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Icon(
                                              Icons.my_location,
                                              color: Color(0xFF019aff),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              if (type == '2')
                                const SizedBox(
                                  height: 10,
                                ),
                              if (type == '2')
                                Consumer<EditProfileViewModel>(
                                  builder: (ctx, timer, neverBuildChild) {
                                    return InkWell(
                                      onTap: () async {
                                        await timer.setTimer(context);
                                      },
                                      child: FadeInDown(
                                        from: 40,
                                        delay:
                                            const Duration(milliseconds: 750),
                                        child: Container(
                                          height: 50,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
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
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      vertical: 8,
                                                      horizontal: 5,
                                                    ),
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.65,
                                                    child: Text(
                                                      (timer.timerValues[
                                                                      'fromUtilize'] !=
                                                                  '' ||
                                                              timer.timerValues[
                                                                      'toUtilize'] !=
                                                                  '')
                                                          ? '${(timer.timerValues['fromUtilize'])} - ${(timer.timerValues['toUtilize'])}'
                                                          : 'Select Time',
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        color: Colors.black,
                                                      ),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
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
                              if (type == '2')
                                const SizedBox(
                                  height: 10,
                                ),
                              if (type == '2')
                                Consumer<ServicesAndDaysViewModel>(
                                  builder: (ctx, days, neverBuildChild) {
                                    return InkWell(
                                      onTap: () async {
                                        await showDays(context);
                                      },
                                      child: FadeInDown(
                                        from: 40,
                                        delay:
                                            const Duration(milliseconds: 770),
                                        child: Container(
                                          height: 50,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
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
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      vertical: 8,
                                                      horizontal: 5,
                                                    ),
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.65,
                                                    child: Text(
                                                      days.getDays(),
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        color: Colors.black,
                                                      ),
                                                      maxLines: 3,
                                                      overflow:
                                                          TextOverflow.ellipsis,
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
                              if (type == '2') const SizedBox(height: 10),
                              if (type == '2')
                                Consumer<ServicesAndDaysViewModel>(builder:
                                    (ctx, categories, neverBuildChild) {
                                  return InkWell(
                                    onTap: () async {
                                      await showCategories(context);
                                    },
                                    child: FadeInDown(
                                      from: 50,
                                      delay: const Duration(milliseconds: 800),
                                      child: Container(
                                        height: 55,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 15,
                                        ),
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
                                                  Icons.category_outlined,
                                                  color: Color(0xFF019aff),
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
                                              ],
                                            ),
                                            const Icon(
                                              Icons
                                                  .arrow_drop_down_circle_outlined,
                                              color: Color(0xFF019aff),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              if (type == '2') const SizedBox(height: 10),
                              FadeInDown(
                                from: 55,
                                delay: const Duration(milliseconds: 700),
                                child: Consumer<EditProfileViewModel>(
                                  builder: (ctx, registerUserViewModel,
                                      neverBuildChild) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 3),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(28),
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
                              const SizedBox(
                                height: 10,
                              ),
                              FadeInDown(
                                from: 60,
                                delay: const Duration(milliseconds: 700),
                                child: Consumer<EditProfileViewModel>(
                                  builder: (ctx, registerUserViewModel,
                                      neverBuildChild) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 3),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(28),
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
                                            'Select City',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          value: registerUserViewModel
                                              .selectedCity,
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
                                          }).toList()),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
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
                              const SizedBox(
                                height: 20,
                              ),
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
}
