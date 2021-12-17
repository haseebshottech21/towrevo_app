import 'package:flutter/material.dart';
import 'package:towrevo/widgets/full_background_image.dart';

import 'onboard_widget.dart';

class OnBoardTowrevo extends StatefulWidget {
  const OnBoardTowrevo({Key? key}) : super(key: key);

  @override
  _OnBoardTowrevoState createState() => _OnBoardTowrevoState();
}

class _OnBoardTowrevoState extends State<OnBoardTowrevo> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Light Duty Towing",
      "descripttion":
          "The range in towing services begins with the light-duty, involving towing of small sedans and cars within wide reach.",
      "image": "assets/images/truck.png"
    },
    {
      "text": "Medium Duty Towing",
      "descripttion":
          "The truckloads ranging from 9,000 to 22,000 pounds are also catered by the services of medium-duty towing which also includes flatbeds.",
      "image": "assets/images/truck1.png"
    },
    {
      "text": "Heavy Duty Towing",
      "descripttion":
          "For heavy-duty towing the range varies from dumps truck to farm equipment and machinery, along with the quality control system.",
      "image": "assets/images/truck2.png"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        child: Stack(
          children: [
            PageView.builder(
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
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // PageView.builder(
                //   onPageChanged: (value) {
                //     setState(() {
                //       currentPage = value;
                //     });
                //   },
                //   itemCount: splashData.length,
                //   itemBuilder: (context, index) => OnBoardWidget(
                //     backimg: splashData[index]["image"].toString(),
                //     title: splashData[index]["text"].toString(),
                //     desc: splashData[index]["descripttion"].toString(),
                //   ),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    splashData.length,
                    (index) => builDot(index),
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  AnimatedContainer builDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 8),
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        color: currentPage == index ? Colors.white : const Color(0xFF404040),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
