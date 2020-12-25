import 'dart:async';
import 'package:flutter/material.dart';

class ScreenTaps extends StatefulWidget {
  @override
  _ScreenTapsState createState() => _ScreenTapsState();
}

class _ScreenTapsState extends State<ScreenTaps> {
  List timeleft = [10];
  List targetscores = [
    60,
    80,
    100,
    120,
    140,
    160,
    180,
    200,
    220,
    240,
    260,
    280,
    300
  ];
  int currentscore = 0;
  int targetscore = 40;
  int counter = 10;
  int levelcontroller = -1;
  int incrementcontroller = 1;
  Timer timer;
  String buttontext = 'Start';
  // -------- Perks Count ------------------
  int timerperk = 1;
  int multiplierperk = 1;
  int boostperk = 1;
  // -------- List Function Controllers --------------
  int inkwellcontroller = 1;
  int timerbuttoncontroller = 0;
  int timerperkcontroller = 0;
  int retrycontroller = 0;
  int multiplierperkcontroller = 0;
  int boostperkcontroller = 0;

  void reset() {
    setState(() {
      currentscore = 0;
      incrementcontroller = 1;
      counter = timeleft.last;
      buttontext = 'Start';
      timerbuttoncontroller = 0;
      timerperkcontroller = 0;
      multiplierperkcontroller = 0;
      boostperkcontroller = 0;
    });
  }

  void increments() {
    print(currentscore);
    if ((targetscore) == currentscore) {
      setState(() {
        inkwellcontroller = 1;
        retrycontroller = 0;
      });
      timer.cancel();
    } else {
      setState(() {
        currentscore = currentscore + incrementcontroller;
      });
    }
  }

  void nextlevel() {
    if ((levelcontroller + 2) % 2 == 1) {
      setState(() {
        print('add perks 2');
        levelcontroller++;
        currentscore = 0;
        counter = 5 + counter;
        targetscore = targetscores[levelcontroller];
        buttontext = 'Start';
        incrementcontroller = 1;
        timerbuttoncontroller = 0;
        timerperkcontroller = 0;
        multiplierperkcontroller = 0;
        boostperkcontroller = 0;
        timeleft.add(counter);
        boostperk++;
        timerperk++;
      });
    } else if ((levelcontroller + 2) % 10 == 0) {
      setState(() {
        print('add perks 3');
        levelcontroller++;
        currentscore = 0;
        counter = 5 + counter;
        targetscore = targetscores[levelcontroller];
        buttontext = 'Start';
        incrementcontroller = 1;
        timerbuttoncontroller = 0;
        timerperkcontroller = 0;
        multiplierperkcontroller = 0;
        boostperkcontroller = 0;
        timeleft.add(counter);
        boostperk++;
        timerperk++;
        multiplierperk++;
      });
    } else {
      print('no perks added');
      setState(() {
        levelcontroller++;
        currentscore = 0;
        counter = 5 + counter;
        targetscore = targetscores[levelcontroller];
        buttontext = 'Start';
        incrementcontroller = 1;
        timerbuttoncontroller = 0;
        timerperkcontroller = 0;
        multiplierperkcontroller = 0;
        boostperkcontroller = 0;
        timeleft.add(counter);
      });
    }
  }

  void _startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (counter > 0) {
        setState(() {
          counter--;
          print(counter);
        });
      } else {
        timer.cancel();
        // showDialog(
        //   context: context,
        //   builder: (context) => AlertDialog(
        //     title: Text('data'),
        //   ),
        // );
        setState(() {
          inkwellcontroller = 1;
          timerbuttoncontroller = 0;
          retrycontroller = 0;
          timerperkcontroller = 0;
          multiplierperkcontroller = 0;
          boostperkcontroller = 0;
        }); 
      }
    });
    setState(() {
      print('hello from setstate');
      inkwellcontroller = 0;
      timerbuttoncontroller = 1;
      retrycontroller = 1;
      timerperkcontroller = 1;
      multiplierperkcontroller = 1;
      boostperkcontroller = 1;
      buttontext = 'Disabled';
    });
  }

  void perkstimer() {
    if (timerperk == 0) {
      return null;
    } else {
      setState(() {
        counter = counter + 5;
        timerperk--;
        timeleft.add(counter);
      });
    }
  }

  void perksmultiplier() {
    if (multiplierperk == 0) {
      return null;
    } else {
      setState(() {
        multiplierperk--;
        incrementcontroller = 2;
        multiplierperkcontroller = 1;
      });
    }
  }

  void perksboost() {
    if (boostperk == 0) {
      return null;
    } else {
      setState(() {
        boostperk--;
        currentscore = currentscore + 20;
      });
    }
  }

  void _end() {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    List<Function> inkwelltaplist = [increments, _end];
    List<Function> starttimelist = [_startTimer, _end];
    List<Function> retrylist = [reset, _end];
    List<Function> timerperklist = [perkstimer, _end];
    List<Function> multiplierperklist = [perksmultiplier, _end];
    List<Function> boostperklist = [perksboost, _end];

    return Scaffold(
      appBar: AppBar(
        title: Text('Tapathon'),
        centerTitle: true,
      ),
      body: InkWell(
        onTap: inkwelltaplist[inkwellcontroller],
        child: Container(
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  Text(
                    'Target: $targetscore',
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Current Score: $currentscore',
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Current Level: ${levelcontroller + 2}',
                    style: TextStyle(fontSize: 15),
                  )
                ],
              ),
              (counter == 0)
                  ? Text(
                      'Failed',
                      style: TextStyle(color: Colors.red, fontSize: 30),
                    )
                  : (currentscore >= targetscore)
                      ? Text(
                          'Success',
                          style: TextStyle(color: Colors.green, fontSize: 30),
                        )
                      : Text(
                          '',
                          style: TextStyle(color: Colors.red, fontSize: 30),
                        ),
              Text(
                '$counter',
                style: TextStyle(fontSize: 20),
              ),
              RaisedButton(
                onPressed: starttimelist[timerbuttoncontroller],
                child: Text('$buttontext'),
              ),
              RaisedButton(
                onPressed: retrylist[retrycontroller],
                child: Text('Retry'),
              ),
              (currentscore >= targetscore)
                  ? RaisedButton(
                      onPressed: nextlevel,
                      child: Text('Next Level'),
                    )
                  : Text(''),
              Row(
                children: <Widget>[
                  RaisedButton(
                    onPressed: timerperklist[timerperkcontroller],
                    child: Text('Timer: $timerperk'),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  RaisedButton(
                    onPressed: multiplierperklist[multiplierperkcontroller],
                    child: Text('Multiplier: $multiplierperk'),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  RaisedButton(
                    onPressed: boostperklist[boostperkcontroller],
                    child: Text('Boost: $boostperk'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

// create a persistent alert box that asks if the user wants to go to next level or retry
