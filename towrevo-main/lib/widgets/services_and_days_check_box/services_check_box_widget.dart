import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/models/services_model.dart';
import '../../view_model/services_and_day_view_model.dart';

class ServiceCheckBoxWidget extends StatelessWidget {
  const ServiceCheckBoxWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<ServicesModel>(context, listen: true);
    final registerViewModel =
        Provider.of<ServicesAndDaysViewModel>(context, listen: false);

    return CheckboxListTile(
      value: service.serviceAvailable,
      onChanged: (val) {
        registerViewModel.notify();

        if (service.serviceAvailable) {
          registerViewModel.servicesId
              .removeWhere((element) => element.toString() == service.id);
        } else if (!service.serviceAvailable) {
          registerViewModel.servicesId.add(service.id);
        }

        service.toggleService();
      },
      title: Text(
        service.name,
      ),
    );
  }
}
