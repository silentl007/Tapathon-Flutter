import 'dart:async';
import 'package:flutter/material.dart';

class ScreenTaps extends StatefulWidget {
  @override
  _ScreenTapsState createState() => _ScreenTapsState();
}

class _ScreenTapsState extends State<ScreenTaps> {
  int current_score = 0;
  int target_score = 30;
  int _counter = 10;
  Timer _timer;
  String buttontext = 'Start';

  void increments() {
    setState(() {
      current_score++;
    });
  }

  void _startTimer() {
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
    Function inkwelltap = increments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Tapathon'),
        centerTitle: true,
      ),
      body: InkWell(
        onTap: inkwelltap,
        child: Container(
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  Text('Target: $target_score'),
                  Text('Current Score: $current_score')
                ],
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    (_counter > 0)
                        ? Text('')
                        : (current_score > target_score)
                            ? Text(
                                'Success',
                                style: TextStyle(
                                    color: Colors.green, fontSize: 30),
                              )
                            : Text(
                                'Failed',
                                style:
                                    TextStyle(color: Colors.red, fontSize: 30),
                              ),
                    Text('$_counter'),
                    RaisedButton(
                      onPressed: () {
                        print('button');
                        _startTimer();
                      },
                      child: Text('$buttontext'),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Test {
  // var collect = _ScreenTapsState();
  // Function start = collect.increments();
}
