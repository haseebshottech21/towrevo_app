import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:towrevo/screens/company/company_payment_screen.dart';
import 'package:towrevo/utilities/towrevo_appcolor.dart';
import 'package:towrevo/view_model/payment_view_model.dart';

// This function is triggered when the floating buttion is pressed
void showVoucherField({
  required BuildContext context,
  required Function errorGetter,
  required TextEditingController controller,
  required VoidCallback onPressed,
  required GlobalKey formKey,
}) {
  showModalBottomSheet(
    isScrollControlled: true,
    elevation: 5,
    context: context,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
    ),
    builder: (ctx) => Padding(
      padding: EdgeInsets.only(
        top: 5,
        left: 10,
        right: 10,
        bottom: MediaQuery.of(ctx).viewInsets.bottom + 15,
      ),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Apply your Voucher Code',
                  style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 18.0,
                    letterSpacing: 1,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close, size: 20),
                )
              ],
            ),
            const SizedBox(height: 5),
            TextFormField(
              controller: controller,
              textAlignVertical: TextAlignVertical.center,
              enableInteractiveSelection: true,
              readOnly: false,
              toolbarOptions: const ToolbarOptions(
                paste: true,
                cut: true,
                selectAll: true,
                copy: true,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: 'Voucher code',
                hintStyle: const TextStyle(color: Colors.black45),
                // prefixIcon: Padding(
                //   padding: const EdgeInsets.only(left: 20),
                //   child: prefixIcon,
                // ),
                prefixText: '  ',
                prefixStyle: const TextStyle(color: Colors.black, fontSize: 16),
              ),
              onSaved: (newValue) {
                controller.text = newValue!;
              },
              validator: (value) => errorGetter(value),
            ),
            const SizedBox(height: 5),
            Align(
              alignment: Alignment.centerRight,
              child: Consumer<PaymentViewModel>(
                  builder: (ctx, paymentViewModel, _) {
                return TextButton(
                  onPressed: paymentViewModel.isLoading ? null : onPressed,
                  child: paymentViewModel.isLoading
                      ? const SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(
                            color: Colors.grey,
                            strokeWidth: 3,
                          ),
                        )
                      : const Text('APPLY'),
                );
              }),
            ),
          ],
        ),
      ),
    ),
  ).then((value) {
    controller.clear();
  });
}

// This function is triggered when the floating buttion is pressed
void showDiscountPayment(
  BuildContext context,
  // String total,
  String couponCode,
  String discount,
  // String pay,
  Function onPressed,
) {
  showModalBottomSheet(
    isScrollControlled: true,
    elevation: 5,
    context: context,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
    ),
    builder: (ctx) => Padding(
      padding: EdgeInsets.only(
        top: 5,
        left: 12,
        right: 12,
        bottom: MediaQuery.of(ctx).viewInsets.bottom + 15,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Payment',
                style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 18.0,
                  letterSpacing: 1,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close, size: 20),
              )
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$ ${CompanyPaymentScreen.payAmmount / 100}',
                style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 17.0,
                  letterSpacing: 0.5,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  couponCode.toUpperCase(),
                  style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 13.0,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Subtotal',
                style: GoogleFonts.montserrat(
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                  fontSize: 13.0,
                  letterSpacing: 0.3,
                ),
              ),
              Text(
                '\$ ${CompanyPaymentScreen.payAmmount / 100}',
                style: GoogleFonts.montserrat(
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                  fontSize: 13.0,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          const Divider(),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.amber[100],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      'DISCOUNT',
                      style: GoogleFonts.montserrat(
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.w500,
                        fontSize: 13.0,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      '$discount% OFF',
                      style: GoogleFonts.montserrat(
                        color: Colors.black45,
                        fontWeight: FontWeight.w400,
                        fontSize: 13.0,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                '- \$ ${((CompanyPaymentScreen.payAmmount / 100) / 100 * int.parse(discount)).toStringAsFixed(2)}',
                style: GoogleFonts.montserrat(
                  color: Colors.black45,
                  fontWeight: FontWeight.w400,
                  fontSize: 13.0,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          const Divider(),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: GoogleFonts.montserrat(
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                  letterSpacing: 0.3,
                ),
              ),
              Text(
                '\$ ${((CompanyPaymentScreen.payAmmount / 100) - ((CompanyPaymentScreen.payAmmount / 100) / 100 * int.parse(discount))).toStringAsFixed(2)}',
                style: GoogleFonts.montserrat(
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: AppColors.primaryColor,
              ),
              onPressed: () => onPressed(),
              child: Text(
                'PAY NOW',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 15.0,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
