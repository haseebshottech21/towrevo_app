import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerProfile extends StatelessWidget {
  final String profileImage;
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      // width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.14,
      child: Row(
        children: [
          // CircleAvatar(
          //   radius: 30.0,
          //   foregroundColor: Colors.white,
          //   // backgroundImage: NetworkImage(profileImage),
          //   backgroundColor: Colors.transparent,
          //   child: Image.network(profileImage),
          // ),
          ClipOval(
            child: Image.network(
              profileImage,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
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
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Text(
                  profileEmail,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: editOnPressed,
            child: const FaIcon(
              FontAwesomeIcons.edit,
              color: Colors.white,
              size: 20,
            ),
          )
        ],
      ),
    );
  }
}
