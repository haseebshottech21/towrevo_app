import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/screens/authentication/signup_company/registration_otp_screen.dart';
import '/utilities.dart';
import '/view_model/register_company_view_model.dart';
import '/widgets/form_button_widget.dart';
import '/widgets/background_image.dart';
import 'package:http/http.dart' as http;

class RegistrationPaymentScreen extends StatelessWidget {
  RegistrationPaymentScreen({Key? key}) : super(key: key);
  static const routeName = '/registration-payment-screen';

  Map<String, dynamic> paymentIntentData = {};

  sendRegistrationRequest(BuildContext context) async {
    final registerProvider =
        Provider.of<RegisterCompanyViewModel>(context, listen: false);
    bool response = await registerProvider.registerCompany(context);
    if (response) {
      Navigator.of(context)
          .pushNamed(RegistrationOTPScreen.routeName, arguments: true);
    }
  }

  displayPaymentSheet(BuildContext context) async {
    try {
      await Stripe.instance.presentPaymentSheet(
          parameters: PresentPaymentSheetParameters(
              clientSecret: paymentIntentData['client_secret'],
              confirmPayment: true));
      // print(a);

      paymentIntentData = {};
      sendRegistrationRequest(context);
    } on StripeException catch (e) {
      Utilities().showToast('Cancel');
      print(e);
    }
  }

  Future<void> makePayment(BuildContext context) async {
    try {
      paymentIntentData =
          await createPaymentIntent(currencyType: 'USD', price: '20000');
      print('make payment $paymentIntentData');
      Provider.of<RegisterCompanyViewModel>(context, listen: false)
          .body['transaction_id'] = paymentIntentData['id'];
      if (paymentIntentData != null) {
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntentData['client_secret'],
            applePay: true,
            googlePay: true,
            merchantCountryCode: 'US',
            style: ThemeMode.dark,
            merchantDisplayName: 'Love Kumar',
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
    final provider =
        Provider.of<RegisterCompanyViewModel>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(children: [
          const BackgroundImage(),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 15.0),
            child: IconButton(
              icon: const Icon(FontAwesomeIcons.arrowLeft,
                  color: Colors.white, size: 20.0),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(children: [
              const SizedBox(
                height: 50,
              ),
              Text(
                'COMPANY \nREGISTRATION',
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
                              paymentDetail(
                                'Comapny Name :',
                                provider.body['first_name'],
                              ),
                              const SizedBox(height: 3),
                              const Divider(
                                color: Colors.white,
                              ),
                              const SizedBox(height: 3),
                              paymentDetail(
                                'Email :',
                                provider.body['email'],
                              ),
                              const SizedBox(height: 3),
                              const Divider(
                                color: Colors.white,
                              ),
                              const SizedBox(height: 3),
                              paymentDetail(
                                'Phone :',
                                provider.body['phone'],
                              ),
                              // const SizedBox(height: 3),
                              // const Divider(
                              //   color: Colors.white,
                              // ),
                              // const SizedBox(height: 3),
                              const Spacer(),
                              payment(
                                'Total Pay :',
                                '\$200',
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.45,
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       // Text('Payment', style: GoogleFonts.montserrat(
              //       //     color: Colors.white,
              //       //     fontWeight: FontWeight.w600,
              //       //     fontSize: 20.0,
              //       //   ),
              //       // ),
              //       // const SizedBox(height: 10,),
              //       // Text('200\$',style: GoogleFonts.montserrat(
              //       //   color: Colors.white,
              //       //   fontWeight: FontWeight.w600,
              //       //   fontSize: 16.0,
              //       // ),),

              //       // TextFieldForAll(errorGetter: ErrorGetter().firstNameErrorGetter,hintText: 'Card Number', prefixIcon: const Icon(
              //       //   FontAwesomeIcons.creditCard,
              //       //   color: Color(0xFF019aff),
              //       //   size: 20.0,
              //       // ),textEditingController: cardNumberController,),
              //       // const SizedBox(
              //       //   height: 10,
              //       // ),
              //       // TextFieldForAll(errorGetter: ErrorGetter().firstNameErrorGetter,hintText: 'MM/YY', prefixIcon: const Icon(
              //       //   FontAwesomeIcons.calendar,
              //       //   color: Color(0xFF019aff),
              //       //   size: 20.0,
              //       // ),textEditingController: monthYearController,),
              //       // const SizedBox(
              //       //   height: 10,
              //       // ),
              //       // TextFieldForAll(errorGetter: ErrorGetter().firstNameErrorGetter,hintText: 'CVC', prefixIcon:  const Icon(
              //       //   FontAwesomeIcons.lock,
              //       //   color: Color(0xFF019aff),
              //       //   size: 20.0,
              //       // ),textEditingController: cvcController,),
              //     ],
              //   ),
              // ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.only(top: 50),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    StepFormButtonNext(
                      () async {
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
        ]),
      ),
    );
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
          fontSize: 17,
        ),
      ),
    ],
  );
}
