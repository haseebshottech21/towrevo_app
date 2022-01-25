import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:towrevo/view_model/user_home_screen_view_model.dart';
import 'package:towrevo/widgets/back_icon.dart';
import 'package:towrevo/widgets/full_background_image.dart';
import '/utilities.dart';

import '/widgets/form_button_widget.dart';
import 'package:http/http.dart' as http;

class MonthlyPaymentScreen extends StatefulWidget {
  const MonthlyPaymentScreen({Key? key}) : super(key: key);
  static const routeName = '/registration-payment-screen';

  @override
  State<MonthlyPaymentScreen> createState() => _MonthlyPaymentScreenState();
}

class _MonthlyPaymentScreenState extends State<MonthlyPaymentScreen> {
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
          await createPaymentIntent(currencyType: 'USD', price: '200');
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
            // Padding(
            //   padding: const EdgeInsets.only(left: 10.0, top: 15.0),
            //   child: IconButton(
            //     icon: const Icon(FontAwesomeIcons.arrowLeft,
            //         color: Colors.white, size: 20.0),
            //     onPressed: () {
            //       Navigator.pop(context);
            //     },
            //   ),
            // ),
            Container(
              alignment: Alignment.center,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Column(children: [
                const SizedBox(
                  height: 60,
                ),
                Text(
                  'PAYMENT SUBSCRIBTION',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 30.0,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 10.0,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      FadeInUp(
                        duration: const Duration(milliseconds: 600),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15.0,
                            vertical: 10.0,
                          ),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.40,
                          decoration: BoxDecoration(
                            color: const Color(0xFF092848).withOpacity(0.6),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // paymentDetail(
                                //   'Name :',
                                //   utlities.getSharedPreferenceValue('email'),
                                // ),
                                // const SizedBox(height: 3),
                                // const Divider(
                                //   color: Colors.white,
                                // ),
                                const SizedBox(height: 3),
                                Consumer<UserHomeScreenViewModel>(
                                  builder:
                                      (ctx, userHomeViewModel, neverUpdate) {
                                    return Column(
                                      children: [
                                        paymentDetail(
                                          'Email :',
                                          userHomeViewModel.drawerInfo['email']
                                              .toString(),
                                        ),
                                        const SizedBox(height: 3),
                                        const Divider(
                                          color: Colors.white,
                                        ),
                                        const SizedBox(height: 3),
                                        paymentDetail(
                                          'Name :',
                                          userHomeViewModel.drawerInfo['name']
                                              .toString(),
                                        ),
                                      ],
                                    );
                                  },
                                ),

                                // const SizedBox(height: 3),
                                // const Divider(
                                //   color: Colors.white,
                                // ),
                                // const SizedBox(height: 3),
                                const Spacer(),
                                payment(
                                  'Total Pay :',
                                  '\$ 2.00',
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      StepFormButtonNext(
                        () async {
                          if (!(await Utilities().isInternetAvailable())) {
                            return;
                          }
                          await makePayment(context);
                          // Navigator.of(context).pushNamed(RegistrationOTPScreen.routeName,arguments: true);
                        },
                        'PAY',
                      ),
                    ],
                  ),
                ),
              ]),
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

Row paymentDetail(String title, String description) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ),
      Text(
        description,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ),
    ],
  );
}

Row payment(String title, String description) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 17,
        ),
      ),
      Text(
        description,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
    ],
  );
}
