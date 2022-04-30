import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/error_getter.dart';
import 'package:towrevo/utilities/utilities.dart';
import 'package:towrevo/view_model/view_model.dart';
import 'package:towrevo/widgets/Company/add_discount_bottom_sheet.dart';
import 'package:towrevo/widgets/widgets.dart';
import 'package:http/http.dart' as http;
import '../../utilities/env_settings.dart';
import '../../utilities/towrevo_appcolor.dart';

class CompanyPaymentScreen extends StatefulWidget {
  const CompanyPaymentScreen({Key? key}) : super(key: key);
  static const int payAmmount = 1995;

  static const routeName = '/company-payment';

  @override
  _CompanyPaymentScreenState createState() => _CompanyPaymentScreenState();
}

class _CompanyPaymentScreenState extends State<CompanyPaymentScreen> {
  Map<String, dynamic> paymentIntentData = {};

  TextEditingController codeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  validateForm(BuildContext context, PaymentViewModel paymentViewModel) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    paymentViewModel.checkCoupon(
      coupon: codeController.text.trim(),
      context: context,
      makePament: makePayment,
    );
  }

  paynow(BuildContext context, String amount, String couponId) async {
    final companyViewModel =
        Provider.of<CompanyHomeScreenViewModel>(context, listen: false);

    await companyViewModel.payNow(
      amount: (int.parse(amount) / 100).toString(),
      transactionId: paymentIntentData['id'],
      context: context,
      couponId: couponId,
    );
    paymentIntentData = {};
  }

  displayPaymentSheet(
      BuildContext context, String amount, String couponId) async {
    try {
      // print(paymentIntentData);
      await Stripe.instance.presentPaymentSheet(
        parameters: PresentPaymentSheetParameters(
          clientSecret: paymentIntentData['client_secret'],
          confirmPayment: true,
        ),
      );

      paynow(context, amount, couponId);
    } on StripeException catch (e) {
      Fluttertoast.showToast(msg: '${e.error.localizedMessage}');
    }
  }

  Future<void> makePayment(
    BuildContext context,
    String price,
    String couponId,
  ) async {
    try {
      paymentIntentData =
          await createPaymentIntent(currencyType: 'USD', price: price);

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

        displayPaymentSheet(context, price, couponId);
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
      );
      print(e);
    }
  }

  Future createPaymentIntent(
      {required String price, required String currencyType}) async {
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
            'Authorization': 'Bearer ${ENVSettings.stripeSecretKey}',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      return jsonDecode(response.body);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final paymentViewModel =
        Provider.of<PaymentViewModel>(context, listen: false);
    final int statusCode = ModalRoute.of(context)!.settings.arguments as int;
    //404 mean first time , 401 means expired subscription
    print(statusCode);

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  Text(
                    statusCode == 401
                        ? 'MONTHLY SUBSCRIBTION EXPIRED'
                        : 'MONTHLY SUBSCRIBTION',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: statusCode == 401 ? 20.0 : 28.0,
                      letterSpacing: 1.5,
                    ),
                  ),
                  if (statusCode == 401) const SizedBox(height: 10),
                  if (statusCode == 401)
                    Center(
                      child: Text(
                        'Payment expired, please renew it.',
                        style: GoogleFonts.montserrat(
                          color: AppColors.primaryColor,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // navigateUserHomeScreen();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        shadowColor: Colors.transparent,
                        primary: Colors.transparent,
                        minimumSize: Size(
                          MediaQuery.of(context).size.width * 0.95,
                          50,
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () async {
                          if (!(await Utilities().isInternetAvailable())) {
                            return;
                          }
                          await makePayment(context,
                              CompanyPaymentScreen.payAmmount.toString(), '');
                          // _show(context);
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
                  ),
                  const SizedBox(height: 5),
                  // TextButton(
                  //   onPressed: () {
                  //     showCouponField(
                  //       context: context,
                  //       controller: codeController,
                  //       errorGetter: ErrorGetter().couponCodeErrorGetter,
                  //       formKey: _formKey,
                  //       onPressed: () {
                  //         validateForm(context, paymentViewModel);
                  //       },
                  //     );
                  //   },
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(left: 12),
                  //     child: Row(
                  //       children: [
                  //         // UniconsLine.apps,(
                  //         //   FontAwesomeIcons.tag,
                  //         //   color: AppColors.primaryColor,
                  //         //   size: 16,
                  //         // ),

                  //         Icon(
                  //           UniconsSolid.apps,
                  //           color: Colors.white,
                  //           size: 16,
                  //         ),

                  //         const SizedBox(width: 8),
                  //         Text(
                  //           'Apply a Voucher',
                  //           style: GoogleFonts.montserrat(
                  //             color: Colors.white,
                  //             fontWeight: FontWeight.w600,
                  //             fontSize: 15,
                  //             letterSpacing: 0.5,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  ElevatedButton(
                    onPressed: () {
                      // navigateUserHomeScreen();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      shadowColor: Colors.transparent,
                      primary: Colors.transparent,
                      minimumSize: Size(
                        MediaQuery.of(context).size.width * 0.50,
                        45,
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        showVoucherField(
                          context: context,
                          controller: codeController,
                          errorGetter: ErrorGetter().voucherCodeErrorGetter,
                          formKey: _formKey,
                          onPressed: () {
                            validateForm(context, paymentViewModel);
                          },
                        );
                      },
                      child: Container(
                        height: 45,
                        // width: MediaQuery.of(context).size.width * 0.90,
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(width: 3),
                            Image.asset(
                              'assets/images/voucher.png',
                              height: 25,
                            ),
                            const SizedBox(width: 40),
                            Text(
                              'APPLY A VOUCHER',
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
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
