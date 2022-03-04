import 'package:flutter/material.dart';

class AnimCard extends StatefulWidget {
  const AnimCard({Key? key}) : super(key: key);

  @override
  State<AnimCard> createState() => _AnimCardState();
}

class _AnimCardState extends State<AnimCard> {
  double loginWidth = 40.0;

  double animHeight = 0.0;
  double animHeightmain = 200.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: Center(
        child: PageView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Stack(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 800),
                      height: animHeightmain,
                      width: MediaQuery.of(context).size.width * 0.90,
                      decoration: BoxDecoration(
                        boxShadow: kElevationToShadow[2],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    boxShadow: kElevationToShadow[2],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text('ABC Name'),
                                    SizedBox(height: 2),
                                    Text('5 miles away'),
                                  ],
                                ),
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 12),
                                  decoration: BoxDecoration(
                                    boxShadow: kElevationToShadow[1],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    // border: Border.all(color: Colors.black),
                                  ),
                                  child: const Center(child: Text('CAR')),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            const Text('Problem'),
                            const SizedBox(height: 2),
                            const Text(
                                'Lorem Ipsum has been the industrys standard dummy text ever since the 1500s'),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    // padding: EdgeInsets.zero,
                                    shape: const StadiumBorder(),
                                    primary: Colors.blueGrey.shade100,
                                    side: const BorderSide(
                                        color: Colors.blueGrey),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      animHeight = 140;
                                      animHeightmain =
                                          animHeightmain + animHeight;
                                    });
                                  },
                                  child: const Text(
                                    'View Location',
                                    style: TextStyle(
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        // padding: EdgeInsets.zero,
                                        shape: const StadiumBorder(),
                                        primary: Colors.white,
                                        side:
                                            const BorderSide(color: Colors.red),
                                      ),
                                      onPressed: () {},
                                      child: const Text(
                                        'Decline',
                                        style: TextStyle(
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        // padding: EdgeInsets.zero,
                                        shape: const StadiumBorder(),
                                        primary: Colors.green,
                                        side: const BorderSide(
                                            color: Colors.green),
                                      ),
                                      onPressed: () {},
                                      child: const Text(
                                        'Accept',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Center(
                        child: AnimatedContainer(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          duration: const Duration(microseconds: 400),
                          height: animHeight,
                          width: MediaQuery.of(context).size.width * 0.90,
                          decoration: BoxDecoration(
                            boxShadow: kElevationToShadow[6],
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const [
                                  Icon(Icons.location_pin, size: 12),
                                  SizedBox(width: 2),
                                  Text('Pick Location'),
                                ],
                              ),
                              const SizedBox(height: 2),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 2),
                                child: Text(
                                  '1600 Amphitheatre Pkwy, Santa Clara, 600 Amphitheatre Pkwy,',
                                ),
                              ),
                              const Divider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const [
                                  Icon(Icons.location_pin, size: 12),
                                  SizedBox(width: 2),
                                  Text('Drop Location'),
                                ],
                              ),
                              const SizedBox(height: 2),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 2),
                                child: Text(
                                  '1600 Amphitheatre Pkwy, Santa Clara, 600 Amphitheatre Pkwy,',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
