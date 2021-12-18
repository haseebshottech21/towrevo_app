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
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.14,
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.15,
            height: MediaQuery.of(context).size.height * 0.08,
            decoration: BoxDecoration(
              border:
                  Border.all(color: Theme.of(context).primaryColor, width: 1.5),
              borderRadius: BorderRadius.circular(50),
              image: DecorationImage(
                image: NetworkImage(
                  profileImage,
                ),
                fit: BoxFit.fill,
              ),
            ),
            // child: Image.network(
            //   'https://images.pexels.com/photos/1704488/pexels-photo-1704488.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
            //   fit: BoxFit.fill,
            // ),
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
              const SizedBox(height: 5),
              Text(
                profileEmail,
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
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
