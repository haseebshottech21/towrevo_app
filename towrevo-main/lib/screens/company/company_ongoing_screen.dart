import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/view_model/view_model.dart';
import 'package:towrevo/widgets/widgets.dart';

class CompanyOngoingScreen extends StatefulWidget {
  const CompanyOngoingScreen({Key? key}) : super(key: key);

  @override
  _CompanyOngoingScreenState createState() => _CompanyOngoingScreenState();
}

class _CompanyOngoingScreenState extends State<CompanyOngoingScreen> {
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
                          serviceRequestModel:
                              provider.onGoingRequestsList[index],
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
