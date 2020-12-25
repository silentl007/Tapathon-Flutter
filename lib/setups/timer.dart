import 'dart:async';
import 'package:Tapathon/setups/screentaps.dart';
import 'package:flutter/material.dart';

class CountDown extends StatefulWidget {
  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<CountDown> {
  int _counter = 10;
  String buttontext = 'Start';
  var value = ScreenTaps();
  Timer _timer;

  void _startTimer() {
    _counter = 10;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          buttontext = 'Disabled';
          _counter--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          (_counter > 0)
              ? Text('')
              : Text(
                  'hello',
                  style: TextStyle(color: Colors.red, fontSize: 30),
                ),
          Text('$_counter'),
          RaisedButton(
            onPressed: () => _startTimer(),
            child: Text('$buttontext'),
          )
        ],
      ),
    );
  }
}
