import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class DescribeProblemField extends StatelessWidget {
  final TextEditingController describeController;
  const DescribeProblemField({
    Key? key,
    required this.describeController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 5),
        const Icon(
          FontAwesomeIcons.solidQuestionCircle,
          size: 20,
          color: Colors.white,
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.76,
          child: TextFormField(
            controller: describeController,
            minLines:
                3, // any number you need (It works as the rows for the textarea)
            keyboardType: TextInputType.multiline,
            maxLines: null,
            maxLength: 150,
            buildCounter: (context,
                    {required currentLength, required isFocused, maxLength}) =>
                Text(
              '$currentLength/$maxLength',
              style: GoogleFonts.lato(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
            textAlignVertical: TextAlignVertical.center,

            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0xFF29abe7),
                  ),
                  borderRadius: BorderRadius.circular(10.0)),
              hintText: 'Describe Your Problem....',
              hintStyle: GoogleFonts.montserrat(
                color: Colors.black54,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
              prefixText: ' ',
            ),
          ),
        ),
      ],
    );
  }
}
