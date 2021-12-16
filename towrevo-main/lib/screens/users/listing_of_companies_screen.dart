import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/view_model/user_home_screen_view_model.dart';
import 'package:towrevo/widgets/circular_progress_indicator.dart';
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
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const FaIcon(
                    FontAwesomeIcons.arrowLeft,
                    color: Colors.white,
                    size: 15,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Nearby Services',
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              userHomeProvider.isLoading
                  ? circularProgress()
                  : ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemBuilder: (ctx, index) {
                        return CompanyItem(
                          companyModel: userHomeProvider.list[index],
                        );
                      },
                      itemCount: userHomeProvider.list.length,
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
