import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: MediaQuery.of(context).size.height * 0.14,
      child: Row(
        children: [
          profileImage,
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                profileName,
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 3),
              Container(
                margin: const EdgeInsets.only(right: 12),
                width: MediaQuery.of(context).size.width * 0.45,
                child: Text(
                  profileEmail,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: editOnPressed,
            child: const FaIcon(
              FontAwesomeIcons.edit,
              color: Colors.white,
              size: 18,
            ),
          )
        ],
      ),
    );
  }
}
