import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/models/company_model.dart';
import 'package:towrevo/screens/user/user_monthly_payment_screen.dart';
import 'package:towrevo/view_model/user_home_screen_view_model.dart';
import 'package:towrevo/widgets/profile_image_circle.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utitlites/utilities.dart';

class CompanyItem extends StatelessWidget {
  final CompanyModel companyModel;

  const CompanyItem({Key? key, required this.companyModel}) : super(key: key);

  sendRequest(
    String companyId,
    BuildContext context,
    String notificationId,
    String phoneNumber,
  ) async {
    if (phoneNumber.isNotEmpty) {
      print(notificationId);
      final provider =
          Provider.of<UserHomeScreenViewModel>(context, listen: false);
      // print(provider.body['service']!);
      // print(provider.body['address']!);
      provider.requestToCompany(
        context,
        provider.body['longitude']!,
        provider.body['latitude']!,
        provider.body['address']!,
        provider.body['dest_longitude']!,
        provider.body['dest_latitude']!,
        provider.body['dest_address']!,
        provider.body['description']!,
        provider.body['service']!,
        companyId,
        notificationId,
      );
    } else {
      Navigator.of(context).pushNamed(UserMonthlyPaymentScreen.routeName);
    }
  }

  openDialPad(String phoneNumber, BuildContext context) {
    if (phoneNumber.isNotEmpty) {
      launch("tel://+1$phoneNumber");
    } else {
      Navigator.of(context).pushNamed(UserMonthlyPaymentScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    print(companyModel.email);
    final primaryColor = Theme.of(context).primaryColor;
    print('distance' + companyModel.distance);
    return FadeInUp(
      from: 50,
      child: Card(
        elevation: 5,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 10,
            top: 15,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 9,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            companyModel.from +
                                ' - ' +
                                companyModel.to +
                                ' (${companyModel.distance})',
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              // color: companyModel.email.isEmpty
                              //     ? Colors.black12.withOpacity(0.1)
                              //     : Colors.white,
                              child: Text(
                                companyModel.email.isEmpty
                                    ? 'Request Company'
                                    : companyModel.firstName,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  // color: companyModel.email.isEmpty
                                  //     ? Colors.white.withOpacity(0.2)
                                  //     : Colors.black
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            const Icon(
                              Icons.star,
                              color: Colors.orangeAccent,
                              size: 17,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              companyModel.avgRating,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  companyModel.image.isNotEmpty
                      ? companyModel.email.isEmpty
                          ? Container(
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                  width: 2.5,
                                ),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: ClipOval(
                                child: ImageFiltered(
                                    imageFilter: ImageFilter.blur(
                                      sigmaY: 5,
                                      sigmaX: 5,
                                    ), //SigmaX and Y are just for X and Y directions
                                    child: Image.network(
                                      Utilities.imageBaseUrl +
                                          companyModel.image,
                                      // width: 35,
                                      // height: 35,
                                      fit: BoxFit.cover,
                                    ) //here you can use any widget you'd like to blur .
                                    ),
                              ),
                            )
                          : profileImageCircle(
                              context,
                              Utilities.imageBaseUrl + companyModel.image,
                            )
                      : const Flexible(
                          fit: FlexFit.tight,
                          flex: 1,
                          child: CircleAvatar(
                            backgroundColor: Colors.black,
                            child: Icon(
                              Icons.home_work_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(companyModel.description),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Available',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Colors.green[700],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: SizedBox(
                        width: 75,
                        // color: Colors.black,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            companyModel.email.isEmpty
                                ? const SizedBox()
                                :
                                // : companyModel.distance == 'Null'
                                //     ? const IconButton(
                                //         padding: EdgeInsets.zero,
                                //         constraints: BoxConstraints(),
                                //         onPressed: null,
                                //         icon: FaIcon(
                                //           FontAwesomeIcons.solidPaperPlane,
                                //           color: Colors.grey,
                                //           size: 22,
                                //         ),
                                //       )
                                //     :
                                IconButton(
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    onPressed: () {
                                      sendRequest(
                                        companyModel.userId,
                                        context,
                                        companyModel.notificationId,
                                        companyModel.phoneNumber,
                                      );
                                    },
                                    icon: FaIcon(
                                      FontAwesomeIcons.paperPlane,
                                      color: primaryColor,
                                      size: 22,
                                    ),
                                  ),
                            companyModel.email.isEmpty
                                ? const SizedBox()
                                : const SizedBox(
                                    width: 20,
                                  ),
                            // companyModel.distance == 'Null'
                            //     ? const IconButton(
                            //         padding: EdgeInsets.zero,
                            //         constraints: BoxConstraints(),
                            //         onPressed: null,
                            //         icon: FaIcon(
                            //           Icons.phone_in_talk,
                            //           color: Colors.grey,
                            //           size: 25,
                            //         ),
                            //       )
                            //     :
                            IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              onPressed: () {
                                openDialPad(companyModel.phoneNumber, context);
                              },
                              icon: Icon(
                                Icons.phone_in_talk,
                                color: primaryColor,
                                size: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
