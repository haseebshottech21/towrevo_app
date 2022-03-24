import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:towrevo/models/models.dart';

class UserHistoryList extends StatelessWidget {
  final UserHistoryModel userHistoryModel;

  const UserHistoryList({
    required this.userHistoryModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rating =
        userHistoryModel.rating == null ? 0 : userHistoryModel.rating!.rate;
    return FadeInUp(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
        height: MediaQuery.of(context).size.height * 0.16,
        width: MediaQuery.of(context).size.width,
        child: Card(
          elevation: 5,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userHistoryModel.companyName,
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
                          userHistoryModel.serviceName,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.0,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: List.generate(
                            5,
                            (index) => Icon(
                              rating <= index ? Icons.star_outline : Icons.star,
                              color: Colors.amber,
                              size: 15,
                            ),
                          ),
                        )
                      ],
                    ),
                    const Spacer(),
                    Text(
                      userHistoryModel.date,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w400,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
