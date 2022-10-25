// import 'package:animate_do/animate_do.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:provider/provider.dart';
// import 'package:towrevo/error_getter.dart';
// import 'package:towrevo/screens/authentication/signup_company/registeration_location_statecity_screen.dart';
// import 'package:towrevo/view_model/view_model.dart';
// import 'package:towrevo/widgets/widgets.dart';
// import 'package:towrevo/screens/screens.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class RegistrationCredentialScreen extends StatefulWidget {
//   const RegistrationCredentialScreen({Key? key}) : super(key: key);

//   static const routeName = '/registration-credential';

//   @override
//   State<RegistrationCredentialScreen> createState() =>
//       _RegistrationCredentialScreenState();
// }

// class _RegistrationCredentialScreenState
//     extends State<RegistrationCredentialScreen> {
//   final emailController = TextEditingController();
//   final phoneNumberController = TextEditingController();
//   final passwordController = TextEditingController();
//   final confirmPasswordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();

//   void validateFromAndSaveData() {
//     final _companySignUpProvider =
//         Provider.of<RegisterCompanyViewModel>(context, listen: false);
//     if (!_formKey.currentState!.validate()) {
//       return;
//     } else {
//       _companySignUpProvider.body['email'] =
//           emailController.text.trim().toLowerCase();
//       _companySignUpProvider.body['phone'] = phoneNumberController.text.trim();
//       _companySignUpProvider.body['password'] = passwordController.text.trim();
//       _companySignUpProvider.body['password_confirmation'] =
//           confirmPasswordController.text.trim();
//       // print(_companySignUpProvider.body);
//       Navigator.of(context).pushNamed(RegisterationLocationAndState.routeName);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Stack(
//           children: [
//             const BackgroundImage(),
//             backIcon(context, () {
//               Navigator.pop(context);
//             }),
//             Container(
//               alignment: Alignment.center,
//               padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     SizedBox(height: 55.h),
//                     FadeInDown(
//                       from: 15,
//                       delay: const Duration(milliseconds: 500),
//                       child: const CompanySignUpTitle(),
//                     ),
//                     SizedBox(height: 40.h),
//                     SizedBox(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           FadeInDown(
//                             from: 20,
//                             delay: const Duration(milliseconds: 550),
//                             child: TextFieldForAll(
//                               errorGetter: ErrorGetter().emailErrorGetter,
//                               hintText: 'Email Address',
//                               prefixIcon: const Icon(
//                                 FontAwesomeIcons.solidEnvelopeOpen,
//                                 color: Color(0xFF019aff),
//                                 size: 20.0,
//                               ),
//                               textEditingController: emailController,
//                               textInputType: TextInputType.emailAddress,
//                             ),
//                           ),
//                           SizedBox(height: 8.h),
//                           FadeInDown(
//                             from: 25,
//                             delay: const Duration(milliseconds: 570),
//                             child: PhoneField(
//                               errorGetter: ErrorGetter().phoneNumberErrorGetter,
//                               hintText: 'Phone Number',
//                               textEditingController: phoneNumberController,
//                             ),
//                           ),
//                           SizedBox(height: 8.h),
//                           Consumer<RegisterCompanyViewModel>(
//                             builder: (ctx, registerCompanyViewModel,
//                                 neverBuildChild) {
//                               return FadeInDown(
//                                 from: 30,
//                                 delay: const Duration(milliseconds: 590),
//                                 child: TextFormIconWidget(
//                                   errorGetter:
//                                       ErrorGetter().passwordErrorGetter,
//                                   textEditingController: passwordController,
//                                   obscureText:
//                                       registerCompanyViewModel.obscurePassword,
//                                   hint: 'Password',
//                                   prefixIcon: const Icon(
//                                       FontAwesomeIcons.qrcode,
//                                       color: Color(0xFF019aff),
//                                       size: 20.0),
//                                   onPress:
//                                       registerCompanyViewModel.toggleObscure,
//                                 ),
//                               );
//                             },
//                           ),
//                           SizedBox(height: 8.h),
//                           Consumer<RegisterCompanyViewModel>(builder:
//                               (ctx, registerUserViewModel, neverBuildChild) {
//                             return FadeInDown(
//                               from: 35,
//                               delay: const Duration(milliseconds: 610),
//                               child: TextFormIconWidget(
//                                 confirmPassword: passwordController,
//                                 errorGetter:
//                                     ErrorGetter().confirmPasswordErrorGetter,
//                                 textEditingController:
//                                     confirmPasswordController,
//                                 obscureText: registerUserViewModel
//                                     .obscureConfirmPassword,
//                                 hint: 'Confirm Password',
//                                 prefixIcon: const Icon(FontAwesomeIcons.qrcode,
//                                     color: Color(0xFF019aff), size: 20.0),
//                                 onPress:
//                                     registerUserViewModel.toggleObscureConfirm,
//                               ),
//                             );
//                           }),
//                         ],
//                       ),
//                     ),
//                     FadeInDown(
//                       from: 35,
//                       delay: const Duration(milliseconds: 650),
//                       child: Container(
//                         margin: EdgeInsets.only(top: 40.h),
//                         padding: EdgeInsets.symmetric(horizontal: 8.w),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             StepFormButtonBack(
//                               () {
//                                 Navigator.of(context).pop();
//                               },
//                               'BACK',
//                             ),
//                             StepFormButtonNext(
//                               onPressed: () {
//                                 validateFromAndSaveData();
//                               },
//                               text: 'NEXT',
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
