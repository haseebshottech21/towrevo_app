import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:towrevo/widgets/widgets.dart';
import '../../../utilities/towrevo_appcolor.dart';

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
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Spacer(),
            FadeInDown(
              from: 25,
              child: const TowrevoLogoSmall(),
            ),
            const Spacer(),
            FadeInRight(
              child: SizedBox(
                // width: MediaQuery.of(context).size.width * 0.75,
                // height: MediaQuery.of(context).size.height * 0.20,
                width: ScreenUtil().setWidth(200),
                height: ScreenUtil().setHeight(150),
                child: Image.asset(backimg),
              ),
            ),
            const Spacer(),
            FadeInUp(
              duration: const Duration(milliseconds: 600),
              from: 60,
              child: Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.symmetric(
                  horizontal: 15.w,
                  vertical: 15.h,
                ),
                width: MediaQuery.of(context).size.width,
                height: 220.h,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.8),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45.r),
                    topRight: Radius.circular(45.r),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15.h),
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
            ),
          ],
        ),
      ],
    );
  }
}
