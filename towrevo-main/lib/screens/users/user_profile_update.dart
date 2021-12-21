import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/screens/colors/towrevo_appcolor.dart';
import 'package:towrevo/utilities.dart';
import 'package:towrevo/view_model/edit_profile_view_model.dart';
import 'package:towrevo/widgets/company_form_field.dart';
import 'package:towrevo/widgets/form_button_widget.dart';
import 'package:towrevo/widgets/full_background_image.dart';
import 'package:towrevo/widgets/profile_widget.dart';

import '../../error_getter.dart';

class UserProfileUpdate extends StatefulWidget {
  const UserProfileUpdate({Key? key}) : super(key: key);
  static const routeName = '/edit-profile';

  @override
  _UserProfileUpdateState createState() => _UserProfileUpdateState();
}

class _UserProfileUpdateState extends State<UserProfileUpdate> {
  TextEditingController controller1 = TextEditingController();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    final provider = Provider.of<EditProfileViewModel>(context, listen: false);
    provider.body = {};
    provider.getEditData();
    super.initState();
  }

  setFields(EditProfileViewModel provider) {
    print('in');
    firstNameController.text = (provider.body['first_name'] ?? '').toString();
    lastNameController.text = (provider.body['last_name'] ?? '').toString();
    emailController.text = (provider.body['email'] ?? '').toString();
    phoneNumberController.text = (provider.body['phone'] ?? '').toString();
  }

  validateAndUpdateForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    } else {
      final provider =
          Provider.of<EditProfileViewModel>(context, listen: false);
      provider.editProfileFields({
        'first_name': firstNameController.text.trim(),
        'last_name': lastNameController.text.trim(),
        'type': await Utilities().getSharedPreferenceValue('type')
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final editProvider =
        Provider.of<EditProfileViewModel>(context, listen: true);

    setFields(editProvider);

    return Scaffold(
      body: Stack(
        children: [
          const FullBackgroundImage(),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Padding(
                //   padding: const EdgeInsets.symmetric(
                //     horizontal: 20,
                //     vertical: 30,
                //   ),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: const [
                //       Text('Cancel'),
                //       Text('Edit Profile'),
                //       Text('Update'),
                //     ],
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 15.0),
                  child: IconButton(
                    icon: const Icon(FontAwesomeIcons.arrowLeft,
                        color: Colors.white, size: 20.0),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                FadeInDown(
                  from: 15,
                  delay: const Duration(milliseconds: 500),
                  child: Center(
                    child: Text(
                      'EDIT PROFILE',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 30.0,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 5,
                        ),

                        const ProfileTowrevo(),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFieldForAll(
                          errorGetter: ErrorGetter().firstNameErrorGetter,
                          hintText: 'First Name',
                          prefixIcon: const Icon(
                            FontAwesomeIcons.userAlt,
                            color: Color(0xFF019aff),
                            size: 20.0,
                          ),
                          textEditingController: firstNameController,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFieldForAll(
                          errorGetter: ErrorGetter().lastNameErrorGetter,
                          hintText: 'Last Name',
                          prefixIcon: const Icon(
                            FontAwesomeIcons.userAlt,
                            color: Color(0xFF019aff),
                            size: 20.0,
                          ),
                          textEditingController: lastNameController,
                        ),
                        // CompanyTextAreaField(
                        //   errorGetter:
                        //       ErrorGetter().companyDescriptionErrorGetter,
                        //   hintText: 'Company Description',
                        //   prefixIcon: const Icon(
                        //     FontAwesomeIcons.solidBuilding,
                        //     color: Color(0xFF019aff),
                        //     size: 20.0,
                        //   ),
                        //   textEditingController: controller1,
                        // ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFieldForAll(
                          errorGetter: ErrorGetter().emailErrorGetter,
                          hintText: 'Email Address',
                          prefixIcon: const Icon(
                            FontAwesomeIcons.solidEnvelopeOpen,
                            color: Color(0xFF019aff),
                            size: 20.0,
                          ),
                          textEditingController: emailController,
                          fieldDisable: true,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFieldForAll(
                          errorGetter: ErrorGetter().phoneNumberErrorGetter,
                          fieldDisable: true,
                          hintText: 'Phone',
                          prefixIcon: const Icon(
                            FontAwesomeIcons.phoneAlt,
                            color: Color(0xFF019aff),
                            size: 20.0,
                          ),
                          textEditingController: phoneNumberController,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FormButtonWidget(
                          'UPDATE',
                          () {
                            validateAndUpdateForm();
                            // Navigator.of(context).pushNamed(RegistrationOTPScreen.routeName,arguments: false);
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
