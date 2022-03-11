import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:towrevo/view_model/user_home_screen_view_model.dart';
import 'package:towrevo/widgets/back_icon.dart';
import 'package:towrevo/widgets/full_background_image.dart';
import 'package:towrevo/widgets/payment_detail.dart';
import '../../utitlites/towrevo_appcolor.dart';
import '../../utitlites/utilities.dart';
import 'package:http/http.dart' as http;

class UserMonthlyPaymentScreen extends StatefulWidget {
  const UserMonthlyPaymentScreen({Key? key}) : super(key: key);
  static const routeName = '/registration-payment-screen';

  @override
  State<UserMonthlyPaymentScreen> createState() => _UserMonthlyPaymentScreenState();
}

class _UserMonthlyPaymentScreenState extends State<UserMonthlyPaymentScreen> {
  Map<String, dynamic> paymentIntentData = {};

  paynow(BuildContext context) async {
    final userViewModel =
        Provider.of<UserHomeScreenViewModel>(context, listen: false);
    await userViewModel.payNow(paymentIntentData['id'], '2', context);
    paymentIntentData = {};
    // if (response) {
    //   Navigator.of(context)
    //       .pushNamed(RegistrationOTPScreen.routeName, arguments: true);
    // }
  }

  displayPaymentSheet(BuildContext context) async {
    try {
      await Stripe.instance.presentPaymentSheet(
        parameters: PresentPaymentSheetParameters(
          clientSecret: paymentIntentData['client_secret'],
          confirmPayment: true,
        ),
      );
      // print(a);

      paynow(context);
    } on StripeException catch (e) {
      Utilities().showToast('Cancel');
      print(e);
    }
  }

  Future<void> makePayment(BuildContext context) async {
    try {
      paymentIntentData =
          await createPaymentIntent(currencyType: 'USD', price: '199');
      print('make payment $paymentIntentData');

      if (paymentIntentData.isNotEmpty) {
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntentData['client_secret'],
            applePay: true,
            googlePay: true,
            merchantCountryCode: 'US',
            style: ThemeMode.dark,
            merchantDisplayName:
                Provider.of<UserHomeScreenViewModel>(context, listen: false)
                    .drawerInfo['name']
                    .toString(),
          ),
        );

        displayPaymentSheet(context);
      }
    } catch (e) {
      print(e);
    }
  }

  Future createPaymentIntent(
      {required String price, required String currencyType}) async {
    print('in createPaymentIntent');
    try {
      Map<String, dynamic> body = {
        'amount': price,
        'currency': currencyType,
        'payment_method_types[]': 'card'
      };

      final response = await http.post(
          Uri.parse('${Utilities.stripeBaseUrl}/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51IdtHCGmNbFgnn002634Wne6qPdy0KfZyH19qLIq7SCFxNdWygtpxUc0d9VFQs55dlWs2sAp5O565RdTYfMpe0Op00fMGUCof1',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      return jsonDecode(response.body);
    } catch (e) {
      Utilities().showToast('Something Went Wrong');
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final utlities = Utilities();
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            const FullBackgroundImage(),
            Column(
              children: [
                Row(
                  children: [
                    backIcon(context, () {
                      Navigator.of(context).pop();
                    }),
                  ],
                ),
              ],
            ),
            Container(
              alignment: Alignment.center,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  Text(
                    'PAY AS YOU GO',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 28.0,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: InkWell(
                      onTap: () async {
                        if (!(await Utilities().isInternetAvailable())) {
                          return;
                        }
                        await makePayment(context);
                        // Navigator.of(context).pushNamed(RegistrationOTPScreen.routeName,arguments: true);
                      },
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            stops: [0.1, 0.7],
                            colors: [
                              Color(0xFF0195f7),
                              Color(0xFF083054),
                            ],
                          ),
                          // color: Colors.deepPurple.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(
                              Icons.payment,
                              color: Colors.white,
                              size: 25,
                            ),
                            Text(
                              'PURCHASE NOW',
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              '\$ 1.99',
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Get access to all premium services for \$1.99 which expires after 30 days and doesn\'t renew automatically',
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        paymentDetail(
                            'See multiple Towing company name and phone number'),
                        const SizedBox(height: 10),
                        paymentDetail(
                            'Send your address with push request button'),
                        const SizedBox(height: 10),
                        paymentDetail('Find best offers'),
                        const SizedBox(height: 10),
                        paymentDetail('Find Towing service 24/7'),
                        const SizedBox(height: 12),
                        // paymentDetail('Long-distance and local towing'),
                        // const SizedBox(height: 8),
                        // paymentDetail('Towing services on a 24/7 basis'),
                        // const SizedBox(height: 8),
                        // paymentDetail('See availability offline or online'),
                        // const SizedBox(height: 8),
                        // paymentDetail('Truck Towing'),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Text(
                            'Much more benefit...',
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    Provider.of<UserHomeScreenViewModel>(context, listen: false)
        .updateDrawerInfo();
    super.initState();
  }
}
