import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:towrevo/widgets/widgets.dart';
import 'package:towrevo/screens/screens.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterMainScreen extends StatelessWidget {
  static const routeName = '/register-main-screen';
  const RegisterMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Background Image
            const BackgroundImage(),
            // Back Icon
            backIcon(context, () {
              Navigator.pop(context);
            }),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0.w,
                vertical: 30.0.h,
              ),
              child: Column(
                children: [
                  SizedBox(height: 5.h),
                  FadeInDown(
                    from: 50,
                    delay: const Duration(milliseconds: 400),
                    child: const TowrevoLogo(),
                  ),
                  SizedBox(height: 35.h),
                  FadeInDown(
                    from: 15,
                    delay: const Duration(milliseconds: 500),
                    child: Text(
                      'REGISTER AS',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 28.sp,
                        letterSpacing: 1.w,
                      ),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  FadeInDown(
                    from: 20,
                    delay: const Duration(milliseconds: 550),
                    child: Text(
                      'Kindly Select One Option From The Following Before Registering',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        color: const Color(0xFF0c355a),
                        fontWeight: FontWeight.w600,
                        fontSize: 12.0.sp,
                        letterSpacing: 0.5.w,
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  FadeInUp(
                    from: 10,
                    delay: const Duration(milliseconds: 500),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                RegistrationNameAndDescScreen.routeName);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(18.r),
                                bottomRight: Radius.circular(18.r),
                              ),
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                stops: [0.0, 1.0],
                                colors: [
                                  Color(0xFF083258),
                                  Color(0xFF0190ef),
                                ],
                              ),
                            ),
                            child: SizedBox(
                              width: 155.w,
                              height: 190.h,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.building,
                                    color: Colors.white,
                                    size: 75.sp,
                                  ),
                                  SizedBox(height: 30.h),
                                  Text(
                                    'REGISTERED BY',
                                    style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 9.sp,
                                    ),
                                  ),
                                  SizedBox(height: 2.h),
                                  Text(
                                    'TOWING \nCOMPANY',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.sp,
                                      letterSpacing: 1.w,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(RegisterUserScreen.routeName);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.brown,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(18.r),
                                topRight: Radius.circular(18.r),
                              ),
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                stops: [0.0, 1.0],
                                colors: [
                                  Color(0xFF083258),
                                  Color(0xFF0190ef),
                                ],
                              ),
                            ),
                            child: SizedBox(
                              width: 155.w,
                              height: 190.h,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.user,
                                    color: Colors.white,
                                    size: 75.sp,
                                  ),
                                  SizedBox(height: 35.h),
                                  Text(
                                    'REGISTERED BY',
                                    style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 9.sp,
                                    ),
                                  ),
                                  SizedBox(height: 2.h),
                                  Text(
                                    'USER',
                                    style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18.sp,
                                      letterSpacing: 1.w,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
