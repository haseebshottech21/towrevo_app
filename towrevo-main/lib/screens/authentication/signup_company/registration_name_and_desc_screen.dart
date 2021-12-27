import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/error_getter.dart';
import 'package:towrevo/utilities.dart';
import 'package:towrevo/view_model/register_company_view_model.dart';
import 'package:towrevo/widgets/back_icon.dart';
import '/screens/authentication/signup_company/registration_crediential_screen.dart';
import '/widgets/company_form_field.dart';
import '/widgets/form_button_widget.dart';
import '/widgets/background_image.dart';
import 'signup_company_widegts/title_widget.dart';

class RegistrationNameAndDescScreen extends StatefulWidget {
  const RegistrationNameAndDescScreen({Key? key}) : super(key: key);
  static const routeName = '/name-and-description';

  @override
  State<RegistrationNameAndDescScreen> createState() =>
      _RegistrationNameAndDescScreenState();
}

class _RegistrationNameAndDescScreenState
    extends State<RegistrationNameAndDescScreen> {
  final companyNameController = TextEditingController();
  final companyDescriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void validateFromAndSaveData() {
    final _companySignUpProvider =
        Provider.of<RegisterCompanyViewModel>(context, listen: false);
    if (!_formKey.currentState!.validate()) {
      return;
    } else if (_companySignUpProvider.body['image'].toString().isEmpty) {
      Utilities().showToast('Please Enter Image');

      return;
    } else {
      _companySignUpProvider.body['first_name'] = companyNameController.text;
      _companySignUpProvider.body['description'] =
          companyDescriptionController.text;
      print(_companySignUpProvider.body);
      Navigator.of(context).pushNamed(RegistrationCredentialScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            const BackgroundImage(),
            backIcon(context, () {
              Navigator.pop(context);
            }),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 30.0,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    FadeInDown(
                      from: 15,
                      delay: const Duration(milliseconds: 500),
                      child: companyTitle(),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Consumer<RegisterCompanyViewModel>(
                              builder: (ctx, imagePicker, neverBuildChild) {
                            return FadeInDown(
                              from: 20,
                              delay: const Duration(milliseconds: 600),
                              child: GestureDetector(
                                onTap: () {
                                  imagePicker.pickImage();
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      width: 120,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF09365f),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: imagePicker.body['image'] == ''
                                          ? Icon(FontAwesomeIcons.building,
                                              color:
                                                  Colors.white.withOpacity(0.5),
                                              size: 75.0)
                                          : ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(20)),
                                              child: Image.file(
                                                File(imagePicker.imagePath),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                    ),
                                    Positioned(
                                      left: 85,
                                      top: 85,
                                      child: Container(
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF019aff),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        child: const Icon(
                                            FontAwesomeIcons.camera,
                                            color: Colors.white,
                                            size: 18.0),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                          const SizedBox(
                            height: 20,
                          ),
                          FadeInDown(
                            from: 25,
                            delay: const Duration(milliseconds: 650),
                            child: TextFieldForAll(
                              errorGetter: ErrorGetter().companyNameErrorGetter,
                              hintText: 'Company Name',
                              prefixIcon: const Icon(
                                FontAwesomeIcons.userAlt,
                                color: Color(0xFF019aff),
                                size: 20.0,
                              ),
                              textEditingController: companyNameController,
                              textInputType: TextInputType.name,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          FadeInDown(
                            from: 30,
                            delay: const Duration(milliseconds: 700),
                            child: CompanyTextAreaField(
                              errorGetter:
                                  ErrorGetter().companyDescriptionErrorGetter,
                              hintText: 'Company Description',
                              prefixIcon: const Icon(
                                FontAwesomeIcons.solidBuilding,
                                color: Color(0xFF019aff),
                                size: 20.0,
                              ),
                              textEditingController:
                                  companyDescriptionController,
                            ),
                          ),
                        ],
                      ),
                    ),
                    FadeInDown(
                      from: 35,
                      delay: const Duration(milliseconds: 700),
                      child: Container(
                        margin: const EdgeInsets.only(top: 40),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // StepFormButtonBack(() => () {}, 'BACK'),
                            StepFormButtonNext(
                              () {
                                validateFromAndSaveData();
                              },
                              'NEXT',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    final provider =
        Provider.of<RegisterCompanyViewModel>(context, listen: false);
    provider.initalizeImageValues();
    super.initState();
  }
}
