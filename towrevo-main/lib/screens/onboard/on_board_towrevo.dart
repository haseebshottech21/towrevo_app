import 'package:flutter/material.dart';
import 'package:towrevo/screens/authentication/welcome_screen.dart';
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
    // Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        // body: Container(
        //   height: size.height,
        //   width: size.width,
        //   decoration: const BoxDecoration(
        //     image: DecorationImage(
        //       image: AssetImage('assets/images/fullbg.jpg'),
        //       fit: BoxFit.fill,
        //     ),
        //   ),
        //   child:
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
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Text(
                    'SKIP',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
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
                                //     : print('Next');
                              },
                              style: ElevatedButton.styleFrom(
                                primary: const Color(0xFF092848),
                                minimumSize: const Size(150, 45),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: const Text(
                                'Get Started',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
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
                                minimumSize: const Size(50, 45),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
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
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.only(right: 8),
      height: 8,
      width: currentPage == index ? 20 : 15,
      decoration: BoxDecoration(
        color: currentPage == index ? Colors.white : Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
