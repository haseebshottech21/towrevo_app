import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class UserHistoryList extends StatelessWidget {
  final String companyImage;
  final String companyName;
  final String companyService;
  final String date;
  const UserHistoryList({
    required this.companyImage,
    required this.companyName,
    required this.companyService,
    required this.date,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        height: MediaQuery.of(context).size.height * 0.15,
        width: MediaQuery.of(context).size.width,
        // decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        child: Card(
          elevation: 5,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 5,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.black,
                      backgroundImage: NetworkImage(
                        companyImage,
                      ),
                      radius: 25,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          companyName,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0,
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          companyService,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.0,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                    Spacer(),
                    Text(
                      date,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w400,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //       date,
                //       style: const TextStyle(
                //         color: Colors.black87,
                //         fontWeight: FontWeight.w400,
                //         fontSize: 12.0,
                //       ),
                //     ),
                //     // Container(
                //     //   width: 100,
                //     //   height: 35,
                //     //   decoration: BoxDecoration(
                //     //     color: Colors.grey[100],
                //     //     borderRadius: BorderRadius.circular(50),
                //     //   ),
                //     //   child: Center(
                //     //     child: Text(
                //     //       status,
                //     //       style: TextStyle(
                //     //         color: colors,
                //     //       ),
                //     //     ),
                //     //   ),
                //     // )
                //   ],
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
