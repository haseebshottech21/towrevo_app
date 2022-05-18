import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/error_getter.dart';
import 'package:towrevo/utilities/utilities.dart';
import 'package:towrevo/view_model/view_model.dart';
// import 'package:towrevo/widgets/services_days_and_description_check_box/selector_widget.dart';
import 'package:towrevo/widgets/widgets.dart';
import 'package:towrevo/screens/screens.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  // final companyDescriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void validateFromAndSaveData() {
    final _companySignUpProvider =
        Provider.of<RegisterCompanyViewModel>(context, listen: false);
    if (!_formKey.currentState!.validate()) {
      return;
    } else if (_companySignUpProvider.body['image'].toString().isEmpty) {
      Fluttertoast.showToast(msg: 'Please Enter Image');
      return;
    } else if (_companySignUpProvider.servicesDescription().isEmpty) {
      Fluttertoast.showToast(msg: 'Please Select Description');
      return;
    } else {
      _companySignUpProvider.body['first_name'] = companyNameController.text;
      _companySignUpProvider.body['description'] =
          _companySignUpProvider.servicesDescription().trim() +
              (descriptionController.text.isNotEmpty
                  ? 'Other' + descriptionController.text.trim()
                  : '');
      Navigator.of(context).pushNamed(RegistrationCredentialScreen.routeName);
    }
  }

  final descriptionController = TextEditingController();

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
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 30.h,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 50.h),
                    FadeInDown(
                      from: 15,
                      delay: const Duration(milliseconds: 500),
                      child: const CompanySignUpTitle(),
                    ),
                    SizedBox(height: 25.h),
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
                                      width: 120.w,
                                      height: 105.h,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF09365f),
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      child: imagePicker.body['image'] == ''
                                          ? Icon(
                                              FontAwesomeIcons.building,
                                              color:
                                                  Colors.white.withOpacity(0.5),
                                              size: 75.sp,
                                            )
                                          : ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10.r),
                                              ),
                                              child: Image.file(
                                                File(imagePicker.imagePath),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                    ),
                                    Positioned(
                                      left: 85.w,
                                      top: 75.h,
                                      child: Container(
                                        width: 35.w,
                                        height: 30.h,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF019aff),
                                          borderRadius:
                                              BorderRadius.circular(5.r),
                                        ),
                                        child: Icon(FontAwesomeIcons.camera,
                                            color: Colors.white, size: 18.sp),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                          SizedBox(height: 15.h),
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
                          SizedBox(height: 8.h),
                          Consumer<RegisterCompanyViewModel>(
                            builder: (ctx, registerViewModel, neverBuildChild) {
                              return SelectorWidget(
                                context: context,
                                delayMilliseconds: 570,
                                title: Utilities.getDesc(
                                    registerViewModel, descriptionController),
                                height: registerViewModel
                                        .servicesDescription()
                                        .contains('\n')
                                    ? null
                                    : 50.h,
                                icon: FontAwesomeIcons.solidBuilding,
                                // trailingIcon: FontAwesomeIcons.solidBuilding,
                                onTap: () {
                                  showServiceDescription(
                                    registerViewModel,
                                    context,
                                    true,
                                    descriptionController,
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    FadeInDown(
                      from: 35,
                      delay: const Duration(milliseconds: 700),
                      child: Container(
                        margin: EdgeInsets.only(top: 35.h),
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            StepFormButtonNext(
                              onPressed: () {
                                validateFromAndSaveData();
                              },
                              text: 'NEXT',
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
    provider.initalize();
    super.initState();
  }
}
