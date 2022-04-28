import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DrawerProfile extends StatelessWidget {
  final Widget profileImage;
  final String profileName;
  final String profileEmail;
  final VoidCallback editOnPressed;
  const DrawerProfile({
    required this.profileImage,
    required this.profileName,
    required this.profileEmail,
    required this.editOnPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Orientation orientation = MediaQuery.of(context).orientation;

    return Container(
      padding: EdgeInsets.only(left: 10.w, right: 10.w),
      height: ScreenUtil().screenHeight * 0.14,
      child: Row(
        children: [
          profileImage,
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                profileName,
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 2.h),
              Container(
                margin: EdgeInsets.only(right: 12.w),
                width: ScreenUtil().screenWidth * 0.43,
                child: Text(
                  profileEmail,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: editOnPressed,
            child: FaIcon(
              FontAwesomeIcons.edit,
              color: Colors.white,
              size: 16.sp,
            ),
          )
        ],
      ),
    );
  }
}
