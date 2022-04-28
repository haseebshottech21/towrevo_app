import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DrawerListItem extends StatelessWidget {
  final IconData iconsData;
  final String title;
  final VoidCallback onPressed;

  const DrawerListItem({
    Key? key,
    required this.iconsData,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        iconsData,
        size: 20.sp,
        color: Theme.of(context).primaryColor,
      ),
      title: Text(
        title,
        // style: const TextStyle(color: Colors.white, fontSize: 20),
        style: GoogleFonts.montserrat(
          color: Colors.white,
          fontSize: 17.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
      onTap: onPressed,
    );
  }
}
