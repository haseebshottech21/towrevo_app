import 'package:flutter/material.dart';
import 'package:towrevo/screens/screens.dart';
import 'package:towrevo/widgets/widgets.dart';
import 'onboard_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnBoardTowrevo extends StatefulWidget {
  const OnBoardTowrevo({Key? key}) : super(key: key);

  @override
  _OnBoardTowrevoState createState() => _OnBoardTowrevoState();
}

class _OnBoardTowrevoState extends State<OnBoardTowrevo> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "image": "assets/images/LightDutyTowing.png",
      "text": "Light Duty Towing",
      "descripttion":
          "The range in towing services begins with the light-duty, involving towing of small sedans and cars within wide reach.",
    },
    {
      "image": "assets/images/MediumDutyTowing.png",
      "text": "Medium Duty Towing",
      "descripttion":
          "The truckloads ranging from 9,000 to 22,000 pounds are also catered by the services of medium-duty towing which also includes flatbeds.",
    },
    {
      "image": "assets/images/HeavyDutyTowing.png",
      "text": "Heavy Duty Towing",
      "descripttion":
          "For heavy-duty towing the range varies from dumps truck to farm equipment and machinery, along with the quality control system.",
    }
  ];

  PageController controller =
      PageController(viewportFraction: 1, keepPage: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const FullBackgroundImage(),
          PageView.builder(
            controller: controller,
            onPageChanged: (value) {
              setState(() {
                currentPage = value;
              });
            },
            itemCount: splashData.length,
            itemBuilder: (context, index) => OnBoardWidget(
              backimg: splashData[index]["image"].toString(),
              title: splashData[index]["text"].toString(),
              desc: splashData[index]["descripttion"].toString(),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WelcomeScreen(),
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 25.h),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 7.h),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    'SKIP',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 15.h,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(
                        splashData.length,
                        (index) => builDot(index),
                      ),
                    ),
                    currentPage == 2
                        ? ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const WelcomeScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xFF092848),
                              minimumSize: Size(120.w, 40.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                            child: Text(
                              'Get Started',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.sp,
                                letterSpacing: 0.5,
                              ),
                            ),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              if (currentPage == 0) {
                                controller.jumpToPage(1);
                              } else if (currentPage == 1) {
                                controller.jumpToPage(2);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xFF092848),
                              minimumSize: Size(45.w, 40.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                            ),
                          ),
                  ],
                ),
              ),
              SizedBox(height: 15.h)
            ],
          )
        ],
      ),
    );
  }

  AnimatedContainer builDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: EdgeInsets.only(right: 8.w),
      height: 5.h,
      width: currentPage == index ? 18.w : 13.w,
      decoration: BoxDecoration(
        color: currentPage == index ? Colors.white : Colors.grey[400],
        borderRadius: BorderRadius.circular(12.r),
      ),
    );
  }
}
