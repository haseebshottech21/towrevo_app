import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/view_model/company_home_screen_view_model.dart';
import 'package:towrevo/widgets/Loaders/no_user.dart';
import 'package:towrevo/widgets/circular_progress_indicator.dart';
import 'package:towrevo/widgets/full_background_image.dart';
import 'package:towrevo/widgets/job_completed_dailogbox.dart';
import 'package:towrevo/widgets/profile_image_circle.dart';

import '../../utilities.dart';

class CompanyOngoingList extends StatefulWidget {
  const CompanyOngoingList({Key? key}) : super(key: key);

  @override
  _CompanyOngoingListState createState() => _CompanyOngoingListState();
}

class _CompanyOngoingListState extends State<CompanyOngoingList> {
  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<CompanyHomeScreenViewModel>(context, listen: true);
    return Stack(
      children: [
        const FullBackgroundImage(),
        SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              // const Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 15),
              //   child: Align(
              //     alignment: Alignment.centerLeft,
              //     child: Text(
              //       'Ongoing',
              //       style: TextStyle(
              //         fontSize: 22.0,
              //         color: Colors.white,
              //         fontWeight: FontWeight.w700,
              //       ),
              //     ),
              //   ),
              // ),
              (provider.isLoading || provider.onGoingRequestsList.isEmpty)
                  ? Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.65,
                        child: provider.isLoading
                            ? circularProgress()
                            : noDataImage(
                                context,
                                'Active Jobs',
                                'assets/images/towing.png',
                              ),
                      ),
                    )
                  : SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: provider.onGoingRequestsList.length,
                        itemBuilder: (context, index) {
                          print(provider
                              .onGoingRequestsList[index].notificationId);
                          return Card(
                            elevation: 5,
                            shadowColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            margin: const EdgeInsets.only(
                                left: 10, right: 10, top: 10),
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
                                            // Container(
                                            //   alignment: Alignment.centerLeft,
                                            //   child: Text('acas'),
                                            // ),
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                provider
                                                    .onGoingRequestsList[index]
                                                    .name,
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      provider.onGoingRequestsList[index].image
                                              .isNotEmpty
                                          ? profileImageCircle(
                                              context,
                                              Utilities.imageBaseUrl +
                                                  provider
                                                      .onGoingRequestsList[
                                                          index]
                                                      .image)
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
                                    height: 5,
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.75,
                                      child: Text(
                                        provider
                                            .onGoingRequestsList[index].address
                                            .trim(),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Image.asset(
                                    "assets/images/spinner.gif",
                                    height: 35.0,
                                    width: 35.0,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                        ),
                                        onPressed: () {},
                                        child: const Text('Get Directions'),
                                      ),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                        ),
                                        onPressed: () {
                                          print(provider
                                              .onGoingRequestsList[index]
                                              .notificationId);
                                          showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (ctxt) =>
                                                completeJobDialogbox(
                                              ctxt,
                                              provider
                                                  .onGoingRequestsList[index]
                                                  .id,
                                              provider
                                                  .onGoingRequestsList[index]
                                                  .notificationId,
                                            ),
                                          );
                                        },
                                        child: const Text(
                                          'Job Completed',
                                          style: TextStyle(
                                            // color: Color(0xFF092848),
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async {
      await getData();
    });

    super.initState();
  }

  Future<void> getData() async {
    print('in data');
    final provider =
        Provider.of<CompanyHomeScreenViewModel>(context, listen: false);
    await provider.getOnGoingRequests();
  }
}
