import 'package:flutter/material.dart';

AlertDialog completeJobDialogbox() {
  return AlertDialog(
    backgroundColor: const Color(0xFF092848),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Are You Sure Job is Completed ?',
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
              child: const Text('NO'),
            ),
            const SizedBox(
              width: 10,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
              ),
              child: const Text('YES'),
            ),
          ],
        )
      ],
    ),
    // actions: [
    //   ElevatedButton(
    //     onPressed: () {},
    //     child: Text('Yes'),
    //   )
    // ],
  );
}


// showDialog(
//                             context: context,
//                             builder: (ctxt) => AlertDialog(
//                               content: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Container(
//                                     height: 100,
//                                     width: MediaQuery.of(context).size.width *
//                                         0.40,
//                                     child: const CircleAvatar(
//                                       backgroundColor: Colors.green,
//                                       child: FaIcon(FontAwesomeIcons.check),
//                                     ),
//                                   ),
//                                   const SizedBox(
//                                     height: 10,
//                                   ),
//                                   const Text(
//                                     'SuccessFully Send!',
//                                     style: TextStyle(
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );