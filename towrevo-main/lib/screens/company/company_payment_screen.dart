import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/error_getter.dart';
import 'package:towrevo/models/company_model.dart';
import 'package:towrevo/models/payment_model.dart';
import 'package:towrevo/utilities/utilities.dart';
import 'package:towrevo/view_model/view_model.dart';
import 'package:towrevo/widgets/Company/add_discount_bottom_sheet.dart';
import 'package:towrevo/widgets/widgets.dart';
import 'package:http/http.dart' as http;
import '../../utilities/env_settings.dart';
import '../../utilities/towrevo_appcolor.dart';

class CompanyPaymentScreen extends StatefulWidget {
  const CompanyPaymentScreen({Key? key}) : super(key: key);

  static const routeName = '/company-payment';

  @override
  _CompanyPaymentScreenState createState() => _CompanyPaymentScreenState();
}

class _CompanyPaymentScreenState extends State<CompanyPaymentScreen> {
  Map<String, dynamic> paymentIntentData = {};

  bool applyCoupon = false;

  String totalAmount = '19.95';
  String totalDiscount = '50%';
  String payAmount = '1155';

  TextEditingController codeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  validateForm() async {
    // final registerUserViewModel =
    //     Provider.of<RegisterUserViewModel>(context, listen: false);
    if (!_formKey.currentState!.validate()) {
      return;
    }
  }

  paynow(BuildContext context) async {
    final companyViewModel =
        Provider.of<CompanyHomeScreenViewModel>(context, listen: false);
    await companyViewModel.payNow(paymentIntentData['id'], '20', context);
    paymentIntentData = {};
  }

  applyDiscount(
    BuildContext context,
    String companyId,
    String couponCode,
  ) async {
    final companyDiscount =
        Provider.of<CompanyHomeScreenViewModel>(context, listen: false);
    await companyDiscount.discountPayNow(companyId, couponCode, context);
  }

  displayPaymentSheet(BuildContext context) async {
    try {
      await Stripe.instance.presentPaymentSheet(
        parameters: PresentPaymentSheetParameters(
          clientSecret: paymentIntentData['client_secret'],
          confirmPayment: true,
        ),
      );

      paynow(context);
    } on StripeException catch (e) {
      Utilities().showToast('${e.error.localizedMessage}');
    }
  }

  Future<void> makePayment(BuildContext context, String price) async {
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

        displayPaymentSheet(context);
      }
    } catch (e) {
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
    final coupon =
        Provider.of<CompanyHomeScreenViewModel>(context, listen: true);

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
                          await makePayment(context, payAmount);
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
                  TextButton(
                    onPressed: () {
                      showCouponField(
                        context: context,
                        controller: codeController,
                        errorGetter: ErrorGetter().couponCodeErrorGetter,
                        formKey: _formKey,
                        onPressed: () {
                          validateForm();
                          if (applyDiscount(
                            context,
                            '160',
                            codeController.text,
                          )) {
                            Navigator.of(context).pop();
                            showDiscountPayment(
                              context,
                              // totalAmount,
                              coupon.couponModel[0],
                              // payAmount,
                              () async {
                                if (!(await Utilities()
                                    .isInternetAvailable())) {
                                  return;
                                }
                                await makePayment(context, payAmount);
                                Navigator.of(context).pop();
                              },
                            );
                          }
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.tag,
                            color: AppColors.primaryColor,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Apply Coupoun',
                            style: GoogleFonts.montserrat(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
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
