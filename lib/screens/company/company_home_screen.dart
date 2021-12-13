import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/view_model/company_home_screen_view_model.dart';
import 'package:towrevo/widgets/background_image.dart';
import 'package:towrevo/widgets/drawer_widget.dart';

class CompanyHomeScreen extends StatefulWidget {
  static const routeName = 'company-home';
  const CompanyHomeScreen({Key? key}) : super(key: key);

  @override
  _CompanyHomeScreenState createState() => _CompanyHomeScreenState();
}

class _CompanyHomeScreenState extends State<CompanyHomeScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CompanyHomeScreenViewModel>(context,listen:  true);

    return Scaffold(
      key: scaffoldKey,
      drawerEnableOpenDragGesture: true,
      drawer: const DrawerWidget(),
      body: Stack(children:  [
         const BackgroundImage(),
        provider.isLoading?
        const Center(child: CircularProgressIndicator(),):
        provider.requestServiceList.isEmpty?
        const Center(child: Text('No Data Found'),) :
        ListView.builder(itemBuilder: (ctx,index){
          return Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const ListTile(
                  leading: Icon(Icons.album),
                  title: Text('The Enchanted Nightingale'),
                  subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      child: const Text('Decline'),
                      onPressed: () {/* ... */},
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      child: const Text('Accept'),
                      onPressed: () {/* ... */},
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ],
            ),
          );
          // return Container(
          //   padding:
          //   const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Flexible(
          //         flex: 7,
          //         child: Row(
          //           children: [
          //             ClipOval(
          //               child: Image.asset(
          //                 // user.profilePicture,
          //                 'assets/images/bg2.jpg',
          //                 width: 60,
          //                 height: 65,
          //                 fit: BoxFit.cover,
          //               ),
          //             ),
          //             Container(
          //               padding: const EdgeInsets.only(left: 10),
          //               child: Column(
          //                   mainAxisSize: MainAxisSize.min,
          //                   mainAxisAlignment: MainAxisAlignment.start,
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     Text(
          //                       'Love Kumar',
          //                       style:
          //                       Theme.of(context).textTheme.bodyText1,
          //                     ),
          //                     const SizedBox(
          //                       height: 2,
          //                     ),
          //                     Container(
          //                       height: null,
          //                       width: 200,
          //                       child: const Text(
          //                         'Tariq Road, Pakistan Employee Co-operative Housing Society, Jamshed Town 75100, Pakistan',
          //                         maxLines: 3,
          //                         overflow: TextOverflow.ellipsis,
          //                         softWrap: true,
          //
          //                       ),
          //                     ),
          //                   ]),
          //             ),
          //           ],
          //         ),
          //       ),
          //       Flexible(
          //         flex: 3,
          //         child: Container(
          //           constraints: const BoxConstraints(maxWidth: 100),
          //           child: Row(
          //             children: [
          //               IconButton(
          //                 onPressed: () {},
          //                 icon: const CircleAvatar(
          //                   maxRadius: 20,
          //                   child: Icon(
          //                     Icons.check_outlined,
          //                   ),
          //                 ),
          //               ),
          //               IconButton(
          //                 onPressed: () {},
          //                 icon: const CircleAvatar(
          //                   backgroundColor: Colors.black12,
          //                   maxRadius: 20,
          //                   child: Icon(
          //                     Icons.clear,
          //                     color: Colors.black54,
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           ),),
          //       )
          //     ],
          //   ),
          // );
        },itemCount: provider.requestServiceList.length,),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 15.0),
          child: IconButton(
            icon: const Icon(Icons.menu,
                 size: 20.0),
            onPressed: () {
              scaffoldKey.currentState!.openDrawer();
            },
          ),
        ),

      ]),
    );
  }

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async{
      setupInteracted();
      await getData();

    });

    super.initState();
  }

  Future<void> getData() async{
    print('in data');
    final provider = Provider.of<CompanyHomeScreenViewModel>(context,listen: false);
    await provider.getRequests();
  }

  Future<void> setupInteracted() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();
    print('yes');
    print(initialMessage?.data.toString());
    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      // Navigator.pushNamed(context, RequestScreen.routeName,);
      getData();
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
    FirebaseMessaging.onMessage.listen((event) {
      print(event);
      getData();
    });
  }

  void _handleMessage(RemoteMessage message) {
    print(message);
    print(message.data);
    // if (message.data['type'] == 'chat') {
    getData();
    // Navigator.pushNamed(context, RequestScreen.routeName,);
    // }
  }


}
