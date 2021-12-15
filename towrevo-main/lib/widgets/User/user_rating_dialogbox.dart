import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class UserRatingDialog extends StatefulWidget {
  const UserRatingDialog({Key? key}) : super(key: key);

  @override
  _UserRatingDialogState createState() => _UserRatingDialogState();
}

class _UserRatingDialogState extends State<UserRatingDialog> {
  int rating = 0;

  void rate(int rate) {
    setState(() {
      rating = rate;
      print(rating);
    });
  }

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
              Text('Company Name'),
              Text('Company Service'),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      rate(1);
                    },
                    child: Icon(
                      Icons.star,
                      color: rating >= 1 ? Colors.orange : Colors.grey,
                      size: 45,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      rate(2);
                    },
                    child: Icon(
                      Icons.star,
                      color: rating >= 2 ? Colors.orange : Colors.grey,
                      size: 45,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      rate(3);
                    },
                    child: Icon(
                      Icons.star,
                      color: rating >= 3 ? Colors.orange : Colors.grey,
                      size: 45,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      rate(4);
                    },
                    child: Icon(
                      Icons.star,
                      color: rating >= 4 ? Colors.orange : Colors.grey,
                      size: 45,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      rate(5);
                    },
                    child: Icon(
                      Icons.star,
                      color: rating >= 5 ? Colors.orange : Colors.grey,
                      size: 45,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text('Love It'),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {},
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
