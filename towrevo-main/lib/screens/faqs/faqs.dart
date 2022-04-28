import 'package:animate_do/animate_do.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:towrevo/widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FAQs extends StatefulWidget {
  static const routeName = '/faqs';
  const FAQs({Key? key}) : super(key: key);

  @override
  State<FAQs> createState() => _FAQsState();
}

class _FAQsState extends State<FAQs> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<Map<String, String>> faqs = [
    {
      'question': 'What services I can request ?',
      'answer':
          '• Towing \n• Battery jump \n• Flat tire replacement \n• Door lock \n• Roadside assistance',
    },
    {
      'question': 'What type of service available ?',
      'answer': '• Hook-Towing \n• Flatbed-Towing \n• Heavy-duty Towing',
    },
    {
      'question': 'How many times customers can request towing service ? \n',
      'answer':
          '• Customer is limited to 3 times per day/session.  Otherwise customer will be blocked automatically.',
    },
    {
      'question': 'Sign up per person ?',
      'answer': '• Each customer can sign up One time. No account sharing. ',
    },
    {
      'question': 'Company with multiple towing drivers ?',
      'answer':
          '• One account each company required. You can dispatch your drivers when you receive a job request',
    },
    {
      'question': 'Is there a free trial ?',
      'answer':
          '• Follow us on Facebook and Instagram for promotion announcement. \n• We do run different promotions throughout the year \n• Customer pay as you go \n• Towing companies monthly subscription. ',
    },
    {
      'question': 'How to cancel your account ?',
      'answer':
          '• Please email us at support@towrevo.com. \n• 30 days advance notice required ',
    },
    {
      'question': 'How to contact us ? ',
      'answer': 'Please email us at support@towrevo.com ',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawerEnableOpenDragGesture: false,
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Stack(
          children: [
            const FullBackgroundImage(),
            Align(
              alignment: Alignment.topLeft,
              child: backIcon(context, () {
                Navigator.of(context).pop();
              }),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 12.h,
              ),
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  FadeInDown(
                    duration: const Duration(milliseconds: 600),
                    child: const TowrevoLogoSmall(),
                  ),
                  SizedBox(height: 12.h),
                  FadeInDown(
                    duration: const Duration(milliseconds: 650),
                    child: Text(
                      'FAQ\'s',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 25.sp,
                        letterSpacing: 1.w,
                      ),
                    ),
                  ),
                  SizedBox(height: 6.h),
                  FadeInUp(
                    duration: const Duration(milliseconds: 600),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.w,
                        vertical: 5.h,
                      ),
                      width: ScreenUtil().screenWidth,
                      height: ScreenUtil().screenHeight * 0.80,
                      child: Column(
                        children: [
                          SizedBox(
                            width: ScreenUtil().screenWidth,
                            height: ScreenUtil().screenHeight * 0.75,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: faqs.length,
                              itemBuilder: (ctx, index) {
                                return faqContent(
                                  faqs[index]['question'].toString(),
                                  faqs[index]['answer'].toString(),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 6.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

FadeInUp faqContent(
  String question,
  String answer,
) {
  return FadeInUp(
    child: Card(
      color: const Color(0xFF092848).withOpacity(0.7),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ExpandablePanel(
          theme: const ExpandableThemeData(
            iconColor: Colors.white,
            iconPadding: EdgeInsets.only(bottom: 10),
          ),
          header: Text(
            question,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          collapsed: Text(
            answer,
            softWrap: true,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          expanded: Text(
            answer,
            softWrap: true,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    ),
  );
}
