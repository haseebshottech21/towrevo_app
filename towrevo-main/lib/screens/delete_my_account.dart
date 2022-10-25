import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/utilities/towrevo_appcolor.dart';
import 'package:towrevo/widgets/widgets.dart';
import '../view_model/delete_reason_view_model.dart';
// import '../widgets/back_icon.dart';
// import '../widgets/background_image.dart';
// import '../widgets/circular_progress_indicator.dart';

class CancelReasonModel with ChangeNotifier {
  final String title;
  bool isActive;
  CancelReasonModel({
    required this.title,
    required this.isActive,
  });
}

class DeleteMyAccount extends StatefulWidget {
  const DeleteMyAccount({Key? key}) : super(key: key);

  static const routeName = '/delete-account';

  @override
  State<DeleteMyAccount> createState() => _DeleteMyAccountState();
}

class _DeleteMyAccountState extends State<DeleteMyAccount> {
  final otherController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    final delete = Provider.of<DeleteViewModel>(context, listen: false);
    delete.reason = null;
    delete.selectRadio = null;
    otherController.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    final provider = Provider.of<DeleteViewModel>(context, listen: true);

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: ScreenUtil().screenHeight,
          width: ScreenUtil().screenWidth,
          child: Stack(
            children: [
              const FullBackgroundImage(),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: backIcon(context, () {
                            Navigator.of(context).pop();
                          }),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 32.h,
                            left: Platform.isAndroid
                                ? screenSize.width * 0.10.w
                                : 50.w,
                          ),
                          child: Text(
                            'DELETE ACCOUNT',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 20.sp,
                              letterSpacing: 1.w,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          Text(
                            'Are you sure you want to delete your account? Your profile will be disabled, but any reviews you\'ve given can still be seen.',
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16.h),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              'Tell us reason why you leaving : ',
                              style: GoogleFonts.montserrat(
                                color: AppColors.primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                              provider.selectReasons.length,
                              (index) {
                                return Row(
                                  children: [
                                    Radio(
                                      activeColor: Colors.white,
                                      value: index,
                                      groupValue: provider.selectRadio,
                                      onChanged: (value) {
                                        provider.selectRason(
                                          value: int.parse(value.toString()),
                                          index: index,
                                        );
                                      },
                                    ),
                                    Text(
                                      provider.selectReasons[index].title,
                                      style: GoogleFonts.montserrat(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                          Form(
                            key: _formKey,
                            child: provider.reason ==
                                    'Others - please tell us a bit more'
                                ? TextFormField(
                                    controller: otherController,
                                    maxLines: 3,
                                    validator: (val) {
                                      if (val.toString().isEmpty) {
                                        return 'Reason Required';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'Other Reason',
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                          ),
                          const SizedBox(height: 50),
                          provider.reason == null
                              ? const SizedBox()
                              : Consumer<DeleteViewModel>(
                                  builder: (context, reasonViewModel, _) {
                                    return Center(
                                      child: FormButtonWidget(
                                        formBtnTxt: 'Delete My Account',
                                        onPressed: () {
                                          if (!_formKey.currentState!
                                              .validate()) {
                                            return;
                                          }
                                          reasonViewModel.submitReason(
                                            controller: otherController,
                                          );
                                          showDialog(
                                            context: context,
                                            barrierDismissible:
                                                false, // user must tap button!
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                titlePadding:
                                                    const EdgeInsets.only(
                                                  top: 16,
                                                  left: 24,
                                                  bottom: 6,
                                                ),
                                                contentPadding:
                                                    const EdgeInsets.only(
                                                  top: 2,
                                                  bottom: 12,
                                                  left: 24,
                                                  right: 24,
                                                ),
                                                title: const Text('Delete'),
                                                content: const Text(
                                                  'Are you sure you want to delete your account ?',
                                                  style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: const Text(
                                                      'NO',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: const Text(
                                                      'YES',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      context
                                                          .read<
                                                              DeleteViewModel>()
                                                          .deleteMyAccount(
                                                            context: context,
                                                          );
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    );
                                  },
                                )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              provider.isLoading
                  ? SizedBox(
                      height: ScreenUtil().screenHeight,
                      child: circularProgress(),
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
