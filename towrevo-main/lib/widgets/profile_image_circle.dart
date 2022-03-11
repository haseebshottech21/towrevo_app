import 'package:flutter/material.dart';
import '../utitlites/towrevo_appcolor.dart';

Container profileImageCircle(BuildContext context, String image) {
  print(image);
  return Container(
    width: 55,
    height: 55,
    // decoration: BoxDecoration(
    //   border: Border.all(
    //     color: Theme.of(context).primaryColor,
    //     width: 2,
    //   ),
    //   borderRadius: BorderRadius.circular(50),
    // ),
    decoration: BoxDecoration(
      border: Border.all(
        color: Theme.of(context).primaryColor,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(50),
      image: DecorationImage(
        image: NetworkImage(image),
        fit: BoxFit.cover,
      ),
    ),
    // child: ClipOval(
    //   child: Image.network(
    //     image,
    //     width: 50,
    //     height: 50,
    //     fit: BoxFit.cover,
    //   ),
    // ),
  );
}

Container profileImageSquare(BuildContext context, String image) {
  return Container(
    height: 55,
    width: 55,
    decoration: BoxDecoration(
      boxShadow: kElevationToShadow[2],
      color: AppColors.primaryColor,
      borderRadius: BorderRadius.circular(8),
      // border: Border.all(
      //   color: AppColors.primaryColor,
      //   width: 0,
      // ),
      image: DecorationImage(
        image: NetworkImage(image),
        fit: BoxFit.cover,
      ),
    ),
  );
}
