import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:towrevo/models/service_description.dart';
import 'package:towrevo/view_model/register_company_view_model.dart';
import 'package:towrevo/view_model/services_and_day_view_model.dart';
// import 'package:towrevo/widgets/services_days_and_description_check_box/days_check_box_widget.dart';
import 'package:towrevo/widgets/services_days_and_description_check_box/description_check_box.dart';
// import 'package:towrevo/widgets/services_days_and_description_check_box/services_check_box_widget.dart';
import 'package:towrevo/widgets/widgets.dart';

// Future<void> showCategories(BuildContext context) async {
//   await showDialog(
//     context: context,
//     builder: (_) {
//       return AlertDialog(
//         content: Consumer<ServicesAndDaysViewModel>(
//             builder: (ctx, provider, neverBuildChild) {
//           return Column(
//               mainAxisSize: MainAxisSize.min,
//               children: provider.serviceListViewModel.map((item) {
//                 return ChangeNotifierProvider.value(
//                   value: provider.serviceListViewModel[
//                       provider.serviceListViewModel.indexOf(item)],
//                   child: const ServiceCheckBoxWidget(),
//                 );
//               }).toList());
//         }),
//       );
//     },
//   );
// }

// Future<void> showDays(BuildContext context) async {
//   await showDialog(
//     context: context,
//     builder: (_) {
//       return AlertDialog(
//         content: Consumer<ServicesAndDaysViewModel>(
//             builder: (ctx, provider, neverBuildChild) {
//           return Column(
//               mainAxisSize: MainAxisSize.min,
//               children: provider.daysListViewModel.map((item) {
//                 return ChangeNotifierProvider.value(
//                   value: provider.daysListViewModel[
//                       provider.daysListViewModel.indexOf(item)],
//                   child: const DaysCheckBoxWidget(),
//                 );
//               }).toList());
//         }),
//       );
//     },
//   );
// }

// Future<void> showServiceDescription(BuildContext context) async {
//   await showDialog(
//     context: context,
//     builder: (_) {
//       return AlertDialog(
//         content: Consumer<RegisterCompanyViewModel>(
//             builder: (ctx, provider, neverBuildChild) {
//           return Column(
//               mainAxisSize: MainAxisSize.min,
//               children: provider.servicesDespriptionList.map((item) {
//                 return ChangeNotifierProvider.value(
//                   value: provider.servicesDespriptionList[
//                       provider.servicesDespriptionList.indexOf(item)],
//                   child: DescriptionCheckBoxWidget(
//                       registerCompanyViewModel: provider),
//                 );
//               }).toList());
//         }),
//       );
//     },
//   );
// }

Future<void> showDays(BuildContext context, bool fromSignUp) async {
  final daysProvider =
      Provider.of<ServicesAndDaysViewModel>(context, listen: false);
  await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (_) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15.r),
          ),
        ),
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
          if (fromSignUp)
            TextButton(
              onPressed: () {
                daysProvider.clearDaysList();
                Navigator.pop(context, null);
              },
              child: const Text(
                'Cancle',
              ),
            ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Done',
            ),
          ),
        ],
        content: Consumer<ServicesAndDaysViewModel>(
          builder: (ctx, provider, neverBuildChild) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: provider.daysListViewModel.map(
                (item) {
                  return ChangeNotifierProvider.value(
                    value: provider.daysListViewModel[
                        provider.daysListViewModel.indexOf(item)],
                    child: const DaysCheckBoxWidget(),
                  );
                },
              ).toList(),
            );
          },
        ),
      );
    },
  );
}

Future<void> showCategories(BuildContext context, bool fromSignUp) async {
  final servicesProvider =
      Provider.of<ServicesAndDaysViewModel>(context, listen: false);
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15.r),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Select Categories',
            ),
            FaIcon(FontAwesomeIcons.servicestack)
          ],
        ),
        actions: <Widget>[
          if (fromSignUp)
            TextButton(
              onPressed: () {
                servicesProvider.clearServicesList();
                Navigator.pop(context, null);
              },
              child: const Text(
                'Cancel',
              ),
            ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Done',
            ),
          ),
        ],
        content: Consumer<ServicesAndDaysViewModel>(
          builder: (ctx, provider, neverBuildChild) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: provider.serviceListViewModel.map(
                (item) {
                  return ChangeNotifierProvider.value(
                    value: provider.serviceListViewModel[
                        provider.serviceListViewModel.indexOf(item)],
                    child: const ServiceCheckBoxWidget(),
                  );
                },
              ).toList(),
            );
          },
        ),
      );
    },
  );
}

Future<void> showServiceDescription(
    RegisterCompanyViewModel registerViewModel,
    BuildContext context,
    bool fromSignUp,
    TextEditingController descriptionController) async {
  final formKey = GlobalKey<FormState>();

  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15.r),
          ),
        ),
        title: const Text('Select Company Services'),
        //      Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: const [
        //     Text(
        //       'Select Company Services',
        //     ),
        //     FaIcon(FontAwesomeIcons.servicestack)
        //   ],
        // ),
        actions: <Widget>[
          if (fromSignUp)
            TextButton(
              onPressed: () {
                registerViewModel.clearServiceDescriptionList();
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
              ),
            ),
          TextButton(
            onPressed: () {
              if (!formKey.currentState!.validate()) {
                return;
              }
              registerViewModel.notify();
              Navigator.of(context).pop();
            },
            child: const Text(
              'Done',
            ),
          ),
        ],
        content: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: registerViewModel.servicesDespriptionList.map(
                  (item) {
                    return ChangeNotifierProvider.value(
                      value: registerViewModel.servicesDespriptionList[
                          registerViewModel.servicesDespriptionList
                              .indexOf(item)],
                      child: DescriptionCheckBoxWidget(
                        registerCompanyViewModel: registerViewModel,
                        descriptionController: descriptionController,
                      ),
                    );
                  },
                ).toList(),
              ),
              Form(
                key: formKey,
                child: Consumer<RegisterCompanyViewModel>(
                  builder: (context, value, child) {
                    return value.servicesDespriptionList.last.isActive
                        ? TextFieldForAll(
                            hintText: 'Other Service Description',
                            errorGetter: (val) {
                              if (val.toString().isEmpty) {
                                return 'Required Description';
                              }
                              return null;
                            },
                            prefixIcon: const Icon(Icons.scatter_plot_sharp),
                            textEditingController: descriptionController,
                            textInputType: TextInputType.text,
                          )
                        : const SizedBox();
                  },
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
