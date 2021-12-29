import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:towrevo/error_getter.dart';
import 'package:towrevo/screens/colors/towrevo_appcolor.dart';
import 'package:towrevo/widgets/User/drawer_icon.dart';
import 'package:towrevo/widgets/company_form_field.dart';
import 'package:towrevo/widgets/drawer_widget.dart';
import 'package:towrevo/widgets/form_button_widget.dart';
import 'package:towrevo/widgets/full_background_image.dart';
import 'package:towrevo/widgets/towrevo_logo.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);
  static const routeName = '/contact-us';

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
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
      key: scaffoldKey,
      drawerEnableOpenDragGesture: false,
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              const FullBackgroundImage(),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          drawerIcon(
                            context,
                            () {
                              scaffoldKey.currentState!.openDrawer();
                            },
                          ),
                          const SizedBox(width: 50),
                          Center(
                            child: Text(
                              'CONTACT US',
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
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            const TowrevoLogoSmall(),
                            const SizedBox(
                              height: 15,
                            ),
                            Center(
                              child: Text(
                                'WE\'D LOVE TO HELP YOU IN EMAIL OR VIA CALL!',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18.0,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            FadeInDown(
                              from: 10,
                              delay: const Duration(milliseconds: 650),
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
                            const SizedBox(height: 10),
                            FadeInDown(
                              from: 15,
                              delay: const Duration(milliseconds: 670),
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
                            const SizedBox(height: 10),
                            FadeInDown(
                              from: 25,
                              delay: const Duration(milliseconds: 710),
                              child: TextFieldForAll(
                                errorGetter:
                                    ErrorGetter().phoneNumberErrorGetter,
                                hintText: 'Email',
                                prefixIcon: const Icon(
                                  FontAwesomeIcons.solidEnvelopeOpen,
                                  color: Color(0xFF019aff),
                                  size: 20.0,
                                ),
                                textEditingController: emailController,
                                textInputType: TextInputType.emailAddress,
                              ),
                            ),
                            const SizedBox(height: 10),
                            FadeInDown(
                              from: 20,
                              delay: const Duration(milliseconds: 690),
                              child: TextFieldForAll(
                                errorGetter:
                                    ErrorGetter().phoneNumberErrorGetter,
                                hintText: 'Phone',
                                prefixIcon: const Icon(
                                  FontAwesomeIcons.phoneAlt,
                                  color: Color(0xFF019aff),
                                  size: 20.0,
                                ),
                                textEditingController: phoneNumberController,
                                textInputType: TextInputType.phone,
                              ),
                            ),
                            const SizedBox(height: 10),
                            FadeInDown(
                              from: 20,
                              delay: const Duration(milliseconds: 730),
                              child: CompanyTextAreaField(
                                errorGetter:
                                    ErrorGetter().companyDescriptionErrorGetter,
                                hintText: 'Send Feedback',
                                prefixIcon: const Icon(
                                  FontAwesomeIcons.solidCommentDots,
                                  color: Color(0xFF019aff),
                                  size: 20.0,
                                ),
                                textEditingController: descriptionController,
                              ),
                            ),
                            const SizedBox(height: 20),
                            FadeInUp(
                              from: 20,
                              duration: const Duration(milliseconds: 1200),
                              child: FormButtonWidget(
                                'SEND FEEDBACK',
                                () {
                                  validateAndSubmitQuery();
                                  // Navigator.of(context).pushNamed(RegistrationOTPScreen.routeName,arguments: false);
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              height: 10.0,
                              child: Center(
                                child: Container(
                                  margin: const EdgeInsetsDirectional.only(
                                    start: 1.0,
                                    end: 1.0,
                                  ),
                                  height: 2.0,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Center(
                              child: Text(
                                'PHONE:',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15.0,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                '+1 (000) 333 0000',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.0,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                            const SizedBox(height: 25),
                            Center(
                              child: Text(
                                'EMAIL:',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15.0,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'support@towrevo.com',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 15.0,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(height: 25),
                            Center(
                              child: Text(
                                'ADDRESS:',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15.0,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '92 Lorem simply street line New York, USA',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 15.0,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
