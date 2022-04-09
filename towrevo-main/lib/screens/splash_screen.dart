// import 'package:flutter/material.dart';
// import 'package:towrevo/view_model/splash_view_model.dart';

// class SplashScreen extends StatelessWidget {
//   const SplashScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Future.delayed(Duration.zero)
//         .then((value) => SplashViewModel().navigateToWelcome(context));
//     return Scaffold(
//       body: Stack(
//         children: [
//           Container(
//             height: MediaQuery.of(context).size.height,
//             width: MediaQuery.of(context).size.width,
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage('assets/images/splashbg.jpg'),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           Center(
//             child: Container(
//               height: MediaQuery.of(context).size.height * 0.25,
//               width: MediaQuery.of(context).size.width * 0.65,
//               decoration: const BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage('assets/images/logo.png'),
//                   fit: BoxFit.fill,
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
