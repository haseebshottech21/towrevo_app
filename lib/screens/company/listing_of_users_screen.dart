import 'package:flutter/material.dart';
import '/widgets/drawer_widget.dart';
import '/widgets/company_item.dart';
class ListingOfUsersScreen extends StatelessWidget {
  static const routeName = '/users-listing';
   ListingOfUsersScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      // body: ListView.builder(
      //   itemBuilder: (ctx, index) {
      //     return CompanyItem(towServicesModel: towServicesList[index],);
      //   },
      //   itemCount: towServicesList.length,
      // ),

    );
  }
}
