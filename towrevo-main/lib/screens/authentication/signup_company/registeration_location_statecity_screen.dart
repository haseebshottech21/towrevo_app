import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/error_getter.dart';
import 'package:towrevo/screens/screens.dart';
import '../../../utilities/state_city_utility.dart';
import '../../../view_model/view_model.dart';
import '../../../widgets/widgets.dart';

class RegisterationLocationAndState extends StatefulWidget {
  const RegisterationLocationAndState({Key? key}) : super(key: key);

  static const routeName = '/location-state';

  @override
  State<RegisterationLocationAndState> createState() =>
      _RegisterationLocationAndStateState();
}

class _RegisterationLocationAndStateState
    extends State<RegisterationLocationAndState> {
  final _formKey = GlobalKey<FormState>();
  final startAmountController = TextEditingController();

  void validateFromAndSaveData() {
    final companySignUpProvider =
        Provider.of<RegisterCompanyViewModel>(context, listen: false);
    final locationProvider =
        Provider.of<GetLocationViewModel>(context, listen: false);

    if (!_formKey.currentState!.validate()) {
      return;
    } else if (companySignUpProvider.selectedState == null ||
        companySignUpProvider.selectedCity == null) {
      Fluttertoast.showToast(msg: 'Please Select State And City');
      return;
    } else {
      // if (locationProvider.myCurrentLocation.placeAddress.isNotEmpty) {
      companySignUpProvider.body['starting_price'] =
          startAmountController.text.trim();
      companySignUpProvider.body['state'] = companySignUpProvider.selectedState;
      companySignUpProvider.body['city'] = companySignUpProvider.selectedCity;

      companySignUpProvider.body['latitude'] =
          locationProvider.myCurrentLocation.placeLocation.latitude.toString();
      companySignUpProvider.body['longitude'] =
          locationProvider.myCurrentLocation.placeLocation.longitude.toString();

      // print(companySignUpProvider.body);

      Navigator.of(context).pushNamed(RegisterationCompleteScreen.routeName);
      // } else {
      //   Fluttertoast.showToast(msg: 'Please Select all fields');
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    final registerViewModel =
        Provider.of<RegisterCompanyViewModel>(context, listen: true);
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
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 55.h),
                    FadeInDown(
                      from: 15,
                      delay: const Duration(milliseconds: 500),
                      child: const CompanySignUpTitle(),
                    ),
                    SizedBox(height: 40.h),
                    FadeInDown(
                      from: 25,
                      delay: const Duration(milliseconds: 550),
                      child: TextFieldForAll(
                        errorGetter: ErrorGetter().startingPriceErrorGetter,
                        hintText: 'Starting Price',
                        prefixIcon: const Icon(
                          FontAwesomeIcons.dollarSign,
                          color: Color(0xFF019aff),
                          size: 20.0,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        textEditingController: startAmountController,
                        textInputType: TextInputType.number,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    // SizedBox(
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    Consumer<GetLocationViewModel>(
                      builder: (ctx, getLocation, neverBuildChild) {
                        return SelectLocation(
                          context: context,
                          delayMilliseconds: 570,
                          title:
                              getLocation.myCurrentLocation.placeAddress.isEmpty
                                  ? 'Company Location'
                                  : getLocation.myCurrentLocation.placeAddress,
                          height: 50.h,
                          maxlines: 2,
                          icon: Icons.location_on,
                          trailingIcon: Icons.my_location,
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              UserLocationScreen.routeName,
                              arguments: true,
                            );
                          },
                        );
                      },
                    ),
                    SizedBox(height: 8.h),
                    FadeInDown(
                      from: 70,
                      delay: const Duration(milliseconds: 590),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 3.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(28.r),
                          color: Colors.white,
                          border: Border.all(color: Colors.black45),
                        ),
                        width: double.infinity,
                        child: DropdownButton(
                            underline: const SizedBox(),
                            isExpanded: true,
                            hint: const Text(
                              'Select State',
                              style: TextStyle(color: Colors.black),
                            ),
                            value: registerViewModel.selectedState,
                            onChanged: (val) =>
                                registerViewModel.changeState(val.toString()),
                            items: usCityState.entries.map((state) {
                              return DropdownMenuItem(
                                child: Text(state.key),
                                value: state.key,
                              );
                            }).toList()),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    FadeInDown(
                      from: 70,
                      delay: const Duration(milliseconds: 610),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 3.h,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28.r),
                            color: Colors.white,
                            border: Border.all(color: Colors.black45)),
                        width: double.infinity,
                        child: DropdownButton(
                          underline: const SizedBox(),
                          isExpanded: true,
                          hint: const Text(
                            'Select City',
                            style: TextStyle(color: Colors.black),
                          ),
                          value: registerViewModel.selectedCity,
                          onChanged: (val) =>
                              registerViewModel.changeCity(val.toString()),
                          items: (registerViewModel.selectedState == null
                                  ? []
                                  : usCityState[registerViewModel.selectedState]
                                      as List<String>)
                              .map(
                            (state) {
                              return DropdownMenuItem(
                                child: Text(state),
                                value: state,
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    FadeInDown(
                      from: 35,
                      delay: const Duration(milliseconds: 650),
                      child: Container(
                        margin: EdgeInsets.only(top: 40.h),
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            StepFormButtonBack(
                              () {
                                Navigator.of(context).pop();
                              },
                              'BACK',
                            ),
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

  bool _init = true;
  @override
  void didChangeDependencies() async {
    if (_init) {
      final provider =
          Provider.of<RegisterCompanyViewModel>(context, listen: true);
      final locationProvider =
          Provider.of<GetLocationViewModel>(context, listen: false);
      // final serviceProvider =
      //     Provider.of<ServicesAndDaysViewModel>(context, listen: false);

      // locationProvider.myCurrentLocation.placeAddress = '';
      provider.initializeValues();
      provider.initStateAndCountry();
      // serviceProvider.initializeValues();
      // //services e.g car, bike
      // serviceProvider.getServices();

      // get current location
      await locationProvider.getStoreLocationIfExist(context);

      //         await getLocation.getLocationFromCoordinates(
      //   getLocation.myCurrentLocation.placeLocation,
      // );
      // getLocation.myCurrentLocation.placeAddress = getLocation.getAddress;

      // print('loc ' + locationProvider.getMyAddress.toString());
    }

    _init = false;
    super.didChangeDependencies();
  }
}
