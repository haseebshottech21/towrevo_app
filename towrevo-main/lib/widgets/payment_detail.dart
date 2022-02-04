import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget paymentDetail(String description) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Icon(Icons.check_box, color: Colors.white),
        const SizedBox(width: 20),
        Expanded(
          child: Text(
            description,
            // maxLines: 2,
            // overflow: TextOverflow.ellipsis,
            // softWrap: false,
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
      ],
    ),
  );
}
