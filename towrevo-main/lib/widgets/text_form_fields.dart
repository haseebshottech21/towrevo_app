import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldForAll extends StatelessWidget {
  final String hintText;
  final Icon? prefixIcon;
  final TextEditingController textEditingController;
  final Function errorGetter;
  final bool fieldDisable;
  final bool prefixPhone;
  final TextInputType textInputType;

  const TextFieldForAll({
    required this.hintText,
    required this.errorGetter,
    required this.prefixIcon,
    required this.textEditingController,
    required this.textInputType,
    Key? key,
    this.fieldDisable = false,
    this.prefixPhone = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      textAlignVertical: TextAlignVertical.center,
      enabled: fieldDisable ? false : true,
      enableInteractiveSelection: true,
      keyboardType: textInputType,
      readOnly: false,
      toolbarOptions: const ToolbarOptions(
        paste: true,
        cut: true,
        selectAll: true,
        copy: true,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.black87),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: prefixIcon,
        ),
        prefixText: '  ',
        prefixStyle: const TextStyle(color: Colors.black, fontSize: 16),
      ),
      onSaved: (newValue) {
        textEditingController.text = newValue!;
      },
      validator: (value) => errorGetter(value),
    );
  }
}

class PhoneField extends StatelessWidget {
  final String hintText;
  final TextEditingController textEditingController;
  final Function errorGetter;
  final bool fieldDisable;
  const PhoneField({
    required this.hintText,
    required this.textEditingController,
    required this.errorGetter,
    this.fieldDisable = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      enabled: !fieldDisable,
      enableInteractiveSelection: true,
      readOnly: false,
      toolbarOptions: const ToolbarOptions(
        paste: true,
        cut: true,
        selectAll: true,
        copy: true,
      ),
      keyboardType: TextInputType.phone,
      onSaved: (newValue) {
        textEditingController.text = newValue!;
      },
      validator: (value) => errorGetter(value),
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.black87),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        prefixIcon: const Padding(
          padding: EdgeInsets.only(bottom: 2),
          child: Center(
            widthFactor: 0.0,
            child: Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                '  🇺🇸 +1 ',
                style: TextStyle(fontSize: 15.5),
              ),
            ),
          ),
        ),
        prefixText: '   ',
      ),
    );
  }
}

class CompanyTextAreaField extends StatelessWidget {
  final String hintText;
  final Icon? prefixIcon;
  final Function errorGetter;
  final TextEditingController textEditingController;
  const CompanyTextAreaField(
      {required this.errorGetter,
      required this.hintText,
      required this.prefixIcon,
      required this.textEditingController,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      minLines:
          5, // any number you need (It works as the rows for the textarea)
      keyboardType: TextInputType.multiline,
      maxLines: null,
      textAlignVertical: TextAlignVertical.center,

      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xFF29abe7),
            ),
            borderRadius: BorderRadius.circular(30.0)),
        hintText: hintText,
        hintStyle: GoogleFonts.montserrat(color: Colors.black),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 15, bottom: 75),
          child: prefixIcon,
        ),
        prefixText: ' ',
      ),
      onSaved: (newValue) {
        textEditingController.text = newValue!;
      },
      validator: (value) => errorGetter(value),
    );
  }
}

class CompanySearchField extends StatelessWidget {
  final VoidCallback clickCallback;
  final String hintText;
  final Icon? prefixIcon;
  final GestureDetector? suffixIcon;
  const CompanySearchField(
      this.clickCallback, this.hintText, this.prefixIcon, this.suffixIcon,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: clickCallback,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFfff6f7),
        border: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF29abe7)),
            borderRadius: BorderRadius.circular(30.0)),
        hintText: hintText,
        hintStyle: GoogleFonts.montserrat(color: Colors.black),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: prefixIcon,
        ),
        prefixText: '  ',
      ),
    );
  }
}

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
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: prefixIcon,
          ),
          prefixText: '  ',
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
