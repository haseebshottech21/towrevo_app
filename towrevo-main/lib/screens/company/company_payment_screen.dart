import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:towrevo/screens/colors/towrevo_appcolor.dart';
import 'package:towrevo/widgets/back_icon.dart';
import 'package:towrevo/widgets/full_background_image.dart';
import 'package:towrevo/widgets/payment_detail.dart';

class CompanyPaymentScreen extends StatefulWidget {
  const CompanyPaymentScreen({Key? key}) : super(key: key);

  static const routeName = '/company-payment';

  @override
  _CompanyPaymentScreenState createState() => _CompanyPaymentScreenState();
}

class _CompanyPaymentScreenState extends State<CompanyPaymentScreen> {
  @override
  Widget build(BuildContext context) {
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
                        // if (!(await Utilities().isInternetAvailable())) {
                        //   return;
                        // }
                        // await makePayment(context);
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
