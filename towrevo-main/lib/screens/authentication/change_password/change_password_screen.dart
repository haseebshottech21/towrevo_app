import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/error_getter.dart';
import 'package:towrevo/view_model/view_model.dart';
import 'package:towrevo/widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const routeName = '/change-password';
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final passwordController = TextEditingController();
  final confirmPassword = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  validateAndChangePassword(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      return;
    } else {
      final provider =
          Provider.of<EditProfileViewModel>(context, listen: false);

      provider.changePassword(
        passwordController.text.trim(),
        confirmPassword.text.trim(),
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            const FullBackgroundImage(),
            Align(
              alignment: Alignment.topLeft,
              child: backIcon(context, () {
                Navigator.of(context).pop();
              }),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 30.h,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 10.h),
                    const TowrevoLogo(),
                    SizedBox(height: 45.h),
                    Text(
                      'CREATE NEW PASSWORD',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 25.0,
                        letterSpacing: 1,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Your new password must be different from previous password',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        color: const Color(0xFF0c355a),
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(height: 25.h),
                    TextFormIconWidget(
                      errorGetter: ErrorGetter().passwordErrorGetter,
                      textEditingController: passwordController,
                      obscureText: true,
                      hint: 'Password',
                      prefixIcon: const Icon(
                        FontAwesomeIcons.qrcode,
                        color: Color(0xFF019aff),
                        size: 20,
                      ),
                      onPress: () {},
                    ),
                    SizedBox(height: 6.h),
                    TextFormIconWidget(
                      errorGetter: ErrorGetter().confirmPasswordErrorGetter,
                      confirmPassword: passwordController,
                      textEditingController: confirmPassword,
                      obscureText: true,
                      hint: 'Confirm Password',
                      prefixIcon: const Icon(
                        FontAwesomeIcons.qrcode,
                        color: Color(0xFF019aff),
                        size: 20.0,
                      ),
                      onPress: () {},
                    ),
                    SizedBox(height: 35.h),
                    Center(
                      child: InkWell(
                        onTap: () {
                          validateAndChangePassword(context);
                        },
                        child: Container(
                          height: 40.h,
                          width: ScreenUtil().screenWidth * 0.85,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.r),
                            gradient: const LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xFF0195f7),
                                Color(0xFF083054),
                              ],
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'RESET PASSWORD',
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 17.sp,
                                letterSpacing: 0.5.w,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
