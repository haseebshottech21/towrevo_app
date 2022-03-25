import 'dart:async';

import 'package:flutter/cupertino.dart';

class NumberCreator {
  final _controller = StreamController<int>();
  int _count = 30;

  NumberCreator(BuildContext context) {
    
    _count = 30;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      try {
        if (_count <= 0) {
          timer.cancel();
          _controller.sink.done;
          _controller.sink.close();

          Navigator.of(context).pop(true);
        }
        _controller.sink.add(_count);
        _count--;
      } catch (e) {
        print(e);
      }
    });
  }

  Stream<int> get stream => _controller.stream;
}
