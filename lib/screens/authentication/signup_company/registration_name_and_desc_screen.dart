import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/error_getter.dart';
import 'package:towrevo/utilities.dart';
import 'package:towrevo/view_model/register_company_view_model.dart';
import '/screens/authentication/signup_company/registration_crediential_screen.dart';
import '/widgets/company_form_field.dart';
import '/widgets/form_button_widget.dart';
import '/widgets/background_image.dart';
class RegistrationNameAndDescScreen extends StatefulWidget {

  const RegistrationNameAndDescScreen({Key? key}) : super(key: key);
  static const routeName = '/name-and-description';

  @override
  State<RegistrationNameAndDescScreen> createState() => _RegistrationNameAndDescScreenState();
}

class _RegistrationNameAndDescScreenState extends State<RegistrationNameAndDescScreen> {

  final companyNameController = TextEditingController();
  final companyDescriptionController = TextEditingController();
  final  _formKey = GlobalKey<FormState>();

  void validateFromAndSaveData(){
    final _companySignUpProvider = Provider.of<RegisterCompanyViewModel>(context,listen: false);
    if(!_formKey.currentState!.validate()){
      return;
    }else if(_companySignUpProvider.body['image'].toString().isEmpty){
      Utilities().showToast('Please Enter Image');

      return;
    }else{
      _companySignUpProvider.body['first_name'] =  companyNameController.text;
      _companySignUpProvider.body['description'] = companyDescriptionController.text;
      print(_companySignUpProvider.body);
      Navigator.of(context).pushNamed(RegistrationCredentialScreen.routeName);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(children: [
          const BackgroundImage(),
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
          Container(
            alignment: Alignment.center,
            padding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Form(
              key: _formKey,
              child: Column(children: [
                const SizedBox(
                  height: 50,
                ),
                Text(
                  'COMPANY \nREGISTRATION',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 30.0,
                      letterSpacing: 2),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Consumer<RegisterCompanyViewModel>(builder: (ctx,imagePicker,neverBuildChild){
                        return GestureDetector(
                          onTap: (){
                            imagePicker.pickImage();
                          },
                          child: Stack(
                            children: [
                              Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF09365f),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: imagePicker.body['image'] == ''? Icon(FontAwesomeIcons.building,
                                    color: Colors.white.withOpacity(0.5), size: 75.0):
                                ClipRRect(borderRadius: const BorderRadius.all(Radius.circular(20)),child: Image.file(File(imagePicker.imagePath),fit: BoxFit.fill,),),
                              ),
                              Positioned(
                                left: 85,
                                top: 85,
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF019aff),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: const Icon(FontAwesomeIcons.camera,
                                      color: Colors.white, size: 18.0),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),

                      const SizedBox(
                        height: 20,
                      ),
                      TextFieldForAll(errorGetter: ErrorGetter().companyNameErrorGetter,hintText: 'Company Name', prefixIcon: const Icon(
                        FontAwesomeIcons.userAlt,
                        color: Color(0xFF019aff),
                        size: 20.0,
                      ),textEditingController: companyNameController,),
                      const SizedBox(
                        height: 10,
                      ),
                       CompanyTextAreaField(
                         errorGetter: ErrorGetter().companyDescriptionErrorGetter,
                        hintText: 'Company Description',
                        prefixIcon: const Icon(
                          FontAwesomeIcons.solidBuilding,
                          color: Color(0xFF019aff),
                          size: 20.0,
                        ),
                        textEditingController: companyDescriptionController,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 40),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // StepFormButtonBack(() => () {}, 'BACK'),
                      StepFormButtonNext(() {
                        validateFromAndSaveData();
                      }, 'NEXT'),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ]),
      ),
    );
  }

}
