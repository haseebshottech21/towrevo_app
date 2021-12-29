import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:towrevo/screens/colors/towrevo_appcolor.dart';

Container userEmptyProfile(BuildContext context) {
  return Container(
    width: 55,
    height: 55,
    decoration: BoxDecoration(
      color: Theme.of(context).primaryColor,
      border: Border.all(color: AppColors.primaryColor2, width: 2),
      borderRadius: BorderRadius.circular(50),
    ),
    child: const ClipOval(
      child: Center(
        child: Icon(
          FontAwesomeIcons.user,
          color: Colors.white,
          size: 32,
        ),
      ),
    ),
  );
}
