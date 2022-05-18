import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectorWidget extends StatelessWidget {
  final BuildContext context;
  final Function onTap;
  final String title;
  final IconData icon;
  final int delayMilliseconds;
  final double? height;
  final IconData? trailingIcon;
  final int? maxlines;
  const SelectorWidget({
    required this.context,
    required this.onTap,
    required this.icon,
    required this.title,
    required this.delayMilliseconds,
    this.trailingIcon,
    this.height,
    this.maxlines = 2,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: FadeInDown(
        from: 20,
        delay: Duration(milliseconds: delayMilliseconds),
        child: Container(
          height: height,
          padding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 6.h,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(30.r),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(width: 6.w),
                  Icon(
                    icon,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(width: 12.w),
                  Center(
                    child: maxlines == 2
                        ? Container(
                            alignment: Alignment.centerLeft,
                            height: height,
                            width: ScreenUtil().screenWidth * 0.65,
                            child: Text(
                              title,
                              style: GoogleFonts.montserrat(
                                color: Colors.black87,
                                fontSize: 14.sp,
                              ),
                              // maxLines: maxlines,
                              // overflow: TextOverflow.ellipsis,
                            ),
                          )
                        : Container(
                            alignment: Alignment.centerLeft,
                            height: height,
                            width: ScreenUtil().screenWidth * 0.65,
                            child: Text(
                              title,
                              style: GoogleFonts.montserrat(
                                color: Colors.black87,
                                fontSize: 14.sp,
                              ),
                              maxLines: maxlines,
                              // overflow: TextOverflow.ellipsis,
                            ),
                          ),
                  ),
                ],
              ),
              if (trailingIcon != null)
                Icon(
                  trailingIcon,
                  // Icons.my_location,
                  color: Theme.of(context).primaryColor,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class SelectLocation extends StatelessWidget {
  final BuildContext context;
  final Function onTap;
  final String title;
  final IconData icon;
  final int delayMilliseconds;
  final double? height;
  final IconData? trailingIcon;
  final int? maxlines;
  const SelectLocation({
    required this.context,
    required this.onTap,
    required this.icon,
    required this.title,
    required this.delayMilliseconds,
    this.trailingIcon,
    this.height,
    this.maxlines = 2,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: FadeInDown(
        from: 20,
        delay: Duration(milliseconds: delayMilliseconds),
        child: Container(
          height: height,
          padding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 6.h,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(30.r),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(width: 6.w),
                  Icon(
                    icon,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(width: 12.w),
                  Center(
                      child: Container(
                    alignment: Alignment.centerLeft,
                    height: height,
                    width: ScreenUtil().screenWidth * 0.65,
                    child: Text(
                      title,
                      style: GoogleFonts.montserrat(
                        color: Colors.black87,
                        fontSize: 14.sp,
                      ),
                      maxLines: maxlines,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )),
                ],
              ),
              if (trailingIcon != null)
                Icon(
                  trailingIcon,
                  // Icons.my_location,
                  color: Theme.of(context).primaryColor,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
