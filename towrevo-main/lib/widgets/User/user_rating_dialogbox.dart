import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/utilities/towrevo_appcolor.dart';
import 'package:towrevo/view_model/user_home_screen_view_model.dart';

class UserRatingDialog extends StatelessWidget {
  const UserRatingDialog({
    Key? key,
    required this.reqId,
    required this.companyName,
    required this.serviceName,
  }) : super(key: key);

  final String reqId;
  final String companyName;
  final String serviceName;

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      // animate: true,
      // duration: Duration(milliseconds: 500),
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        backgroundColor: AppColors.primaryColor.withOpacity(0.9),
        titlePadding: EdgeInsets.symmetric(vertical: 10.h),
        title: Text(
          'RATE COMPANY',
          style: GoogleFonts.montserrat(
            color: Colors.grey[200],
            fontSize: 22.sp,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'COMPANY : ' + companyName.toUpperCase(),
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 16.sp,
                ),
              ),
              Text(
                'SERVICE : ' + serviceName.toUpperCase(),
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(height: 15.h),
              Consumer<UserHomeScreenViewModel>(
                  builder: (ctx, userViewModel, neverBuildChild) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        userViewModel.updateRating(1);
                      },
                      child: Icon(
                        Icons.star,
                        color: userViewModel.rating >= 1
                            ? Colors.orange
                            : Colors.grey[50],
                        size: 45,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        userViewModel.updateRating(2);
                      },
                      child: Icon(
                        Icons.star,
                        color: userViewModel.rating >= 2
                            ? Colors.orange
                            : Colors.grey[50],
                        size: 45,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        userViewModel.updateRating(3);
                      },
                      child: Icon(
                        Icons.star,
                        color: userViewModel.rating >= 3
                            ? Colors.orange
                            : Colors.grey[50],
                        size: 45,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        userViewModel.updateRating(4);
                      },
                      child: Icon(
                        Icons.star,
                        color: userViewModel.rating >= 4
                            ? Colors.orange
                            : Colors.grey[50],
                        size: 45,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        userViewModel.updateRating(5);
                      },
                      child: Icon(
                        Icons.star,
                        color: userViewModel.rating >= 5
                            ? Colors.orange
                            : Colors.grey[50],
                        size: 45,
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              final provider =
                  Provider.of<UserHomeScreenViewModel>(context, listen: false);
              provider.subimtRating(reqId, provider.rating.toString(), context);
            },
            style: ElevatedButton.styleFrom(
              shadowColor: Colors.transparent,
              primary: Colors.transparent,
            ),
            child: Text(
              'SUBMIT',
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.0,
              ),
            ),
          )
        ],
      ),
    );
  }
}
