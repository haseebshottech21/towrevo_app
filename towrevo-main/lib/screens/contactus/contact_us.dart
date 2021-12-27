import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:towrevo/error_getter.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawerEnableOpenDragGesture: false,
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            const SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: FullBackgroundImage(),
            ),
            drawerIconSecond(
              context,
              () {
                scaffoldKey.currentState!.openDrawer();
              },
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 30.0,
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  const TowrevoLogo(),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'CONTACT US',
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 25.0,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
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
                    ),
                  ),
                  const SizedBox(height: 10),
                  FadeInDown(
                    from: 25,
                    delay: const Duration(milliseconds: 710),
                    child: TextFieldForAll(
                      errorGetter: ErrorGetter().phoneNumberErrorGetter,
                      hintText: 'Email',
                      prefixIcon: const Icon(
                        FontAwesomeIcons.solidEnvelopeOpen,
                        color: Color(0xFF019aff),
                        size: 20.0,
                      ),
                      textEditingController: emailController,
                    ),
                  ),
                  const SizedBox(height: 10),
                  FadeInDown(
                    from: 20,
                    delay: const Duration(milliseconds: 690),
                    child: TextFieldForAll(
                      errorGetter: ErrorGetter().phoneNumberErrorGetter,
                      hintText: 'Phone',
                      prefixIcon: const Icon(
                        FontAwesomeIcons.phoneAlt,
                        color: Color(0xFF019aff),
                        size: 20.0,
                      ),
                      textEditingController: phoneNumberController,
                    ),
                  ),
                  const SizedBox(height: 10),
                  FadeInDown(
                    from: 20,
                    delay: const Duration(milliseconds: 730),
                    child: CompanyTextAreaField(
                      errorGetter: ErrorGetter().companyDescriptionErrorGetter,
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
                        // Navigator.of(context).pushNamed(RegistrationOTPScreen.routeName,arguments: false);
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
