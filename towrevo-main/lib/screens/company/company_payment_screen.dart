import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/utitlites/utilities.dart';
import 'package:towrevo/view_model/view_model.dart';
import 'package:towrevo/widgets/widgets.dart';
import 'package:http/http.dart' as http;
import '../../utitlites/towrevo_appcolor.dart';

class CompanyPaymentScreen extends StatefulWidget {
  const CompanyPaymentScreen({Key? key}) : super(key: key);

  static const routeName = '/company-payment';

  @override
  _CompanyPaymentScreenState createState() => _CompanyPaymentScreenState();
}

class _CompanyPaymentScreenState extends State<CompanyPaymentScreen> {
  Map<String, dynamic> paymentIntentData = {};

  paynow(BuildContext context) async {
    final companyViewModel =
        Provider.of<CompanyHomeScreenViewModel>(context, listen: false);
    await companyViewModel.payNow(paymentIntentData['id'], '20', context);
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
      Utilities().showToast('${e.error.localizedMessage}');
      print(e);
    }
  }

  Future<void> makePayment(BuildContext context) async {
    try {
      paymentIntentData =
          await createPaymentIntent(currencyType: 'USD', price: '2000');
      print(
        'yes iam ' +
            Provider.of<UserHomeScreenViewModel>(context, listen: false)
                .drawerInfo['name']
                .toString(),
      );
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

      print(body);

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
                    // const SizedBox(
                    //   width: 20,
                    // ),
                    // const Padding(
                    //   padding: EdgeInsets.only(top: 40),
                    //   child: Text(
                    //     'Near By Companies',
                    //     style: TextStyle(
                    //       color: Colors.white,
                    //       fontWeight: FontWeight.w500,
                    //       fontSize: 22.0,
                    //     ),
                    //   ),
                    // )
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
                    'MONTHLY SUBSCRIBTION',
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
                              'SUBSCRIBE NOW',
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              '\$ 19.95',
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
                    'Get access to all premium services, features and support',
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
                        paymentDetail('Unlimited jobs'),
                        const SizedBox(height: 10),
                        paymentDetail('No commission fee'),
                        const SizedBox(height: 10),
                        paymentDetail('Set your work schedule'),
                        const SizedBox(height: 10),
                        paymentDetail('Avoid fake customers'),
                        const SizedBox(height: 10),
                        paymentDetail('Accept and decline jobs'),
                        const SizedBox(height: 10),
                        paymentDetail('Reduce time wasting by customers'),
                        const SizedBox(height: 10),
                        paymentDetail(
                            'Connect you millions of Android or iOS users'),
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
}
