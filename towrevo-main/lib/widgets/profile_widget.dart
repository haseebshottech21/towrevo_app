import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utilities/towrevo_appcolor.dart';

class ProfileTowrevo extends StatelessWidget {
  const ProfileTowrevo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          height: size.height * 0.15,
          width: size.width * 0.30,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Icon(
            FontAwesomeIcons.user,
            color: Colors.white.withOpacity(0.5),
            size: 70.0,
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            width: size.width * 0.09,
            height: size.height * 0.045,
            decoration: BoxDecoration(
              color: AppColors.primaryColor2.withOpacity(0.7),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const Icon(
              FontAwesomeIcons.camera,
              color: Colors.white,
              size: 15.0,
            ),
          ),
        ),
      ],
    );
  }
}
