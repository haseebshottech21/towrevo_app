import 'package:flutter/material.dart';

class TowrevoLogo extends StatelessWidget {
  const TowrevoLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.18,
        width: MediaQuery.of(context).size.width * 0.48,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/logo.png'),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}

class TowrevoLogoSmall extends StatelessWidget {
  const TowrevoLogoSmall({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.15,
        width: MediaQuery.of(context).size.width * 0.34,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/logo.png'),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}

class TowrevoLogoExtraSmall extends StatelessWidget {
  const TowrevoLogoExtraSmall({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.11,
        width: MediaQuery.of(context).size.width * 0.27,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/logo.png'),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
