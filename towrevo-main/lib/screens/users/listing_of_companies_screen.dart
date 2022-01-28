import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/view_model/user_home_screen_view_model.dart';
import 'package:towrevo/widgets/Loaders/glowCircle.dart';
import 'package:towrevo/widgets/Loaders/no_user.dart';
import 'package:towrevo/widgets/back_icon.dart';
import 'package:towrevo/widgets/full_background_image.dart';
import '/widgets/company_item.dart';

class ListingOfCompaniesScreen extends StatefulWidget {
  const ListingOfCompaniesScreen({Key? key}) : super(key: key);
  static const routeName = 'company-listing';
  @override
  _ListingOfCompaniesScreenState createState() =>
      _ListingOfCompaniesScreenState();
}

class _ListingOfCompaniesScreenState extends State<ListingOfCompaniesScreen> {
  @override
  Widget build(BuildContext context) {
    final userHomeProvider =
        Provider.of<UserHomeScreenViewModel>(context, listen: true);

    return Scaffold(
      backgroundColor: userHomeProvider.isLoading
          ? Colors.white
          : Theme.of(context).primaryColor,
      // appBar: AppBar(
      //   title: const Text(
      //     'Near by Services',
      //   ),
      // ),
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
                  const SizedBox(
                    width: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Text(
                      'Near By Companies',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 22.0,
                      ),
                    ),
                  )
                ],
              ),
              // userHomeProvider.isLoading
              //     ? SizedBox(
              //         height: MediaQuery.of(context).size.height * 0.7,
              //         child: const GlowCircle(
              //           glowHeight: 50,
              //           glowWidth: 50,
              //           glowbegin: 0,
              //           glowend: 100,
              //           miliseconds: 800,
              //         ),
              //       )
              //     :
              (userHomeProvider.isLoading || userHomeProvider.list.isEmpty)
                  ? Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.65,
                        child: userHomeProvider.isLoading
                            ? const GlowCircle(
                                glowHeight: 50,
                                glowWidth: 50,
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
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemBuilder: (ctx, index) {
                          return CompanyItem(
                            companyModel: userHomeProvider.list[index],
                          );
                        },
                        itemCount: userHomeProvider.list.length,
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
    final userHomeProvider =
        Provider.of<UserHomeScreenViewModel>(context, listen: false);
    Future.delayed(Duration.zero).then((value) async {
      await userHomeProvider.getCompanies(userHomeProvider.body);
    });

    super.initState();
  }
}
