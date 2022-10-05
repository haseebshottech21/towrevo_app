import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utilities/towrevo_appcolor.dart';
import '../../widgets/back_icon.dart';
import '../../widgets/background_image.dart';
import 'compnay_verification_form_screen.dart';

class CompanyVerificationRequest extends StatelessWidget {
  const CompanyVerificationRequest({Key? key}) : super(key: key);

  static const routeName = '/company-verification-request';

  @override
  Widget build(BuildContext context) {
    String statusCode = ModalRoute.of(context)!.settings.arguments as String;
    // print(statusCode);
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            const BackgroundImage(),
            Row(
              children: [
                backIcon(context, () {
                  Navigator.of(context).pop();
                }),
              ],
            ),
            statusCode == '3'
                ? SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 130.h),
                        Text(
                          'VERIFICATION PROCESS',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 26.0,
                            letterSpacing: 1.5,
                          ),
                        ),
                        SizedBox(height: 70.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 15.h),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Text(
                              'Your Request is in Under Process Please wait for verification',
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 130.h),
                        Text(
                          'COMPLETE YOUR VERIFICATION',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 26.0,
                            letterSpacing: 1.5,
                          ),
                        ),
                        SizedBox(height: 70.h),
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 12.w,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Please Verified Your Company \nFirst For Towing User Jobs',
                                style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 30.h),
                              OutlinedButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    CompanyVerificationFormScreen.routeName,
                                  );
                                },
                                child: Text(
                                  'START',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                style: OutlinedButton.styleFrom(
                                  minimumSize: Size(260.w, 40.h),
                                  side: const BorderSide(
                                    width: 1.0,
                                    color: Colors.white,
                                  ),
                                ),
                              )
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
