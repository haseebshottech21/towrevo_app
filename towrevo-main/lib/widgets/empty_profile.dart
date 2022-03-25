import 'package:flutter/material.dart';
import 'package:towrevo/utilities/towrevo_appcolor.dart';

class EmptyProfile extends StatelessWidget {
  const EmptyProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        boxShadow: kElevationToShadow[2],
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(
        Icons.person,
        size: 30,
        color: Colors.white,
      ),
    );
  }
}
