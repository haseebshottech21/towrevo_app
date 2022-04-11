import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:towrevo/models/models.dart';

class CompanyHistoryList extends StatelessWidget {
  final ServiceRequestModel serviceRequestModel;

  const CompanyHistoryList({
    required this.serviceRequestModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int rating = serviceRequestModel.reviewModel == null
        ? 0
        : serviceRequestModel.reviewModel!.rate;
    return FadeInUp(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
        // height: MediaQuery.of(context).size.height * 0.22,
        width: MediaQuery.of(context).size.width,
        child: Card(
          elevation: 5,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
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
                          serviceRequestModel.name.toUpperCase(),
                          style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 17.0,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          serviceRequestModel.serviceName.toUpperCase(),
                          style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.0,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: List.generate(
                            5,
                            (index) => Icon(
                              rating <= index ? Icons.star_outline : Icons.star,
                              color: Colors.amber,
                              size: 18,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      serviceRequestModel.createdAt,
                      style: GoogleFonts.montserrat(
                        color: Colors.black54,
                        fontWeight: FontWeight.w400,
                        fontSize: 12.0,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Text(
                          serviceRequestModel.status == 1
                              ? 'ACCEPT'
                              : serviceRequestModel.status == 2
                                  ? 'DECLINE'
                                  : 'COMPLETED',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                            color: serviceRequestModel.status == 1
                                ? Colors.green
                                : serviceRequestModel.status == 2
                                    ? Colors.red
                                    : Colors.green[800],
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
