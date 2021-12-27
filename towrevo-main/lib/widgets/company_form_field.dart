import 'package:flutter/material.dart';
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
      // textAlign: TextAlign.left,
      // validator: widget.validator,
      decoration: InputDecoration(
        // contentPadding: const EdgeInsets.all(10.0),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          // borderSide: const BorderSide(color: Color(0xFF000000)),
          borderRadius: BorderRadius.circular(30.0),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.black87),
        // hintStyle: GoogleFonts.montserrat(color: Colors.black),
        // isDense: true,
        // helperText: 'Keep it short, this is just a demo.',
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: prefixIcon,
        ),
        //     SizedBox(
        //   width: prefixPhone ? 70 : 50,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Padding(
        //         padding: const EdgeInsets.only(left: 20),
        //         child: prefixIcon,
        //       ),
        //       if (prefixPhone)
        //         const Padding(
        //           padding: EdgeInsets.zero,
        //           child: Text(
        //             ' +1',
        //             style: TextStyle(color: Colors.black54, fontSize: 17),
        //           ),
        //         ),
        //     ],
        //   ),
        // ),
        prefixText: '  ',
        prefixStyle: const TextStyle(color: Colors.black, fontSize: 16),
        // suffixIcon: suffixIcon,
        // suffixText: 'USD',
        // suffixStyle: const TextStyle(color: Colors.green)),
      ),
      onSaved: (newValue) {
        textEditingController.text = newValue!;
      },
      validator: (value) => errorGetter(value),
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
      // textAlign: TextAlign.left,
      decoration: InputDecoration(
        // contentPadding: const EdgeInsets.all(10.0),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xFF29abe7),
            ),
            borderRadius: BorderRadius.circular(30.0)),
        hintText: hintText,
        hintStyle: GoogleFonts.montserrat(color: Colors.black),
        // isDense: true,
        // helperText: 'Keep it short, this is just a demo.',
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 15, bottom: 75),
          child: prefixIcon,
        ),
        prefixText: ' ',
        // suffixIcon: suffixIcon,
        // suffixText: 'USD',
        // suffixStyle: const TextStyle(color: Colors.green)),
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
      // textAlign: TextAlign.left,
      decoration: InputDecoration(
        // contentPadding: const EdgeInsets.all(10.0),
        filled: true,
        fillColor: const Color(0xFFfff6f7),
        border: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF29abe7)),
            borderRadius: BorderRadius.circular(30.0)),
        hintText: hintText,
        hintStyle: GoogleFonts.montserrat(color: Colors.black),
        // isDense: true,
        // helperText: 'Keep it short, this is just a demo.',
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: prefixIcon,
        ),
        prefixText: '  ',
        // suffixIcon: Padding(
        //   padding: const EdgeInsets.only(right: 10),
        //   child: suffixIcon,
        // ),
        // suffixText: 'USD',
        // suffixStyle: const TextStyle(color: Colors.green)),
      ),
    );
  }
}
