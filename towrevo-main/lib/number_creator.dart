import 'dart:async';

import 'package:flutter/cupertino.dart';

class NumberCreator{
  final _controller = StreamController<int>();
  int _count = 1;

  NumberCreator(BuildContext context){
    _count = 1;
    Timer.periodic(const Duration(seconds: 1), (timer) {

      try {
        if(_count >= 30){
                timer.cancel();
                _controller.sink.done;
                _controller.sink.close();

                Navigator.of(context).pop();
              }
        _controller.sink.add(_count);
        _count++;
      } catch (e) {
        print(e);
      }
    });
  }

  Stream<int> get stream => _controller.stream;
}