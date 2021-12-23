import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/utilities.dart';
import 'package:towrevo/view_model/edit_profile_view_model.dart';
import 'package:towrevo/widgets/User/drawer_icon.dart';
import 'package:towrevo/widgets/company_form_field.dart';
import 'package:towrevo/widgets/drawer_widget.dart';
import 'package:towrevo/widgets/form_button_widget.dart';
import 'package:towrevo/widgets/full_background_image.dart';
import 'package:towrevo/widgets/profile_widget.dart';
import '../../error_getter.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);
  static const routeName = '/edit-profile';

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  String type = '';

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    final provider = Provider.of<EditProfileViewModel>(context, listen: false);
    provider.body = {};
    provider.extension = '';
    provider.image = '';
    provider.imagePath = '';
    provider.getEditData(context);
    Future.delayed(Duration.zero).then(
      (value) async {
        type = await Utilities().getSharedPreferenceValue('type');
      },
    );

    super.initState();
  }

  setFields(EditProfileViewModel provider) async {
    // print('in');

    firstNameController.text = (provider.body['first_name'] ?? '').toString();
    lastNameController.text = (provider.body['last_name'] ?? '').toString();
    emailController.text = (provider.body['email'] ?? '').toString();
    phoneNumberController.text = (provider.body['phone'] ?? '').toString();
  }

  validateAndUpdateForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    } else {
      final provider =
          Provider.of<EditProfileViewModel>(context, listen: false);
      provider.editProfileFields(
        {
          'first_name': firstNameController.text.trim(),
          'last_name': lastNameController.text.trim(),
          if (provider.imagePath.isNotEmpty) 'image': provider.image,
          if (provider.imagePath.isNotEmpty) 'image': provider.extension,
          'type': await Utilities().getSharedPreferenceValue('type')
        },
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
            'https://images.pexels.com/photos/1704488/pexels-photo-1704488.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
            fit: BoxFit.fill,
          ),
        );
      } else {
        return Icon(
          FontAwesomeIcons.building,
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

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EditProfileViewModel>(context, listen: true);
    final serviceProvider =
        Provider.of<EditProfileViewModel>(context, listen: false);
    setFields(provider);
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
                drawerIcon(
                  context,
                  () {
                    scaffoldKey.currentState!.openDrawer();
                  },
                ),
                FadeInDown(
                  from: 15,
                  delay: const Duration(milliseconds: 500),
                  child: Center(
                    child: Text(
                      'EDIT PROFILE',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 30.0,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
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
                          print(imagePicker.body['image']);
                          return FadeInDown(
                            from: 20,
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
                                      child: image(imagePicker)),
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
                                      child: const Icon(FontAwesomeIcons.camera,
                                          color: Colors.white, size: 18.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),

                        // const ProfileTowrevo(),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFieldForAll(
                          errorGetter: ErrorGetter().firstNameErrorGetter,
                          hintText: 'First Name',
                          prefixIcon: const Icon(
                            FontAwesomeIcons.userAlt,
                            color: Color(0xFF019aff),
                            size: 20.0,
                          ),
                          textEditingController: firstNameController,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        if (type == '1')
                          TextFieldForAll(
                            errorGetter: ErrorGetter().lastNameErrorGetter,
                            hintText: 'Last Name',
                            prefixIcon: const Icon(
                              FontAwesomeIcons.userAlt,
                              color: Color(0xFF019aff),
                              size: 20.0,
                            ),
                            textEditingController: lastNameController,
                          ),
                        if (type == '2')
                          CompanyTextAreaField(
                            errorGetter:
                                ErrorGetter().companyDescriptionErrorGetter,
                            hintText: 'Company Description',
                            prefixIcon: const Icon(
                              FontAwesomeIcons.solidBuilding,
                              color: Color(0xFF019aff),
                              size: 20.0,
                            ),
                            textEditingController: firstNameController,
                          ),

                        const SizedBox(
                          height: 10,
                        ),
                        TextFieldForAll(
                          errorGetter: ErrorGetter().emailErrorGetter,
                          hintText: 'Email Address',
                          prefixIcon: const Icon(
                            FontAwesomeIcons.solidEnvelopeOpen,
                            color: Color(0xFF019aff),
                            size: 20.0,
                          ),
                          textEditingController: emailController,
                          fieldDisable: true,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFieldForAll(
                          errorGetter: ErrorGetter().phoneNumberErrorGetter,
                          fieldDisable: true,
                          hintText: 'Phone',
                          prefixIcon: const Icon(
                            FontAwesomeIcons.phoneAlt,
                            color: Color(0xFF019aff),
                            size: 20.0,
                          ),
                          textEditingController: phoneNumberController,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        if (type == '2')
                          Container(
                            // height: getLocation.getAddress.isEmpty ? 50 : null,
                            height: 60,
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      FontAwesomeIcons.mapMarkerAlt,
                                      color: Color(0xFF019aff),
                                      size: 20,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8,
                                      ),
                                      // child: Text(
                                      //   getLocation.getAddress.isEmpty
                                      //       ? 'Get Location'
                                      //       : getLocation.getAddress,
                                      //   style: GoogleFonts.montserrat(
                                      //     color: Colors.black,
                                      //   ),
                                      //   maxLines: 3,
                                      //   // textAlign: TextAlign.left,
                                      //   overflow: TextOverflow.ellipsis,
                                      // ),
                                      child: const Text('Get Location'),
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
                        if (type == '2')
                          const SizedBox(
                            height: 10,
                          ),
                        if (type == '2')
                          Container(
                            height: 60,
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
                                      // width: MediaQuery.of(context).size.width *
                                      //     0.65,
                                      child: Text(
                                        // (timer.timerValues['from'] != '' ||
                                        //         timer.timerValues['to'] != '')
                                        //     ? '${(timer.timerValues['from'])} - ${(timer.timerValues['to'])}'
                                        //     :
                                        'Select Time',
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
                        if (type == '2')
                          const SizedBox(
                            height: 10,
                          ),
                        if (type == '2')
                          InkWell(
                            onTap: () {},
                            child: Container(
                              height: 60,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        FontAwesomeIcons.calendarDay,
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
                                        // width: MediaQuery.of(context).size.width *
                                        //     0.65,
                                        child: Text(
                                          'Select Days',
                                          // days.getDays(),
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
                        if (type == '2')
                          const SizedBox(
                            height: 10,
                          ),
                        if (type == '2')
                          Container(
                            height: 60,
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      'Select Services',
                                      // categories.getService(),
                                      style: GoogleFonts.montserrat(
                                        color: Colors.black,
                                      ),
                                    ),
                                    // if(categories.isNotEmpty)
                                    // Wrap(children: categories.map((e) => Text(e[''])).toList(),)
                                    // Container(padding: const EdgeInsets.symmetric(vertical: 8),width: MediaQuery.of(context).size.width*0.65,child: categories.isEmpty?'Select Categories':categories,style: GoogleFonts.montserrat(color: Colors.black,),maxLines: 3,overflow: TextOverflow.ellipsis,)),
                                  ],
                                ),
                                const Icon(
                                  FontAwesomeIcons.caretDown,
                                  color: Color(0xFF019aff),
                                ),
                              ],
                            ),
                          ),
                        const SizedBox(
                          height: 20,
                        ),
                        FormButtonWidget(
                          'UPDATE',
                          () {
                            validateAndUpdateForm();
                            // Navigator.of(context).pushNamed(RegistrationOTPScreen.routeName,arguments: false);
                          },
                        ),
                        const SizedBox(
                          height: 10,
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
