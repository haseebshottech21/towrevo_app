import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TextFormIconWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final TextEditingController? confirmPassword;
  final bool obscureText;
  final Icon prefixIcon;
  final String hint;
  final Function() onPress;
  final Function errorGetter;
  const TextFormIconWidget({
    this.confirmPassword,
    required this.errorGetter,
    required this.textEditingController,
    required this.obscureText,
    required this.hint,
    required this.prefixIcon,
    required this.onPress,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: textEditingController,
        obscureText: obscureText,
        enableInteractiveSelection: true,
        readOnly: false,
        toolbarOptions: const ToolbarOptions(
          paste: true,
          cut: true,
          selectAll: true,
          copy: true,
        ),
        // maxLength: 8,
        // onSaved: (val) => _password = val,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF006eb6), width: 2),
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
