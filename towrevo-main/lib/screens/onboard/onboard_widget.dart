import 'package:flutter/material.dart';
import 'package:towrevo/widgets/background_image.dart';
import 'package:towrevo/widgets/full_background_image.dart';

class OnBoardWidget extends StatelessWidget {
  final String title, desc, backimg;
  const OnBoardWidget({
    required this.title,
    required this.desc,
    required this.backimg,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const FullBackgroundImage(),
          Align(
            alignment: Alignment.topLeft,
            child: TextButton(
              onPressed: () {
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const WelcomeBizhubScreen(),
                //   ),
                // );
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Text(
                  'SKIP',
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.white, fontSize: 16,),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 15,
                    ),
                    width: MediaQuery.of(context).size.width * 0.90,
                    height: MediaQuery.of(context).size.height * 0.40,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.75,
                          height: 100,
                          child: Image.asset(backimg),
                        ),
                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          desc,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     // Navigator.pushReplacement(
                  //     //   context,
                  //     //   MaterialPageRoute(
                  //     //     builder: (context) => const WelcomeBizhubScreen(),
                  //     //   ),
                  //     // );
                  //   },
                  //   style: ElevatedButton.styleFrom(
                  //     primary: Colors.black,
                  //     minimumSize: const Size(300, 50),
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //   ),
                  //   child: const Text(
                  //     'Get Started',
                  //     style: TextStyle(
                  //       color: Colors.white,
                  //       fontSize: 22,
                  //       letterSpacing: 0.5,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
      // body: Stack(
      //   children: [
      //     SizedBox(
      //       width: MediaQuery.of(context).size.width,
      //       height: MediaQuery.of(context).size.height,
      //       child: Image.asset(
      //         backimg,
      //         fit: BoxFit.cover,
      //       ),
      //     ),
      //     Align(
      //       alignment: Alignment.topRight,
      //       child: TextButton(
      //         onPressed: () {
      //           // Navigator.pushReplacement(
      //           //   context,
      //           //   MaterialPageRoute(
      //           //     builder: (context) => const WelcomeBizhubScreen(),
      //           //   ),
      //           // );
      //         },
      //         child: const Padding(
      //           padding: EdgeInsets.symmetric(horizontal: 20),
      //           child: Text(
      //             'SKIP',
      //             textAlign: TextAlign.end,
      //             style: TextStyle(color: Colors.white, fontSize: 15),
      //           ),
      //         ),
      //       ),
      //     ),
      //     Center(
      //       child: Column(
      //         // crossAxisAlignment: CrossAxisAlignment.center,
      //         mainAxisAlignment: MainAxisAlignment.end,
      //         children: [
      //           Text(
      //             title,
      //             style: const TextStyle(
      //               color: Colors.white,
      //               fontSize: 30,
      //               fontWeight: FontWeight.bold,
      //             ),
      //             textAlign: TextAlign.center,
      //           ),
      //           const SizedBox(
      //             height: 20.0,
      //           ),
      //           Padding(
      //             padding: const EdgeInsets.symmetric(horizontal: 20.0),
      //             child: Text(
      //               desc,
      //               style: const TextStyle(color: Colors.white, fontSize: 17),
      //               textAlign: TextAlign.center,
      //             ),
      //           ),
      //           const SizedBox(
      //             height: 40.0,
      //           ),
      //           ElevatedButton(
      //             onPressed: () {
      //               // Navigator.pushReplacement(
      //               //   context,
      //               //   MaterialPageRoute(
      //               //     builder: (context) => const WelcomeBizhubScreen(),
      //               //   ),
      //               // );
      //             },
      //             style: ElevatedButton.styleFrom(
      //               primary: const Color(0xFF16b211),
      //               minimumSize: const Size(300, 50),
      //               shape: RoundedRectangleBorder(
      //                 borderRadius: BorderRadius.circular(10),
      //               ),
      //             ),
      //             child: const Text(
      //               'Get Started',
      //               style: TextStyle(
      //                 color: Colors.white,
      //                 fontSize: 22,
      //                 letterSpacing: 0.5,
      //               ),
      //             ),
      //           ),
      //           const SizedBox(
      //             height: 70.0,
      //           ),
      //         ],
      //       ),
      //     )
      //   ],
    );
  }
}
