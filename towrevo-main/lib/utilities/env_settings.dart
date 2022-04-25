// import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ENVSettings {
  static String get mapAPIKey => 'AIzaSyBgeFPOQMiMVVrElHYD5l5YSCmNlu8QFXI';
  static String get fcmKey => dotenv.env['FCM_KEY'] ?? '';
  static String get stripePublishableKey =>
      dotenv.env['STRIPE_PUBLISHABLE_KEY'] ?? '';
  static String get stripeSecretKey => dotenv.env['STRIPE_SECRET_KEY'] ?? '';
  static String get fileName => '.env.production';
}
