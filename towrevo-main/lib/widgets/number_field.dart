import 'package:flutter/material.dart';

class NumberField extends StatelessWidget {
  final String hintText;
  final TextEditingController textEditingController;
  final Function errorGetter;
  final bool fieldDisable;
  const NumberField({
    required this.hintText,
    required this.textEditingController,
    required this.errorGetter,
    this.fieldDisable = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 5),
            child: Text(
              '🇺🇸 +1',
              style: TextStyle(
                fontSize: 15.5,
              ),
            ),
          ),
          // const SizedBox(width: 5),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
            child: TextFormField(
              controller: textEditingController,
              enabled: fieldDisable,
              // obscureText: obscureText,
              enableInteractiveSelection: true,
              readOnly: false,
              toolbarOptions: const ToolbarOptions(
                paste: true,
                cut: true,
                selectAll: true,
                copy: true,
              ),
              // maxLength: 10,
              // onSaved: (val) => _password = val,
              keyboardType: TextInputType.phone,
              // validator: (val) => ErrorGetter().validateMobile(val!),
              // onChanged: (value) {
              //   _mobile = value;
              // },
              // onSaved: (val) {
              //   _mobile = val!;
              // },
              onSaved: (newValue) {
                textEditingController.text = newValue!;
              },
              validator: (value) => errorGetter(value),

              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: const TextStyle(color: Colors.black87),
                // hintStyle: GoogleFonts.montserrat(color: Colors.black),
                // isDense: true,
                // helperText: 'Keep it short, this is just a demo.',
                // prefixIcon: Padding(
                //   padding: const EdgeInsets.only(left: 15),
                //   child: prefixIcon,
                // ),
                prefixText: ' ',
                // suffixIcon: suffixIcon,
                // suffixText: 'USD',
                // suffixStyle: const TextStyle(color: Colors.green)),
                // suffixIcon: GestureDetector(
                //   onTap: onPress,
                //   child: Padding(
                //     padding: const EdgeInsets.only(right: 20),
                //     child: Icon(
                //       obscureText
                //           ? FontAwesomeIcons.solidEyeSlash
                //           : FontAwesomeIcons.solidEye,
                //     ),
                //   ),
                // ),
              ),
              // onSaved: (newValue) {
              //   textEditingController.text = newValue!;
              // },
              // validator: (value) {
              //   print(confirmPassword != null);
              //   if (confirmPassword != null) {
              //     return errorGetter(value, confirmPassword!.text);
              //   } else {
              //     return errorGetter(
              //       value,
              //     );
              //   }
              // },
            ),
          ),
        ],
      ),
    );
  }
}
