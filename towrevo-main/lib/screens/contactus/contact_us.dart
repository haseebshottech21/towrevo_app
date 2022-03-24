import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/error_getter.dart';
import 'package:towrevo/utitlites/utilities.dart';
import 'package:towrevo/view_model/view_model.dart';
import 'package:towrevo/widgets/widgets.dart';
import '../../../utitlites/towrevo_appcolor.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);
  static const routeName = '/contact-us';

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final descriptionController = TextEditingController();
  final emailController = TextEditingController();
  final fullNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  validateAndSubmitQuery() async {
    if (!_formKey.currentState!.validate()) {
      return;
    } else {
      print('in');
      final splashViewModel =
          Provider.of<SplashViewModel>(context, listen: false);
      bool success =
          await splashViewModel.contactUs(descriptionController.text.trim());
      if (success) {
        descriptionController.text = '';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: scaffoldKey,
      // drawerEnableOpenDragGesture: false,
      // drawer: const DrawerWidget(),
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
                                'PLEASE FILL THIS FORM!',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18.0,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            FadeInDown(
                              from: 15,
                              delay: const Duration(milliseconds: 670),
                              child: TextFieldForAll(
                                errorGetter: (val) {},
                                hintText: 'Full Name',
                                prefixIcon: const Icon(
                                  FontAwesomeIcons.userAlt,
                                  color: Color(0xFF019aff),
                                  size: 20.0,
                                ),
                                textEditingController: fullNameController,
                                textInputType: TextInputType.name,
                              ),
                            ),
                            const SizedBox(height: 10),
                            FadeInDown(
                              from: 25,
                              delay: const Duration(milliseconds: 710),
                              child: TextFieldForAll(
                                errorGetter: ErrorGetter().emailErrorGetter,
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
                              delay: const Duration(milliseconds: 730),
                              child: CompanyTextAreaField(
                                errorGetter: ErrorGetter().feedbackErrorGetter,
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
                            Consumer<SplashViewModel>(builder:
                                (ctx, contactUsViewModel, neverUpdate) {
                              return contactUsViewModel.type == '2'
                                  ? Column(
                                      children: [
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
                                            color: AppColors.primaryColor
                                                .withOpacity(0.6),
                                            borderRadius:
                                                BorderRadius.circular(30),
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
                                      ],
                                    )
                                  : const SizedBox();
                            }),
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

  @override
  void initState() {
    setUpFields();

    Provider.of<SplashViewModel>(context, listen: false).getType();
    super.initState();
  }

  setUpFields() async {
    final utility = Utilities();
    emailController.text = await utility.getSharedPreferenceValue('email');
    fullNameController.text = await utility.getSharedPreferenceValue('name');
  }
}
