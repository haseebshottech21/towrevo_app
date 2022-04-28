import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/error_getter.dart';
import 'package:towrevo/utilities/utilities.dart';
import 'package:towrevo/view_model/view_model.dart';
import 'package:towrevo/widgets/widgets.dart';
import '../../../utilities/towrevo_appcolor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      // print('in');
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
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      // key: scaffoldKey,
      // drawerEnableOpenDragGesture: false,
      // drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        child: SizedBox(
          height: ScreenUtil().screenHeight,
          width: ScreenUtil().screenWidth,
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
                          margin: EdgeInsets.only(
                            top: 32.h,
                            left: Platform.isAndroid
                                ? screenSize.width * 0.10.w
                                : 50.w,
                          ),
                          child: Text(
                            'CONTACT US',
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
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 10.h),
                            const TowrevoLogoSmall(),
                            SizedBox(height: 15.h),
                            Center(
                              child: Text(
                                'PLEASE FILL THIS FORM!',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.sp,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                            SizedBox(height: 12.h),
                            FadeInDown(
                              from: 15,
                              delay: const Duration(milliseconds: 670),
                              child: TextFieldForAll(
                                errorGetter: (val) {},
                                hintText: 'Full Name',
                                prefixIcon: const Icon(
                                  FontAwesomeIcons.userAlt,
                                  color: Color(0xFF019aff),
                                  size: 20,
                                ),
                                textEditingController: fullNameController,
                                textInputType: TextInputType.name,
                              ),
                            ),
                            SizedBox(height: 6.h),
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
                            SizedBox(height: 6.h),
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
                            SizedBox(height: 15.h),
                            FadeInUp(
                              from: 20,
                              duration: const Duration(milliseconds: 1200),
                              child: FormButtonWidget(
                                formBtnTxt: 'SEND FEEDBACK',
                                onPressed: () {
                                  validateAndSubmitQuery();
                                },
                              ),
                            ),
                            SizedBox(height: 18.h),
                            SizedBox(
                              height: 10.h,
                              child: Center(
                                child: Container(
                                  margin: const EdgeInsetsDirectional.only(
                                    start: 1.0,
                                    end: 1.0,
                                  ),
                                  height: 1.5.h,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h),
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
                                              fontSize: 14.sp,
                                              letterSpacing: 0.5.w,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 5.h),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 15.w,
                                            vertical: 5.h,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.primaryColor
                                                .withOpacity(0.6),
                                            borderRadius:
                                                BorderRadius.circular(30.r),
                                          ),
                                          child: Text(
                                            '+1 (480) 406 5057',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.montserrat(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13.sp,
                                              letterSpacing: 0.5.w,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 22.h),
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
                                  fontSize: 14.sp,
                                  letterSpacing: 0.5.w,
                                ),
                              ),
                            ),
                            SizedBox(height: 5.h),
                            Text(
                              'support@towrevo.com',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 13.sp,
                                letterSpacing: 0.5.w,
                              ),
                            ),
                            SizedBox(height: 22.h),
                            Center(
                              child: Text(
                                'ADDRESS:',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp,
                                  letterSpacing: 0.5.w,
                                ),
                              ),
                            ),
                            SizedBox(height: 5.h),
                            Text(
                              '711 West 43rd st Chicago IL 60609',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 13.sp,
                                letterSpacing: 0.5.w,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 50.h),
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
