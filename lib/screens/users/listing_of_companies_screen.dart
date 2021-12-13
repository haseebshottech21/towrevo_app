import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/view_model/user_home_screen_view_model.dart';
import '/widgets/company_item.dart';

class ListingOfCompaniesScreen extends StatefulWidget {
  const ListingOfCompaniesScreen({Key? key}) : super(key: key);
  static const routeName = 'company-listing';
  @override
  _ListingOfCompaniesScreenState createState() => _ListingOfCompaniesScreenState();
}

class _ListingOfCompaniesScreenState extends State<ListingOfCompaniesScreen> {

  @override
  Widget build(BuildContext context) {
    final userHomeProvider = Provider.of<UserHomeScreenViewModel>(context,listen: true);
    return Scaffold(
      backgroundColor: userHomeProvider.isLoading?Colors.white:Theme.of(context).primaryColor,
      appBar: AppBar(title: const Text('Near by Services'),),
      body: userHomeProvider.isLoading?const Center(child: CircularProgressIndicator(),):ListView.builder(
        itemBuilder: (ctx, index) {
          return CompanyItem(companyModel: userHomeProvider.list[index],);
        },
        itemCount: userHomeProvider.list.length,
      ),

    );
  }

  @override
  void initState() {

    final userHomeProvider = Provider.of<UserHomeScreenViewModel>(context,listen: false);
    Future.delayed(Duration.zero).then((value) async{
     await  userHomeProvider.getCompanies(userHomeProvider.body);
    });

    super.initState();
  }
}
