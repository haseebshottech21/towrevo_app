import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/error_getter.dart';
import 'package:towrevo/view_model/view_model.dart';
import 'package:towrevo/widgets/widgets.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);
  static const routeName = '/forget-password';

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void validateAndSendForgotPassword(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final loginProvider = Provider.of<LoginViewModel>(context, listen: false);
    await loginProvider.forgotPassword(_emailController.text.trim(), context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Background Image
            const BackgroundImage(),
            // Back Icon
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
                      height: 5,
                    ),
                    const TowrevoLogo(),
                    const SizedBox(
                      height: 45,
                    ),
                    Text(
                      'RESET PASSWORD',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 25.0,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Enter the email associated with your account and we\'ll send an email with instructions to reset your password.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        color: const Color(0xFF0c355a),
                        fontWeight: FontWeight.w600,
                        fontSize: 15.0,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldForAll(
                      errorGetter: ErrorGetter().emailErrorGetter,
                      hintText: 'Email Address',
                      prefixIcon: const Icon(
                        FontAwesomeIcons.solidEnvelopeOpen,
                        color: Color(0xFF019aff),
                        size: 20.0,
                      ),
                      textEditingController: _emailController,
                      textInputType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Email sents to example@email.com',
                      textAlign: TextAlign.start,
                      style: GoogleFonts.montserrat(
                        color: const Color(0xFF0c355a),
                        fontWeight: FontWeight.w500,
                        fontSize: 15.0,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {
                          validateAndSendForgotPassword(context);
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.060,
                          width: MediaQuery.of(context).size.width * 0.70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            gradient: const LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xFF0195f7),
                                Color(0xFF083054),
                              ],
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'SEND VERIFICATION',
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 17.0,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Consumer<LoginViewModel>(
              builder: (ctx, loginViewMode, neverUpdate) {
                return loginViewMode.isLoading
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: circularProgress())
                    : const SizedBox();
              },
            )
          ],
        ),
      ),
    );
  }
}
