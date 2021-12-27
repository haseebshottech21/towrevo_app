import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:towrevo/error_getter.dart';
import 'package:towrevo/widgets/company_form_field.dart';
import 'package:towrevo/widgets/form_button_widget.dart';
import 'package:towrevo/widgets/full_background_image.dart';

class ContactUs extends StatelessWidget {
  ContactUs({Key? key}) : super(key: key);

  static const routeName = '/contact-us';

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  validateAndSubmitQuery() {
    if (!_formKey.currentState!.validate()) {
      return;
    } else {
      //
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: FullBackgroundImage(),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                        'Contact Us',
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
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          FadeInDown(
                            from: 40,
                            delay: const Duration(milliseconds: 600),
                            child: TextFieldForAll(
                              errorGetter: ErrorGetter().firstNameErrorGetter,
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
                          FadeInDown(
                            from: 45,
                            delay: const Duration(milliseconds: 620),
                            child: TextFieldForAll(
                              errorGetter: ErrorGetter().lastNameErrorGetter,
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
                          const SizedBox(
                            height: 10,
                          ),
                          FadeInDown(
                            from: 50,
                            delay: const Duration(milliseconds: 640),
                            child: TextFieldForAll(
                              errorGetter: ErrorGetter().emailErrorGetter,
                              hintText: 'Email Address',
                              prefixIcon: const Icon(
                                FontAwesomeIcons.solidEnvelopeOpen,
                                color: Color(0xFF019aff),
                                size: 20.0,
                              ),
                              textEditingController: emailController,
                              textInputType: TextInputType.emailAddress,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          FadeInDown(
                            from: 55,
                            delay: const Duration(milliseconds: 660),
                            child: TextFieldForAll(
                              errorGetter: ErrorGetter().phoneNumberErrorGetter,
                              hintText: 'Phone Number',
                              prefixIcon: const Icon(
                                FontAwesomeIcons.phoneAlt,
                                color: Color(0xFF019aff),
                                size: 20.0,
                              ),
                              textEditingController: phoneNumberController,
                              textInputType: TextInputType.phone,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          FadeInDown(
                            from: 75,
                            delay: const Duration(milliseconds: 750),
                            child: FormButtonWidget(
                              'SIGNUP',
                              () {
                                // Navigator.of(context).pushNamed(RegistrationOTPScreen.routeName,arguments: false);
                              },
                            ),
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
          ),
        ],
      ),
    );
  }
}
