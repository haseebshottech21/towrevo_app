import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:towrevo/screens/colors/towrevo_appcolor.dart';

class FromToLocation extends StatelessWidget {
  final String fromLocationText;
  final String toLocationText;
  final Function() fromOnTap;
  final Function() toOnTap;

  const FromToLocation({
    required this.fromLocationText,
    required this.toLocationText,
    required this.fromOnTap,
    required this.toOnTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.my_location,
              size: 25,
              color: Colors.white,
            ),
            const SizedBox(height: 8),
            Container(
              height: 5,
              width: 5,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Text(""),
            ),
            const SizedBox(height: 8),
            Container(
              height: 5,
              width: 5,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Text(""),
            ),
            const SizedBox(height: 8),
            Container(
              height: 5,
              width: 5,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Text(""),
            ),
            const SizedBox(height: 8),
            Container(
              height: 5,
              width: 5,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Text(""),
            ),
            const SizedBox(height: 8),
            const Icon(
              FontAwesomeIcons.mapMarkerAlt,
              size: 25,
              color: Colors.white,
            ),
          ],
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.only(
            top: 12,
            bottom: 12,
            left: 10,
            right: 15,
            // horizontal: 15,
          ),
          width: MediaQuery.of(context).size.width * 0.76,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: kElevationToShadow[4],
          ),
          child: Column(
            children: [
              locationBox(
                context: context,
                title: 'Where From?',
                location: fromLocationText,
                onTap: fromOnTap,
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.62,
                    child: const Divider(
                      thickness: 0.5,
                      height: 5,
                      color: Colors.black54,
                    ),
                  ),
                  Icon(
                    FontAwesomeIcons.retweet,
                    size: 16,
                    color: AppColors.primaryColor2,
                  )
                ],
              ),
              const SizedBox(height: 4),
              locationBox(
                context: context,
                title: 'Where To?',
                location: toLocationText,
                onTap: toOnTap,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget locationBox({
    required BuildContext context,
    required String title,
    required String location,
    required Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.65,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: AppColors.primaryColor2,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  location,
                  // : getLocation.getAddress,
                  style: GoogleFonts.montserrat(
                    color: Colors.black87,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          // Icon(
          //   Icons.map,
          //   size: 25,
          //   color: AppColors.primaryColor,
          // ),
        ],
      ),
    );
  }
}
