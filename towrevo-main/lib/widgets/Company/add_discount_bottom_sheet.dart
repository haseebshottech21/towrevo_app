import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:towrevo/utilities/towrevo_appcolor.dart';

// This function is triggered when the floating buttion is pressed
void showCouponField({
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
                  'Apply Coupon',
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
                hintText: 'Add your coupon code',
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
              child: TextButton(
                onPressed: onPressed,
                child: const Text('APPLY'),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// This function is triggered when the floating buttion is pressed
void showDiscountPayment(
  BuildContext context,
  // String total,
  String discount,
  // String pay,
  VoidCallback onPressed,
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
        left: 10,
        right: 10,
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
                'Discount Payment',
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
          Text(
            '\$ 0',
            style: GoogleFonts.montserrat(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Subtotal'),
              Text('\$ 0'),
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
                        fontSize: 12.0,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '$discount OFF',
                    style: GoogleFonts.montserrat(
                      color: Colors.black45,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.0,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
              Text(
                '- \$8.55',
                style: GoogleFonts.montserrat(
                  color: Colors.black45,
                  fontWeight: FontWeight.w400,
                  fontSize: 12.0,
                  letterSpacing: 1,
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
              const Text('Total'),
              Text('\$${double.parse('15.0') / 100}'),
            ],
          ),
          const SizedBox(height: 15),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: AppColors.primaryColor,
              ),
              onPressed: onPressed,
              child: const Text('PAY NOW'),
            ),
          ),
        ],
      ),
    ),
  );
}
