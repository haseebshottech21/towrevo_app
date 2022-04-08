import 'package:flutter/material.dart';
import '../utilities/towrevo_appcolor.dart';

Container profileImageCircle(BuildContext context, String image) {
  return Container(
    width: MediaQuery.of(context).size.height * 0.055,
    height: MediaQuery.of(context).size.height * 0.055,
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
      image: DecorationImage(
        image: NetworkImage(image),
        fit: BoxFit.cover,
      ),
    ),
  );
}
