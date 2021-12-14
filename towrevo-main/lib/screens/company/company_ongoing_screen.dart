import 'package:flutter/material.dart';
import 'package:towrevo/widgets/full_background_image.dart';
import 'package:towrevo/widgets/job_completed_dailogbox.dart';

class CompanyOngoingList extends StatefulWidget {
  const CompanyOngoingList({Key? key}) : super(key: key);

  @override
  _CompanyOngoingListState createState() => _CompanyOngoingListState();
}

class _CompanyOngoingListState extends State<CompanyOngoingList> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const FullBackgroundImage(),
        SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              // const Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 15),
              //   child: Align(
              //     alignment: Alignment.centerLeft,
              //     child: Text(
              //       'Ongoing',
              //       style: TextStyle(
              //         fontSize: 22.0,
              //         color: Colors.white,
              //         fontWeight: FontWeight.w700,
              //       ),
              //     ),
              //   ),
              // ),
              Container(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      shadowColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      margin:
                          const EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          right: 10,
                          top: 15,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  fit: FlexFit.tight,
                                  flex: 9,
                                  child: Column(
                                    children: [
                                      // Container(
                                      //   alignment: Alignment.centerLeft,
                                      //   child: Text('acas'),
                                      // ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: const Text(
                                          'User Name',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Flexible(
                                  fit: FlexFit.tight,
                                  flex: 1,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.black,
                                    child: Icon(
                                      Icons.home_work_outlined,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.75,
                                child: const Text(
                                  '1 Zuelke Road, Three Forks,mt, 59352  United States',
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Image.asset(
                              "assets/images/load.gif",
                              height: 35.0,
                              width: 35.0,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                  ),
                                  onPressed: () {},
                                  child: const Text('Get Directions'),
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (ctxt) => completeJobDialogbox(),
                                    );
                                  },
                                  child: const Text(
                                    'Job Completed',
                                    style: TextStyle(
                                      // color: Color(0xFF092848),
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Container(
              //   child: ListView.builder(
              //     padding: EdgeInsets.zero,
              //     shrinkWrap: true,
              //     itemCount: 5,
              //     itemBuilder: (ctx, index) {
              //       return Card(
              //         elevation: 5,
              //         shadowColor: Colors.black,
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(15.0),
              //         ),
              //         margin:
              //             const EdgeInsets.only(left: 10, right: 10, top: 10),
              //         child: Padding(
              //           padding: const EdgeInsets.only(
              //             left: 15,
              //             right: 10,
              //             top: 15,
              //           ),
              //           child: Column(
              //             children: [
              //               Row(
              //                 children: [
              //                   Flexible(
              //                     fit: FlexFit.tight,
              //                     flex: 9,
              //                     child: Column(
              //                       children: [
              //                         // Container(
              //                         //   alignment: Alignment.centerLeft,
              //                         //   child: Text('acas'),
              //                         // ),
              //                         Container(
              //                           alignment: Alignment.centerLeft,
              //                           child: const Text(
              //                             'User Name',
              //                             style: TextStyle(
              //                                 fontSize: 20,
              //                                 fontWeight: FontWeight.bold),
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                   const Flexible(
              //                     fit: FlexFit.tight,
              //                     flex: 1,
              //                     child: CircleAvatar(
              //                       backgroundColor: Colors.black,
              //                       child: Icon(
              //                         Icons.home_work_outlined,
              //                         color: Colors.white,
              //                       ),
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //               const SizedBox(
              //                 height: 5,
              //               ),
              //               Align(
              //                 alignment: Alignment.topLeft,
              //                 child: Container(
              //                   width: MediaQuery.of(context).size.width * 0.75,
              //                   child: const Text(
              //                     '1 Zuelke Road, Three Forks,mt, 59352  United States',
              //                     textAlign: TextAlign.start,
              //                   ),
              //                 ),
              //               ),
              //               Row(
              //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                 children: [
              //                   TextButton(
              //                     style: TextButton.styleFrom(
              //                       padding: EdgeInsets.zero,
              //                     ),
              //                     onPressed: () {},
              //                     child: const Text('Get Directions'),
              //                   ),
              //                   SizedBox(
              //                     width: 135,
              //                     child: Row(
              //                       children: [
              //                         TextButton(
              //                           style: TextButton.styleFrom(
              //                             padding: EdgeInsets.zero,
              //                           ),
              //                           onPressed: () {},
              //                           child: const Text(
              //                             'Accept',
              //                             style: TextStyle(
              //                               color: Colors.green,
              //                             ),
              //                           ),
              //                         ),
              //                         const SizedBox(
              //                           width: 5,
              //                         ),
              //                         TextButton(
              //                           style: TextButton.styleFrom(
              //                             padding: EdgeInsets.zero,
              //                           ),
              //                           onPressed: () {},
              //                           child: const Text(
              //                             'Decline',
              //                             style: TextStyle(
              //                               color: Colors.red,
              //                             ),
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                   )
              //                 ],
              //               ),
              //             ],
              //           ),
              //         ),
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
