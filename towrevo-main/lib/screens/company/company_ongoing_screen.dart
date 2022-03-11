import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/view_model/company_home_screen_view_model.dart';
import 'package:towrevo/widgets/Company/job_complete_card.dart';
import 'package:towrevo/widgets/Loaders/no_user.dart';
import 'package:towrevo/widgets/circular_progress_indicator.dart';
import 'package:towrevo/widgets/empty_profile.dart';
import 'package:towrevo/widgets/full_background_image.dart';
import 'package:towrevo/widgets/job_completed_dailogbox.dart';
import 'package:towrevo/widgets/profile_image_circle.dart';
import '../../utitlites/utilities.dart';
import '../../view_model/get_location_view_model.dart';

class CompanyOngoingScreen extends StatefulWidget {
  const CompanyOngoingScreen({Key? key}) : super(key: key);

  @override
  _CompanyOngoingScreenState createState() => _CompanyOngoingScreenState();
}

class _CompanyOngoingScreenState extends State<CompanyOngoingScreen> {
  bool initial = true;
  @override
  void didChangeDependencies() {
    if (initial) {
      Provider.of<GetLocationViewModel>(context, listen: false)
          .getCurrentLocation(context);
    }
    initial = false;

    super.didChangeDependencies();
  }

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
                  : ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: provider.onGoingRequestsList.length,
                      itemBuilder: (context, index) {
                        return JobCompleteCard(
                          reqOriginLatitude:
                              provider.onGoingRequestsList[index].latitude,
                          reqOriginLongitude:
                              provider.onGoingRequestsList[index].longitude,
                          userName: provider.onGoingRequestsList[index].name,
                          userDistance:
                              provider.onGoingRequestsList[index].distance,
                          profileImage: provider
                                  .onGoingRequestsList[index].image.isNotEmpty
                              ? profileImageSquare(
                                  context,
                                  Utilities.imageBaseUrl +
                                      provider.onGoingRequestsList[index].image,
                                )
                              : const EmptyProfile(),
                          serviceType:
                              provider.onGoingRequestsList[index].serviceName,
                          pickLocation:
                              provider.onGoingRequestsList[index].address,
                          dropLocation:
                              provider.onGoingRequestsList[index].destAddress,
                          probText:
                              provider.onGoingRequestsList[index].description,
                          completeOnPressed: () {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (ctxt) => completeJobDialogbox(
                                ctxt,
                                provider.onGoingRequestsList[index].id,
                                provider
                                    .onGoingRequestsList[index].notificationId,
                              ),
                            );
                          },
                        );
                      },
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
    final provider =
        Provider.of<CompanyHomeScreenViewModel>(context, listen: false);
    await provider.getOnGoingRequests();
  }
}
