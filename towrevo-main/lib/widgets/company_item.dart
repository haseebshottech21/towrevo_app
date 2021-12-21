import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/models/company_model.dart';
import 'package:towrevo/number_creator.dart';
import 'package:towrevo/screens/map_distance_screen.dart';
import 'package:towrevo/view_model/user_home_screen_view_model.dart';
import 'package:url_launcher/url_launcher.dart';

class CompanyItem extends StatelessWidget {
  final CompanyModel companyModel;

  const CompanyItem({Key? key, required this.companyModel}) : super(key: key);

  sendRequest(
    String companyId,
    BuildContext context,
    String notificationId,
  ) async {
    print(notificationId);
    final provider =
        Provider.of<UserHomeScreenViewModel>(context, listen: false);
    print(provider.body['service']!);
    print(provider.body['address']!);
    provider.requestToCompany(
        context,
        provider.body['longitude']!,
        provider.body['latitude']!,
        provider.body['address']!,
        provider.body['service']!,
        companyId,
        notificationId);
  }

  openDialPad(String phoneNumber) {
    if (phoneNumber.isNotEmpty) {
      launch("tel://$phoneNumber");
    } else {
      print('phone Number is empty : ' + phoneNumber);
    }
  }

  @override
  Widget build(BuildContext context) {
    print(companyModel.notificationId);

    final primaryColor = Theme.of(context).primaryColor;
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
                                ' (${companyModel.distance} mi)',
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                companyModel.firstName,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
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
                            const Text(
                              '5.0',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const Flexible(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        MapDistanceScreen.routeName,
                        arguments: LatLng(
                          double.parse(companyModel.latitude),
                          double.parse(companyModel.longitude),
                        ),
                      );
                    },
                    child: const Text('Get Directions'),
                  ),
                  SizedBox(
                    width: 70,
                    child: Row(
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () {
                            sendRequest(
                              companyModel.userId,
                              context,
                              companyModel.notificationId,
                            );
                          },
                          icon: FaIcon(
                            FontAwesomeIcons.paperPlane,
                            color: primaryColor,
                            size: 20,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () {
                            openDialPad(companyModel.phoneNumber);
                          },
                          icon: Icon(
                            Icons.phone_in_talk,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
