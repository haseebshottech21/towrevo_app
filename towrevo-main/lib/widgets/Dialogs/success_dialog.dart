import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../screens/authentication/login/login_screen.dart';

// class CustomDialog extends StatelessWidget {
//   final String title, description;

//   const CustomDialog({
//     required this.title,
//     required this.description,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       elevation: 0,
//       backgroundColor: Colors.transparent,
//       child: dialogContent(context),
//     );
//   }

//   dialogContent(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width * 0.50,
//       margin: const EdgeInsets.only(top: 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         shape: BoxShape.rectangle,
//         borderRadius: BorderRadius.circular(18),
//         boxShadow: const [
//           BoxShadow(
//             color: Colors.black26,
//             blurRadius: 10.0,
//             offset: Offset(0.0, 10.0),
//           )
//         ],
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Image.asset(
//             'assets/images/checked.gif',
//             height: MediaQuery.of(context).size.height * 0.20,
//             width: MediaQuery.of(context).size.width * 0.20,
//           ),
//           Text(
//             title,
//             style: const TextStyle(
//               fontSize: 24.0,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//           const SizedBox(height: 24),
//         ],
//       ),
//     );
//   }
// }

showSuccessDialog(
  BuildContext context,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        // title: Text('Welcome'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              width: 200,
              child: Image.asset('assets/images/check.png'),
            ),
            const SizedBox(height: 20),
            Text(
              'SUCCESS!',
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600,
                fontSize: 26.0.sp,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'You have successfully created your Account. Please wait for verification email to LOGIN',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w400,
                fontSize: 15.0.sp,
              ),
            ),
          ],
        ),
        actionsPadding: const EdgeInsets.symmetric(
          horizontal: 12.0,
        ),
        actions: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFF092847),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'OK',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w500,
                  fontSize: 13.0.sp,
                  letterSpacing: 1.0,
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}

showCancelDialog(
  BuildContext context,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        // title: Text('Welcome'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              width: 200,
              child: Image.asset('assets/images/blocked.png'),
            ),
            const SizedBox(height: 20),
            Text(
              'BLOCKED',
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600,
                fontSize: 26.0.sp,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'You have been BLOCKED by TowRevo. For more information please contact Admin.',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w400,
                fontSize: 15.0.sp,
              ),
            ),
          ],
        ),
        actionsPadding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 6.0,
        ),
        actions: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFF092847),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'OK',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w500,
                  fontSize: 13.0.sp,
                  letterSpacing: 1.0,
                ),
              ),
            ),
          ),
        ],
      );
    },
  ).then((value) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(LoginScreen.routeName, (route) => false);
  });
}
