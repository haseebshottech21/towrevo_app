import 'dart:async';

import 'package:flutter/material.dart';

class CowntdownTimer extends StatefulWidget {
  const CowntdownTimer({Key? key}) : super(key: key);

  @override
  _CowntdownTimerState createState() => _CowntdownTimerState();
}

class _CowntdownTimerState extends State<CowntdownTimer> {
  static const maxseconds = 10;
  int seconds = maxseconds;
  Timer? timer;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (seconds > 0) {
        setState(() {
          seconds--;
        });
      } else {
        stopTimer();
      }
    });
  }

  void stopTimer() {
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = seconds == maxseconds || seconds == 0;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (seconds == 0)
              Icon(
                Icons.done,
                color: Colors.green,
                size: 100,
              ),
            if (seconds > 0)
              SizedBox(
                width: 200,
                height: 200,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CircularProgressIndicator(
                      value: 1 - seconds / maxseconds,
                      valueColor: AlwaysStoppedAnimation(Colors.black),
                      strokeWidth: 12,
                      backgroundColor: Colors.greenAccent,
                    ),
                    Center(
                      child: buildTime(),
                    )
                  ],
                ),
              ),
            SizedBox(height: 10),
            isRunning || !isCompleted
                ? ElevatedButton(
                    onPressed: () {
                      stopTimer();
                    },
                    child: Text('Pause'),
                  )
                : ElevatedButton(
                    onPressed: () {
                      startTimer();
                    },
                    child: Text('Start'),
                  )
          ],
        ),
      ),
    );
  }

  Widget buildTime() {
    return Text(
      '$seconds',
      style: TextStyle(
        color: Colors.black,
        fontSize: 80,
      ),
    );
  }
}
