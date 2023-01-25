import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../screens/user/user_monthly_payment_screen.dart';
import '../../utilities/towrevo_appcolor.dart';
import '../../view_model/user_home_screen_view_model.dart';

class CustomBottomSheet extends StatelessWidget {
  final UserHomeScreenViewModel userHomeScreenViewModel;
  const CustomBottomSheet({Key? key, required this.userHomeScreenViewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: .12,
      minChildSize: .12,
      maxChildSize: .3,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          // color: Colors.lightGreen[100],
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            controller: scrollController,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 12,
                ),
                child: Column(
                  children: [
                    Text(
                      'Welcome to TowRevo App!',
                      style: GoogleFonts.montserrat(
                        color: Colors.grey[200],
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      userHomeScreenViewModel.totalCount == 2
                          ? 'Your 2 Free Trial Has Ended!'
                          : 'You have only ${userHomeScreenViewModel.trialLeft} Trial Left',
                      style: GoogleFonts.montserrat(
                        color: Colors.grey[200],
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      // userHomeProvider.totalCount == 2
                      'Get 2 More Free Trials Every 30 Days, OR Upgrade To Premium For \$1.99',
                      // : 'You have only ${userHomeProvider.trialLeft} Trial Left',
                      style: GoogleFonts.montserrat(
                        color: Colors.grey[200],
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Center(
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              UserMonthlyPaymentScreen.routeName,
                              arguments:
                                  (userHomeScreenViewModel.isPayFirst! == false)
                                      ? 404
                                      : userHomeScreenViewModel.isPayFirst!
                                          ? 401
                                          : 0,
                            );
                          },
                          child: Container(
                            height: 50,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor2,
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
                                  'PURCHASE NOW',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  '\$ 1.99',
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
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// class CustomBottomSheet extends StatefulWidget {
//   final UserHomeScreenViewModel userHomeScreenViewModel;
//   const CustomBottomSheet({Key? key, required this.userHomeScreenViewModel})
//       : super(key: key);

//   @override
//   State<CustomBottomSheet> createState() => _CustomBottomSheetState();
// }

// class _CustomBottomSheetState extends State<CustomBottomSheet> {
//   @override
//   Widget build(BuildContext context) {
//     // Size size = MediaQuery.of(context).size;
//     return DraggableScrollableSheet(
//       initialChildSize: .12,
//       minChildSize: .12,
//       maxChildSize: .3,
//       builder: (BuildContext context, ScrollController scrollController) {
//         return Container(
//           // color: Colors.lightGreen[100],
//           decoration: BoxDecoration(
//             color: AppColors.primaryColor,
//             borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(30.0),
//               topRight: Radius.circular(30.0),
//             ),
//           ),
//           child: ListView(
//             padding: EdgeInsets.zero,
//             controller: scrollController,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                   vertical: 16,
//                   horizontal: 12,
//                 ),
//                 child: Column(
//                   children: [
//                     Text(
//                       'Welcome to TowRevo App!',
//                       style: GoogleFonts.montserrat(
//                         color: Colors.grey[200],
//                         fontSize: 20.sp,
//                         fontWeight: FontWeight.w500,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: 10),
//                     Text(
//                       userHomeProvider.totalCount == 2
//                           ? 'Your 2 Free Trial Has Ended!'
//                           : 'You have only ${userHomeProvider.trialLeft} Trial Left',
//                       style: GoogleFonts.montserrat(
//                         color: Colors.grey[200],
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.w400,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: 20),
//                     Text(
//                       // userHomeProvider.totalCount == 2
//                       'Get 2 More Free Trials Every 30 Days, OR Upgrade To Premium For \$1.99',
//                       // : 'You have only ${userHomeProvider.trialLeft} Trial Left',
//                       style: GoogleFonts.montserrat(
//                         color: Colors.grey[200],
//                         fontSize: 14.sp,
//                         fontWeight: FontWeight.w400,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: 20),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       child: Center(
//                         child: InkWell(
//                           onTap: () {
//                             bottomPaymnet(
//                               userHomeProvider.isPayFirst!,
//                               context,
//                             );
//                           },
//                           child: Container(
//                             height: 50,
//                             padding: const EdgeInsets.symmetric(horizontal: 12),
//                             decoration: BoxDecoration(
//                               color: AppColors.primaryColor2,
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 const Icon(
//                                   Icons.payment,
//                                   color: Colors.white,
//                                   size: 25,
//                                 ),
//                                 Text(
//                                   'PURCHASE NOW',
//                                   style: GoogleFonts.montserrat(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.w500,
//                                     fontSize: 15,
//                                   ),
//                                 ),
//                                 Text(
//                                   '\$ 1.99',
//                                   style: GoogleFonts.montserrat(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 18,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
