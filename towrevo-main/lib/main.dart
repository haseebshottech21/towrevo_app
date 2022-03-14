import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/utitlites/utilities.dart';
import 'package:towrevo/view_model/view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'screens/screens.dart';

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
          UserMonthlyPaymentScreen.routeName: (ctx) =>
              const UserMonthlyPaymentScreen(),
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
          // MapDistanceScreen.routeName: (ctx) => const MapDistanceScreen(),
          AboutUsScreen.routeName: (ctx) => const AboutUsScreen(),
          FAQs.routeName: (ctx) => const FAQs(),
          ChangePasswordScreen.routeName: (ctx) => const ChangePasswordScreen(),
          TermAndCondition.routeName: (ctx) => const TermAndCondition(),
          CompanyHistoryScreen.routeName: (ctx) => const CompanyHistoryScreen(),
          UserHistoryTow.routeName: (ctx) => const UserHistoryTow(),
          ForgotPasswordScreen.routeName: (ctx) => const ForgotPasswordScreen(),
          ForgotPasswordOTPScreen.routeName: (ctx) =>
              const ForgotPasswordOTPScreen(),
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
