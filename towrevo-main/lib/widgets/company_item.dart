import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/models/company_model.dart';
import 'package:towrevo/view_model/user_home_screen_view_model.dart';

class CompanyItem extends StatelessWidget {
  final CompanyModel companyModel;

  const CompanyItem({Key? key, required this.companyModel}) : super(key: key);

  sendRequest(
      String companyId, BuildContext context, String notificationId) async {
    print(notificationId);
    final provider =
        Provider.of<UserHomeScreenViewModel>(context, listen: false);
    print(provider.body['service']!);
    provider.requestToCompany(
        provider.body['service']!, companyId, notificationId);
  }

  @override
  Widget build(BuildContext context) {
    print(companyModel.notificationId);

    final primaryColor = Theme.of(context).primaryColor;
    return Card(
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
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          companyModel.firstName,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
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
                  onPressed: () {},
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
                          // sendRequest(
                          //   companyModel.userId,
                          //   context,
                          //   companyModel.notificationId,
                          // );
                          showDialog(
                            context: context,
                            builder: (ctxt) => AlertDialog(
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    height: 100,
                                    width: MediaQuery.of(context).size.width *
                                        0.40,
                                    child: const CircleAvatar(
                                      backgroundColor: Colors.green,
                                      child: FaIcon(FontAwesomeIcons.check),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    'SuccessFully Send!',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
                        onPressed: () {},
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
    );
  }
}
