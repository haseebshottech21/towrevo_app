import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/view_model/view_model.dart';
import 'package:towrevo/widgets/widgets.dart';

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
              (userHomeProvider.isLoading || userHomeProvider.list.isEmpty)
                  ? Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.75,
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
                      child: RefreshIndicator(
                        onRefresh: () => getRequestList(),
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: userHomeProvider.list.length,
                          itemBuilder: (ctx, index) {
                            return CompanyItem(
                              companyModel: userHomeProvider.list[index],
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
      await userHomeProvider.getCompanies(userHomeProvider.body);
    });
  }
}
