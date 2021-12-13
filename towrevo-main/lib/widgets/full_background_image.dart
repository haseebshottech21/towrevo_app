import 'package:flutter/material.dart';

class FullBackgroundImage extends StatelessWidget {
  const FullBackgroundImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/fullbg.jpg'), fit: BoxFit.fill),
      ),
    );
  }
}
