import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        SizedBox(width: 5.w),
        Icon(
          FontAwesomeIcons.solidQuestionCircle,
          size: 18.sp,
          color: Colors.white,
        ),
        SizedBox(width: 8.w),
        SizedBox(
          width: ScreenUtil().screenWidth * 0.76,
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
                fontSize: 10.sp,
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
                borderRadius: BorderRadius.circular(10.r),
              ),
              hintText: 'Describe Your Problem....',
              hintStyle: GoogleFonts.montserrat(
                color: Colors.black54,
                fontWeight: FontWeight.w500,
                fontSize: 13.sp,
              ),
              prefixText: ' ',
            ),
          ),
        ),
      ],
    );
  }
}
