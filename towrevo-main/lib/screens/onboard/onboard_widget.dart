import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:towrevo/widgets/widgets.dart';
import '../../../utitlites/towrevo_appcolor.dart';

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
                width: MediaQuery.of(context).size.width * 0.75,
                height: MediaQuery.of(context).size.height * 0.20,
                child: Image.asset(backimg),
              ),
            ),
            const Spacer(),
            FadeInUp(
              duration: const Duration(milliseconds: 600),
              from: 60,
              child: Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 15,
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.35,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.8),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
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
