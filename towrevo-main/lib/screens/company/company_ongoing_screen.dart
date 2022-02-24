import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/view_model/company_home_screen_view_model.dart';
import 'package:towrevo/widgets/Company/job_complete_card.dart';
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

              // JobCompleteCard(
              //   userName: 'Name',
              //   userDistance: '0.0',
              //   profileImage: const CircleAvatar(
              //     backgroundColor: Colors.black,
              //     child: Icon(
              //       Icons.home_work_outlined,
              //       color: Colors.white,
              //     ),
              //   ),
              //   serviceType: 'CAR',
              //   pickLocation:
              //       'Business Avenue, PECHS, Karachi, Sindh, Pakistan',
              //   dropLocation:
              //       'Business Avenue, PECHS, Karachi, Sindh, Pakistan',
              //   completeOnPressed: () {},
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
                          return JobCompleteCard(
                            userName: provider.onGoingRequestsList[index].name,
                            userDistance: '0.0',
                            profileImage: provider
                                    .onGoingRequestsList[index].image.isNotEmpty
                                ? profileImageCircle(
                                    context,
                                    Utilities.imageBaseUrl +
                                        provider
                                            .onGoingRequestsList[index].image,
                                  )
                                : const CircleAvatar(
                                    backgroundColor: Colors.black,
                                    child: Icon(
                                      Icons.home_work_outlined,
                                      color: Colors.white,
                                    ),
                                  ),
                            serviceType: 'CAR',
                            pickLocation:
                                provider.onGoingRequestsList[index].address,
                            dropLocation:
                                provider.onGoingRequestsList[index].address,
                            completeOnPressed: () {
                              // await CompanyHomeScreenViewModel()
                              //     .acceptDeclineOrDone(
                              //   '1',
                              //   provider.requestServiceList[index].id,
                              //   context,
                              //   notificationId: provider
                              //       .requestServiceList[index].notificationId,
                              // );
                              print(provider
                                  .onGoingRequestsList[index].notificationId);
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (ctxt) => completeJobDialogbox(
                                  ctxt,
                                  provider.onGoingRequestsList[index].id,
                                  provider.onGoingRequestsList[index]
                                      .notificationId,
                                ),
                              );
                            },
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
