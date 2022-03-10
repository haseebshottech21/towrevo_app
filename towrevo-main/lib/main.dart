import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/screens/aboutus/about_us_screen.dart';
import 'package:towrevo/screens/authentication/change_password/change_password.dart';
import 'package:towrevo/screens/authentication/forgot_password/forgot_password.dart';
import 'package:towrevo/screens/authentication/forgot_password/forgot_password_otp.dart';
import 'package:towrevo/screens/company/company_payment_screen.dart';
import 'package:towrevo/screens/company/distance_screen.dart';
import 'package:towrevo/screens/contactus/contact_us.dart';
import 'package:towrevo/screens/faqs/faqs.dart';
import 'package:towrevo/screens/company/company_history.dart';
import 'package:towrevo/screens/map_distance_screen.dart';
import 'package:towrevo/screens/profile/update_profile.dart';
import 'package:towrevo/screens/term&condiotion/term&conditon_screen.dart';
import 'package:towrevo/screens/users/user_history_tow.dart';
import 'package:towrevo/screens/users/user_location_screen.dart';
import 'package:towrevo/utilities.dart';
import 'package:towrevo/view_model/company_home_screen_view_model.dart';
import 'package:towrevo/view_model/edit_profile_view_model.dart';
import 'package:towrevo/view_model/splash_view_model.dart';
import 'package:towrevo/view_model/user_home_screen_view_model.dart';
import 'package:towrevo/view_model/otp_view_model.dart';
import 'package:towrevo/view_model/get_location_view_model.dart';
import 'package:towrevo/view_model/login_view_model.dart';
import 'package:towrevo/view_model/register_company_view_model.dart';
import 'package:towrevo/view_model/register_user_view_model.dart';
import 'package:towrevo/view_model/services_and_day_view_model.dart';
import 'screens/users/listing_of_companies_screen.dart';
import '/screens/users/users_home_screen.dart';
import 'screens/authentication/signup_user/register_user_screen.dart';
import '/screens/authentication/signup_company/registration_category_and_timing_screen.dart';
import '/screens/authentication/signup_company/registration_crediential_screen.dart';
import '/screens/authentication/signup_company/registration_name_and_desc_screen.dart';
import '/screens/authentication/signup_company/registration_otp_screen.dart';
import 'screens/monthly_payment_screen.dart';
import '/screens/company/company_home_screen.dart';
import '/screens/authentication/login/login_screen.dart';
import '/screens/authentication/register_main_screen.dart';
import '/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var onBoarding =
      await Utilities().getSharedPreferenceValue('onboarding') ?? '0';
  if (onBoarding == '0') {
    MyApp.onBoard = '0';
    await Utilities().setSharedPrefValue('onboarding', '1');
  }
  Stripe.publishableKey =
      'pk_test_51IdtHCGmNbFgnn00GS9N3SgfZldmDiOvK5WbKahPhImD2ThfzRqUKTMYG3i4xwTcphNBUb9FfeQFmBK37t3h4Ewh00JnMUB9Ul';
  Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  Stripe.urlScheme = 'flutterstripe';
  await Stripe.instance.applySettings();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  static String notifyToken = '';
  static String onBoard = '';

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late FirebaseMessaging messaging;

  @override
  void initState() {
    messaging = FirebaseMessaging.instance;
    messaging.getToken().then(
      (value) {
        MyApp.notifyToken = value.toString();
      },
    );

    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => RegisterCompanyViewModel()),
        ChangeNotifierProvider(create: (ctx) => RegisterUserViewModel()),
        ChangeNotifierProvider(create: (ctx) => LoginViewModel()),
        ChangeNotifierProvider(create: (ctx) => GetLocationViewModel()),
        ChangeNotifierProvider(create: (ctx) => ServicesAndDaysViewModel()),
        ChangeNotifierProvider(create: (ctx) => ServicesAndDaysViewModel()),
        ChangeNotifierProvider(create: (ctx) => OTPViewModel()),
        ChangeNotifierProvider(create: (ctx) => UserHomeScreenViewModel()),
        ChangeNotifierProvider(create: (ctx) => CompanyHomeScreenViewModel()),
        ChangeNotifierProvider(create: (ctx) => EditProfileViewModel()),
        ChangeNotifierProvider(create: (ctx) => SplashViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Towrevo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
        // home: const NumberField(),

        // home: const CompanyHomeScreen(),
        routes: {
          RegisterMainScreen.routeName: (ctx) => const RegisterMainScreen(),
          LoginScreen.routeName: (ctx) => const LoginScreen(),
          RegistrationNameAndDescScreen.routeName: (ctx) =>
              const RegistrationNameAndDescScreen(),
          RegistrationCredentialScreen.routeName: (ctx) =>
              const RegistrationCredentialScreen(),
          RegistrationCategoryAndTimingScreen.routeName: (ctx) =>
              const RegistrationCategoryAndTimingScreen(),
          MonthlyPaymentScreen.routeName: (ctx) => const MonthlyPaymentScreen(),
          CompanyPaymentScreen.routeName: (ctx) => const CompanyPaymentScreen(),
          RegistrationOTPScreen.routeName: (ctx) =>
              const RegistrationOTPScreen(),
          CompanyHomeScreen.routeName: (ctx) => const CompanyHomeScreen(),
          RegisterUserScreen.routeName: (ctx) => const RegisterUserScreen(),
          UsersHomeScreen.routeName: (ctx) => const UsersHomeScreen(),
          ListingOfCompaniesScreen.routeName: (ctx) =>
              const ListingOfCompaniesScreen(),
          // GetLocationScreen.routeName: (ctx) => const GetLocationScreen(),
          DistanceScreen.routeName: (ctx) => const DistanceScreen(),
          UserLocationScreen.routeName: (ctx) => const UserLocationScreen(),
          MapDistanceScreen.routeName: (ctx) => const MapDistanceScreen(),
          AboutUs.routeName: (ctx) => const AboutUs(),
          FAQs.routeName: (ctx) => const FAQs(),
          ChangePassword.routeName: (ctx) => const ChangePassword(),
          TermAndCondition.routeName: (ctx) => const TermAndCondition(),
          CompanyHistory.routeName: (ctx) => const CompanyHistory(),
          UserHistoryTow.routeName: (ctx) => const UserHistoryTow(),
          ForgotPassword.routeName: (ctx) => const ForgotPassword(),
          ForgotPasswordOTP.routeName: (ctx) => const ForgotPasswordOTP(),
          UpdateProfile.routeName: (ctx) => const UpdateProfile(),
          ContactUs.routeName: (ctx) => const ContactUs(),
        },
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
