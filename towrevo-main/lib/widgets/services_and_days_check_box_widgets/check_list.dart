import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:towrevo/screens/colors/towrevo_appcolor.dart';

Map<String, bool> cityList = {
  'Monday': false,
  'Tuesday': false,
  'Wednesday': false,
  'Thursday': false,
  'Friday': false,
  'Sarturday': false,
  'Sunday': false,
};

// ignore: camel_case_types
class showCheckboxList extends StatefulWidget {
  const showCheckboxList({Key? key}) : super(key: key);

  @override
  _showCheckboxListState createState() => _showCheckboxListState();
}

class _showCheckboxListState extends State<showCheckboxList> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(primary: Colors.black),
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return StatefulBuilder(
                builder: (context, setState) {
                  return AlertDialog(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                    ),
                    // backgroundColor: AppColors.primaryColor,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Select Days',
                        ),
                        FaIcon(FontAwesomeIcons.calendarDay)
                      ],
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, null);
                        },
                        child: const Text(
                          'Cancle',
                          // style: TextStyle(color: AppColors.primaryColor),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, cityList);
                        },
                        child: const Text(
                          'Done',
                          // style: TextStyle(color: AppColors.primaryColor),
                        ),
                      ),
                    ],
                    content: SizedBox(
                      width: double.minPositive,
                      height: 400,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: cityList.length,
                        itemBuilder: (BuildContext context, int index) {
                          String _key = cityList.keys.elementAt(index);
                          return CheckboxListTile(
                            activeColor: AppColors.primaryColor,
                            // checkColor: AppColors.primaryColor,
                            value: cityList[_key],
                            title: Text(
                              _key,
                            ),
                            onChanged: (val) {
                              setState(() {
                                cityList[_key] = val!;
                              });
                            },
                          );
                        },
                      ),
                    ),
                  );
                },
              );
            });
      },
      child: const Text('Select Check Box'),
    );
  }
}
