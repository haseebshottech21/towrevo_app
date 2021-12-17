import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/view_model/user_home_screen_view_model.dart';

class UserRatingDialog extends StatelessWidget {
  const UserRatingDialog({Key? key, required this.reqId}) : super(key: key);

  final String reqId;

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      // animate: true,
      // duration: Duration(milliseconds: 500),
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        backgroundColor: Colors.white,
        titlePadding: const EdgeInsets.symmetric(vertical: 10),
        title: const Text(
          'Rate Company',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
          ),
          textAlign: TextAlign.center,
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Company Name'),
              const Text('Company Service'),
              const SizedBox(
                height: 10,
              ),
              Consumer<UserHomeScreenViewModel>(
                  builder: (ctx, userViewModel, neverBuildChild) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        userViewModel.updateRating(1);
                      },
                      child: Icon(
                        Icons.star,
                        color: userViewModel.rating >= 1
                            ? Colors.orange
                            : Colors.grey,
                        size: 45,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        userViewModel.updateRating(2);
                      },
                      child: Icon(
                        Icons.star,
                        color: userViewModel.rating >= 2
                            ? Colors.orange
                            : Colors.grey,
                        size: 45,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        userViewModel.updateRating(3);
                      },
                      child: Icon(
                        Icons.star,
                        color: userViewModel.rating >= 3
                            ? Colors.orange
                            : Colors.grey,
                        size: 45,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        userViewModel.updateRating(4);
                      },
                      child: Icon(
                        Icons.star,
                        color: userViewModel.rating >= 4
                            ? Colors.orange
                            : Colors.grey,
                        size: 45,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        userViewModel.updateRating(5);
                      },
                      child: Icon(
                        Icons.star,
                        color: userViewModel.rating >= 5
                            ? Colors.orange
                            : Colors.grey,
                        size: 45,
                      ),
                    ),
                  ],
                );
              }),
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Text('Love It'),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              final provider =
                  Provider.of<UserHomeScreenViewModel>(context, listen: false);
              provider.subimtRating(reqId, provider.rating.toString(), context);
            },
            style: ElevatedButton.styleFrom(
              primary: const Color(0xFF092848),
              shape: const StadiumBorder(),
            ),
            child: const Text('SUBMIT'),
          )
        ],
      ),
    );
  }
}
