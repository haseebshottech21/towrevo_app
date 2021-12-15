import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFormIconWidget extends StatelessWidget {
  TextEditingController textEditingController;
  TextEditingController? confirmPassword;
  bool obscureText;
  Icon prefixIcon;
  String hint;
  Function() onPress;
  Function errorGetter;
  TextFormIconWidget(
      {this.confirmPassword,
      required this.errorGetter,
      required this.textEditingController,
      required this.obscureText,
      required this.hint,
      required this.prefixIcon,
      required this.onPress,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: textEditingController,
        obscureText: obscureText,
        // maxLength: 8,
        // onSaved: (val) => _password = val,
        textAlignVertical: TextAlignVertical.center,
        // decoration: InputDecoration(
        //   // contentPadding: const EdgeInsets.all(10.0),
        //   border: OutlineInputBorder(
        //       borderSide: const BorderSide(color: Colors.teal),
        //       borderRadius: BorderRadius.circular(30.0)),
        //   filled: true,
        //   fillColor: const Color(0xFFfff6f7),
        //   hintText: hint,
        //   hintStyle: GoogleFonts.montserrat(color: Colors.black),
        //   prefixIcon: Padding(
        //     padding: const EdgeInsets.only(left: 15),
        //     child: prefixIcon,
        //   ),
        //   // prefixText: '  ',
        //   suffixIcon: GestureDetector(
        //     onTap: onPress,
        //     child: Padding(
        //       padding: const EdgeInsets.only(right: 20),
        //       child: Icon(
        //         obscureText
        //             ? FontAwesomeIcons.solidEyeSlash
        //             : FontAwesomeIcons.solidEye,
        //       ),
        //     ),
        //   ),
        // ),
        decoration: InputDecoration(
          // contentPadding: const EdgeInsets.all(10.0),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xFF000000),
            ),
            borderRadius: BorderRadius.circular(30.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: const Color(0xFF092848).withOpacity(0.9),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(30.0),
          ),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.black),
          // hintStyle: GoogleFonts.montserrat(color: Colors.black),
          // isDense: true,
          // helperText: 'Keep it short, this is just a demo.',
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: prefixIcon,
          ),
          prefixText: '  ',
          // suffixIcon: suffixIcon,
          // suffixText: 'USD',
          // suffixStyle: const TextStyle(color: Colors.green)),
          suffixIcon: GestureDetector(
            onTap: onPress,
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Icon(
                obscureText
                    ? FontAwesomeIcons.solidEyeSlash
                    : FontAwesomeIcons.solidEye,
              ),
            ),
          ),
        ),
        onSaved: (newValue) {
          textEditingController.text = newValue!;
        },
        validator: (value) {
          print(confirmPassword != null);
          if (confirmPassword != null) {
            return errorGetter(value, confirmPassword!.text);
          } else {
            return errorGetter(
              value,
            );
          }
        });
  }
}
