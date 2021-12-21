import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:towrevo/screens/colors/towrevo_appcolor.dart';
import 'package:towrevo/widgets/company_form_field.dart';
import 'package:towrevo/widgets/form_button_widget.dart';
import 'package:towrevo/widgets/full_background_image.dart';

import '../../error_getter.dart';

class UserProfileUpdate extends StatefulWidget {
  const UserProfileUpdate({Key? key}) : super(key: key);

  @override
  _UserProfileUpdateState createState() => _UserProfileUpdateState();
}

class _UserProfileUpdateState extends State<UserProfileUpdate> {
  TextEditingController controller1 = TextEditingController();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          const FullBackgroundImage(),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Padding(
                //   padding: const EdgeInsets.symmetric(
                //     horizontal: 20,
                //     vertical: 30,
                //   ),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: const [
                //       Text('Cancel'),
                //       Text('Edit Profile'),
                //       Text('Update'),
                //     ],
                //   ),
                // ),
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
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Stack(
                        children: [
                          Container(
                            height: size.height * 0.15,
                            width: size.width * 0.30,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Icon(
                              FontAwesomeIcons.user,
                              color: Colors.white.withOpacity(0.5),
                              size: 70.0,
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              width: size.width * 0.09,
                              height: size.height * 0.045,
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor2.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: const Icon(
                                FontAwesomeIcons.camera,
                                color: Colors.white,
                                size: 15.0,
                              ),
                            ),
                          ),
                        ],
                      ),
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
                      // TextFieldForAll(
                      //   errorGetter: ErrorGetter().firstNameErrorGetter,
                      //   hintText: 'Last Name',
                      //   prefixIcon: const Icon(
                      //     FontAwesomeIcons.userAlt,
                      //     color: Color(0xFF019aff),
                      //     size: 20.0,
                      //   ),
                      //   textEditingController: firstNameController,
                      // ),
                      CompanyTextAreaField(
                        errorGetter:
                            ErrorGetter().companyDescriptionErrorGetter,
                        hintText: 'Company Description',
                        prefixIcon: const Icon(
                          FontAwesomeIcons.solidBuilding,
                          color: Color(0xFF019aff),
                          size: 20.0,
                        ),
                        textEditingController: controller1,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFieldForAll(
                        errorGetter: ErrorGetter().firstNameErrorGetter,
                        hintText: 'Email Address',
                        prefixIcon: const Icon(
                          FontAwesomeIcons.solidEnvelopeOpen,
                          color: Color(0xFF019aff),
                          size: 20.0,
                        ),
                        textEditingController: firstNameController,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFieldForAll(
                        errorGetter: ErrorGetter().firstNameErrorGetter,
                        hintText: 'Phone',
                        prefixIcon: const Icon(
                          FontAwesomeIcons.phoneAlt,
                          color: Color(0xFF019aff),
                          size: 20.0,
                        ),
                        textEditingController: firstNameController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FormButtonWidget(
                        'UPDATE',
                        () {
                          // validateForm();
                          // Navigator.of(context).pushNamed(RegistrationOTPScreen.routeName,arguments: false);
                        },
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
        ],
      ),
    );
  }
}
