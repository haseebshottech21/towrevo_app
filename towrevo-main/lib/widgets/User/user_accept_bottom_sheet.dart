import 'package:flutter/material.dart';

class UserAcceptBottomSheet extends StatefulWidget {
  const UserAcceptBottomSheet({Key? key}) : super(key: key);

  @override
  _UserAcceptBottomSheetState createState() => _UserAcceptBottomSheetState();
}

class _UserAcceptBottomSheetState extends State<UserAcceptBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: const Text('Accept Bottom Sheet'),
        onPressed: () {
          // adding some properties
          showModalBottomSheet(
            context: context,
            // color is applied to main screen when modal bottom screen is displayed
            // barrierColor: Colors.greenAccent,
            //background color for modal bottom screen
            backgroundColor: Colors.white,
            //elevates modal bottom screen
            elevation: 10,
            // gives rounded corner to modal bottom screen
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            builder: (BuildContext context) {
              return Container(
                padding: const EdgeInsets.all(20.0),
                height: MediaQuery.of(context).size.height * 0.22,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Company Name',
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text('Towing On The Way'),
                          ],
                        ),
                        Container(
                          width: 100,
                          height: 35,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Center(
                            child: Text(
                              'Accepted',
                              style: TextStyle(
                                color: Colors.green,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const Spacer(),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: Text(
                          'Please Wait...',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
