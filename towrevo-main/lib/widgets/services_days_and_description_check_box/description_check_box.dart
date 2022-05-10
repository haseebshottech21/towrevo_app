import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/models/service_description.dart';
import 'package:towrevo/view_model/register_company_view_model.dart';

class DescriptionCheckBoxWidget extends StatelessWidget {
  final RegisterCompanyViewModel registerCompanyViewModel;
  final TextEditingController descriptionController;
  const DescriptionCheckBoxWidget({
    required this.registerCompanyViewModel,
    required this.descriptionController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serviceDescriptionModel =
        Provider.of<ServiceDescriptionModel>(context, listen: true);

    return Column(
      children: [
        CheckboxListTile(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          value: serviceDescriptionModel.isActive,
          onChanged: (val) {
            if (serviceDescriptionModel.isActive &&
                serviceDescriptionModel.title == 'Other') {
              descriptionController.clear();
            }
            serviceDescriptionModel.toggleServiceDescription();
            registerCompanyViewModel.notify();
          },
          title: Text(
            serviceDescriptionModel.title,
          ),
        ),
      ],
    );
  }
}
