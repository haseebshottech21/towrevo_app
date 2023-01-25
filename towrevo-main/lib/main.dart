import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/screens/authentication/signup_company/signup_compnay_screen.dart';
import 'package:towrevo/screens/company/company_unverified_screen.dart';
import 'package:towrevo/screens/company/compnay_location_screen.dart';
import 'package:towrevo/screens/company/compnay_verification_form_screen.dart';
import 'package:towrevo/screens/delete_my_account.dart';
import 'package:towrevo/screens/payment/user_paymnets.dart';
import 'package:towrevo/screens/test_location.dart';
import 'package:towrevo/utilities/env_settings.dart';
import 'package:towrevo/utilities/utilities.dart';
import 'package:towrevo/view_model/delete_reason_view_model.dart';
import 'package:towrevo/view_model/view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'screens/screens.dart';

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.removeAfter(intialization);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await dotenv.load(fileName: ENVSettings.fileName);
  await Firebase.initializeApp();

  MyApp.onBoard =
      await Utilities().getSharedPreferenceValue('onboarding') ?? '0';
  MyApp.type = await Utilities().getSharedPreferenceValue('type') ?? '0';
  if (MyApp.onBoard == '0') {
    MyApp.onBoard = '0';
    await Utilities().setSharedPrefValue('onboarding', '1');
  }
  Stripe.publishableKey = ENVSettings.stripePublishableKey;
  try {
    if (Platform.isIOS) {
      Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
      // Stripe.merchantIdentifier = 'merchant.thegreatestmarkeplace';
      Stripe.urlScheme = 'flutterstripe';
      await Stripe.instance.applySettings();
    }
  } on StripeException catch (exception) {
    Fluttertoast.showToast(msg: exception.error.localizedMessage.toString());
  } catch (e) {
    Fluttertoast.showToast(msg: e.toString());
  }
  runApp(const MyApp());
}

Future intialization(BuildContext? context) async {
  await Future.delayed(const Duration(seconds: 2));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  static String notifyToken = '';
  static String onBoard = '';
  static String type = '';
  static bool updateChecker = false;

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
        // print('hey ${MyApp.notifyToken.toString()}');
      },
    ).catchError((e) {
      // print(e.toString());
    });
    super.initState();
    // appInfo();
    // _checkNewVersion();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      // minTextAdapt: true,
      // splitScreenMode: true,
      builder: (context, child) {
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
            ChangeNotifierProvider(
                create: (ctx) => CompanyHomeScreenViewModel()),
            ChangeNotifierProvider(create: (ctx) => EditProfileViewModel()),
            ChangeNotifierProvider(create: (ctx) => SplashViewModel()),
            ChangeNotifierProvider(create: (ctx) => PaymentViewModel()),
            ChangeNotifierProvider(create: (ctx) => DeleteViewModel()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Towrevo',
            // You can use the library anywhere in the app even in theme
            theme: ThemeData(
              primarySwatch: Colors.blue,
              bottomSheetTheme: const BottomSheetThemeData(
                backgroundColor: Colors.transparent,
              ),
            ),
            home: getScreen(),
            routes: {
              RegisterMainScreen.routeName: (ctx) => const RegisterMainScreen(),
              LoginScreen.routeName: (ctx) => const LoginScreen(),
              // RegistrationNameAndDescScreen.routeName: (ctx) =>
              //     const RegistrationNameAndDescScreen(),
              // RegistrationCredentialScreen.routeName: (ctx) =>
              //     const RegistrationCredentialScreen(),
              // RegisterationLocationAndState.routeName: (ctx) =>
              //     const RegisterationLocationAndState(),
              // RegisterationCompleteScreen.routeName: (ctx) =>
              //     const RegisterationCompleteScreen(),
              SignupCompanyScreen.routeName: (context) =>
                  const SignupCompanyScreen(),
              UserMonthlyPaymentScreen.routeName: (ctx) =>
                  const UserMonthlyPaymentScreen(),
              CompanyPaymentScreen.routeName: (ctx) =>
                  const CompanyPaymentScreen(),
              RegistrationOTPScreen.routeName: (ctx) =>
                  const RegistrationOTPScreen(),
              CompanyVerificationRequest.routeName: (ctx) =>
                  const CompanyVerificationRequest(),
              CompanyVerificationFormScreen.routeName: (ctx) =>
                  const CompanyVerificationFormScreen(),
              CompanyLocationScreen.routeName: (ctx) =>
                  const CompanyLocationScreen(),
              CompanyHomeScreen.routeName: (ctx) => const CompanyHomeScreen(),
              RegisterUserScreen.routeName: (ctx) => const RegisterUserScreen(),
              UsersHomeScreen.routeName: (ctx) => const UsersHomeScreen(),
              ListingOfCompaniesScreen.routeName: (ctx) =>
                  const ListingOfCompaniesScreen(),
              DistanceScreen.routeName: (ctx) => const DistanceScreen(),
              UserLocationScreen.routeName: (ctx) => const UserLocationScreen(),
              TestLocation.routeName: (ctx) => const TestLocation(),
              AboutUsScreen.routeName: (ctx) => const AboutUsScreen(),
              FAQs.routeName: (ctx) => const FAQs(),
              ChangePasswordScreen.routeName: (ctx) =>
                  const ChangePasswordScreen(),
              TermAndCondition.routeName: (ctx) => const TermAndCondition(),
              CompanyHistoryScreen.routeName: (ctx) =>
                  const CompanyHistoryScreen(),
              UserHistoryTow.routeName: (ctx) => const UserHistoryTow(),
              UserPaymnets.routeName: (ctx) => const UserPaymnets(),
              ForgotPasswordScreen.routeName: (ctx) =>
                  const ForgotPasswordScreen(),
              ForgotPasswordOTPScreen.routeName: (ctx) =>
                  const ForgotPasswordOTPScreen(),
              UpdateProfile.routeName: (ctx) => const UpdateProfile(),
              ContactUs.routeName: (ctx) => const ContactUs(),
              DeleteMyAccount.routeName: (ctx) => const DeleteMyAccount(),
            },
          ),
        );
      },
    );
  }

  Widget getScreen() {
    return MyApp.onBoard == '0'
        ? const OnBoardTowrevo()
        : MyApp.type == '1'
            ? const UsersHomeScreen()
            : MyApp.type == '2'
                ? const CompanyHomeScreen()
                : const WelcomeScreen();
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
