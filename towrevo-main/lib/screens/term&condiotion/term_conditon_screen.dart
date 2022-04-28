import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:towrevo/widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TermAndCondition extends StatefulWidget {
  static const routeName = '/terms-and-condition';
  const TermAndCondition({Key? key}) : super(key: key);

  @override
  State<TermAndCondition> createState() => _TermAndConditionState();
}

class _TermAndConditionState extends State<TermAndCondition> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<Map<String, String>> termAndConditon = [
    {
      'title': 'Agreement of Use',
      'description':
          'Please read these Terms of Service (“Agreement”, “Terms of Service”) carefully before using TowRevo (the site) and TowRevo App (associated application) operated by TowRevo LLC. By accessing or using the Site or App in any manner, including, but not limited to, visiting or browsing the Site or the App or contributing content or other materials to the Site or App, you agree to be bound by these Terms of Service. Capitalized terms are defined in this Agreement.',
    },
    {
      'title': 'Acceptance of terms',
      'description':
          'The services that Towrevo LLC provides to its customers, herein referred to as user(s) is subject to the terms and conditions outlined below. Towrevo reserves the right to alter, modify or update the said terms and conditions at any time and without giving prior notice to the user.',
    },
    {
      'title': 'Liability',
      'description':
          'Except as permitted by law, Towrevo’s total liability will be limited to the amount paid by the user for the offered services. In every case, Towrevo will not bear liability for property damages. \n\nTowevo does not determine issues regarding car damages. The towing companies and customers, therefore, are to decide on the settlement of car damages.',
    },
    {
      'title': 'Towing fees',
      'description':
          'Towrevo does not determine the towing fees be charged by the towing companies and such fees are to be agreed upon by the customers and towing companies. \n\nTowrevo does not engage in the process of towing fees hence no refund should be claimed by aggrieved parties in this case customers.',
    },
    {
      'title': 'Cancellation of the user account',
      'description':
          'We reserve the right to cancel a user’s account at any time. Such cancellation is however premised on the violation of the terms and conditions specified herein.'
    },
    {
      'title': 'Pay as you charging system',
      'description':
          'Towrevo services to customers are based on a pay-as-you-go system. Customers only use services that they have paid for and cannot use extra services unless they pay for them first.'
    },
    {
      'title': 'Monthly subscription of services',
      'description':
          'Providers are based on a monthly subscription and Towrevo reserves the right of cancellation at any time.'
    },
    {
      'title': 'Service delays',
      'description':
          'While Towrevo is committed to offering timely service to its customers, there may be towing service delays during high peak times.'
    },
    {
      'title': 'Service fees',
      'description':
          'It is the responsibility of customers to call towing companies for purposes of discussing service fees. Towrevo does not impose any service fee on towing or its services on the app or website. Towrevo however charges customers a fee to find towing services offered by the towing companies nearby. The Towrevo customers are charged to get details on towing companies if the results on towing companies appear in the app.'
    },
    {
      'title': 'Non- provision of services',
      'description':
          'Due to bad weather conditions in certain areas, towing companies may not provide their services in the areas.'
    },
    {
      'title': 'App fees',
      'description':
          'The use of the Towrevo app is subject to the payment of fees. Such fee once paid is not refundable.'
    },
    {
      'title': 'Company promotional offers',
      'description':
          'From time to time, we may give promotional offers to customers. The offers include but are not limited to accessing towing companies’ details for free.'
    },
    {
      'title': 'Intellectual property',
      'description':
          'The Site, the App, and its original content, features, and functionality are the property of TowRevo LLC and which property is protected by international copyright, trademark, patent, trade secret, and any other intellectual property or proprietary rights laws. You consent to make no claim whatsoever in the ownership or rights of any form regarding TowRevo’s App, Website, and other affiliated intellectual property.'
    },
    {
      'title': 'Links to Other Sites or Apps',
      'description':
          'Our Site or App may contain links to third-party sites that are not owned or controlled by TowRevo LLC. TowRevo LLC assumes no responsibility for the content, privacy policies, or practices of any third-party sites or services. We strongly advise you to read the terms and conditions and privacy policy of any third-party site that you visit or app that you use.'
    },
    {
      'title': 'Governing Law',
      'description':
          'This agreement (and any further rules, policies, or guidelines incorporated by reference) shall be governed and constructed under the laws of the United States without giving effect to any principles of conflict of law.'
    },
    {
      'title': 'Termination of access',
      'description':
          'We may terminate your access to the Site or the App \n\n1. Without cause or notice at our own discretion. \n2. If you are the valuation of any of terms of this Agreement. \n\nTermination of access may result in the forfeiture and destruction of all information associated with you.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    bool reqFromSignUp = ModalRoute.of(context)!.settings.arguments as bool;
    return Scaffold(
      key: scaffoldKey,
      drawerEnableOpenDragGesture: false,
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            const FullBackgroundImage(),
            if (!reqFromSignUp)
              backIcon(context, () {
                Navigator.of(context).pop();
              }),
            if (reqFromSignUp)
              backIcon(context, () {
                Navigator.of(context).pop();
              }),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                horizontal: 10.h,
                vertical: 20.w,
              ),
              child: Column(
                children: [
                  SizedBox(height: 25.h),
                  FadeInDown(
                    duration: const Duration(milliseconds: 600),
                    child: const TowrevoLogoSmall(),
                  ),
                  SizedBox(height: 15.h),
                  FadeInUp(
                    duration: const Duration(milliseconds: 600),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15.w,
                        vertical: 5.h,
                      ),
                      width: ScreenUtil().screenWidth,
                      height: ScreenUtil().screenHeight * 0.75,
                      decoration: BoxDecoration(
                        color: const Color(0xFF092848).withOpacity(0.8),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: Center(
                              child: Text(
                                'Term & Condition \nPrivacy Policy',
                                style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22.sp,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: ScreenUtil().screenWidth,
                            height: ScreenUtil().screenHeight * 0.60,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: termAndConditon.length,
                              itemBuilder: (ctx, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 15.h),
                                    titleTermAndCond(
                                      termAndConditon[index]['title']
                                          .toString(),
                                    ),
                                    SizedBox(height: 5.h),
                                    descTermAndCond(
                                      termAndConditon[index]['description']
                                          .toString(),
                                    ),
                                    SizedBox(height: 5.h),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
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

Text titleTermAndCond(String title) {
  return Text(
    title,
    style: GoogleFonts.montserrat(
      color: Colors.blue,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.italic,
      fontSize: 20.sp,
    ),
  );
}

Text descTermAndCond(String desc) {
  return Text(
    desc,
    style: GoogleFonts.montserrat(
      color: Colors.white,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5.w,
      fontSize: 13.sp,
    ),
  );
}
