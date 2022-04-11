import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/view_model/view_model.dart';
import 'package:towrevo/widgets/widgets.dart';

class UserHistoryTow extends StatefulWidget {
  const UserHistoryTow({Key? key}) : super(key: key);
  static const routeName = '/user-history';

  @override
  _UserHistoryTowState createState() => _UserHistoryTowState();
}

class _UserHistoryTowState extends State<UserHistoryTow> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then(
      (value) {
        Provider.of<UserHomeScreenViewModel>(context, listen: false)
            .getUserHistory();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserHomeScreenViewModel>(
      context,
      listen: true,
    );

    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Stack(
          children: [
            const FullBackgroundImage(),
            Column(
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
                      margin: const EdgeInsets.only(top: 40, left: 45),
                      child: Text(
                        'MY HISTORY',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 28.0,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 50),
                FadeInUp(
                  from: 40,
                  duration: const Duration(milliseconds: 500),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5.0, vertical: 10.0),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.90,
                    child: Column(
                      children: [
                        (provider.isLoading || provider.userHistoryList.isEmpty)
                            ? Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.65,
                                  child: provider.isLoading
                                      ? circularProgress()
                                      : noDataImage(
                                          context,
                                          'NO COMPANY HISTORY',
                                          'assets/images/towing.png',
                                        ),
                                ),
                              )
                            : Expanded(
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  itemCount: provider.userHistoryList.length,
                                  itemBuilder: (ctx, index) {
                                    return UserHistoryList(
                                      userHistoryModel:
                                          provider.userHistoryList[index],
                                    );
                                  },
                                ),
                              ),
                      ],
                    ),
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
