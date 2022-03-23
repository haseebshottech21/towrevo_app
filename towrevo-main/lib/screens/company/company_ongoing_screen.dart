import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/view_model/view_model.dart';
import 'package:towrevo/widgets/widgets.dart';
import '../../utitlites/utilities.dart';

class CompanyOngoingScreen extends StatefulWidget {
  const CompanyOngoingScreen({Key? key}) : super(key: key);

  @override
  _CompanyOngoingScreenState createState() => _CompanyOngoingScreenState();
}

class _CompanyOngoingScreenState extends State<CompanyOngoingScreen> {
  // bool initial = true;
  // @override
  // void didChangeDependencies() {
  //   if (initial) {
  //     Provider.of<GetLocationViewModel>(context, listen: false)
  //         .getCurrentLocation(context);
  //   }
  //   initial = false;

  //   super.didChangeDependencies();
  // }

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
                        print(provider.onGoingRequestsList[index].distance);
                        return JobCompleteCard(
                          reqOriginLatitude:
                              provider.onGoingRequestsList[index].latitude,
                          reqOriginLongitude:
                              provider.onGoingRequestsList[index].longitude,
                          reqDestLatitude:
                              provider.onGoingRequestsList[index].destLatitude,
                          reqDestLongitude:
                              provider.onGoingRequestsList[index].destLongitude,

                          userName: provider.onGoingRequestsList[index].name,
                          // userDistance:
                          //     provider.onGoingRequestsList[index].totalDistance,
                          userDistance: provider.onGoingRequestsList[index]
                                  .destAddress.isEmpty
                              ? provider.onGoingRequestsList[index].distance
                              : provider
                                  .onGoingRequestsList[index].totalDistance,
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
