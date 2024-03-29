import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/models/days_model.dart';
import 'package:towrevo/view_model/services_and_day_view_model.dart';

class DaysCheckBoxWidget extends StatelessWidget {
  const DaysCheckBoxWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final days = Provider.of<DaysModel>(context, listen: true);
    final registerViewModel =
        Provider.of<ServicesAndDaysViewModel>(context, listen: false);

    return CheckboxListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      value: days.dayAvailable,
      onChanged: (val) {
        registerViewModel.notify();
        if (days.dayAvailable) {
          registerViewModel.daysId
              .removeWhere((element) => element.toString() == days.id);
        } else if (!days.dayAvailable) {
          registerViewModel.daysId.add(days.id);
        }

        days.toggleDay();
      },
      title: Text(
        days.name,
      ),
    );
  }
}
