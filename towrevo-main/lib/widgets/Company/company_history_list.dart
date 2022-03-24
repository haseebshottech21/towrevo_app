import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:towrevo/models/models.dart';

class CompanyHistoryList extends StatelessWidget {
  final ServiceRequestModel serviceRequestModel;

  const CompanyHistoryList({
    required this.serviceRequestModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('in company history');
    int rating = serviceRequestModel.reviewModel == null
        ? 0
        : serviceRequestModel.reviewModel!.rate;
    return FadeInUp(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
        height: MediaQuery.of(context).size.height * 0.22,
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
                          serviceRequestModel.name,
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
                          serviceRequestModel.serviceName,
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
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      serviceRequestModel.createdAt,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.0,
                      ),
                    ),
                    // Spacer(),
                    Container(
                      width: 100,
                      height: 35,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Text(
                          serviceRequestModel.status == 1
                              ? 'Accept'
                              : serviceRequestModel.status == 2
                                  ? 'Decline'
                                  : 'Completed',
                          style: TextStyle(
                            color: serviceRequestModel.status == 1
                                ? Colors.green
                                : serviceRequestModel.status == 2
                                    ? Colors.red
                                    : Colors.blueGrey,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
