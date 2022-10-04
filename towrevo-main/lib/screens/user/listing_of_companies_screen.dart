import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/view_model/view_model.dart';
import 'package:towrevo/widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListingOfCompaniesScreen extends StatefulWidget {
  const ListingOfCompaniesScreen({Key? key}) : super(key: key);
  static const routeName = 'company-listing';
  @override
  _ListingOfCompaniesScreenState createState() =>
      _ListingOfCompaniesScreenState();
}

class _ListingOfCompaniesScreenState extends State<ListingOfCompaniesScreen> {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    final userHomeProvider =
        Provider.of<UserHomeScreenViewModel>(context, listen: true);

    return Scaffold(
      backgroundColor: userHomeProvider.isLoading
          ? Colors.white
          : Theme.of(context).primaryColor,
      body: Stack(
        children: [
          const FullBackgroundImage(),
          Column(
            children: [
              Row(
                children: [
                  backIcon(context, () {
                    Navigator.of(context).pop();
                  }),
                  SizedBox(width: 20.w),
                  Padding(
                    padding: EdgeInsets.only(top: 30.h),
                    child: Text(
                      'Near By Companies',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20.sp,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 5.h),
              (userHomeProvider.isLoading || userHomeProvider.list.isEmpty)
                  ? Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: ScreenUtil().screenHeight * 0.75,
                        child: userHomeProvider.isLoading
                            ? GlowCircle(
                                glowHeight: 50.h,
                                glowWidth: 50.w,
                                glowbegin: 0,
                                glowend: 100,
                                miliseconds: 800,
                              )
                            : noDataImage(
                                context,
                                'No Towing Service Available',
                                'assets/images/towing.png',
                              ),
                      ),
                    )
                  : Expanded(
                      child: RefreshIndicator(
                        onRefresh: () => getRequestList(),
                        child: ListView.builder(
                          padding: const EdgeInsets.only(bottom: 10),
                          shrinkWrap: true,
                          itemCount: userHomeProvider.list.length,
                          itemBuilder: (ctx, index) {
                            return CompanyItem(
                              companyModel: userHomeProvider.list[index],
                              scaffoldMessengerKey: scaffoldMessengerKey,
                            );
                          },
                        ),
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    getRequestList();
    super.initState();
  }

  getRequestList() {
    final userHomeProvider =
        Provider.of<UserHomeScreenViewModel>(context, listen: false);
    Future.delayed(Duration.zero).then((value) async {
      await userHomeProvider.getCompanies(userHomeProvider.body, context);
    });
  }
}
