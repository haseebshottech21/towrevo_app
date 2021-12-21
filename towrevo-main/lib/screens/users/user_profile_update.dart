import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:towrevo/screens/colors/towrevo_appcolor.dart';
import 'package:towrevo/widgets/company_form_field.dart';

import '../../error_getter.dart';

class UserProfileUpdate extends StatefulWidget {
  const UserProfileUpdate({Key? key}) : super(key: key);

  @override
  _UserProfileUpdateState createState() => _UserProfileUpdateState();
}

class _UserProfileUpdateState extends State<UserProfileUpdate> {
  TextEditingController controller1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/fullbg.jpg'),
              fit: BoxFit.fill,
            ),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Cancel'),
                    Text('Edit Profile'),
                    Text('Update'),
                  ],
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      color: AppColors.primaryColor,
                    ),
                    TextFieldForAll(
                      errorGetter: ErrorGetter().firstNameErrorGetter,
                      hintText: 'First Name',
                      prefixIcon: const Icon(
                        FontAwesomeIcons.userAlt,
                        color: Color(0xFF019aff),
                        size: 20.0,
                      ),
                      textEditingController: controller1,
                    ),
                    TextFieldForAll(
                      errorGetter: ErrorGetter().firstNameErrorGetter,
                      hintText: 'First Name',
                      prefixIcon: const Icon(
                        FontAwesomeIcons.userAlt,
                        color: Color(0xFF019aff),
                        size: 20.0,
                      ),
                      textEditingController: controller1,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
