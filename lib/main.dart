import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Pomodoro(),
    ));

class Pomodoro extends StatefulWidget {
  var buttonText = 'Start';
  var buttonColor = Colors.blue[300];
  @override
  _PomodoroState createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> {
  static int timeInMinut = 25;
  double percent = 0;
  int timeInSec = timeInMinut * 60;

  Timer timer;

  _stopTimer(){
    if(widget.buttonText == 'Stop'){
      setState(() {
        timer.cancel();
        widget.buttonText = 'Start';
        widget.buttonColor = Colors.blue[300];
        percent = 0;
        timeInMinut = 25;
      });
    }
  }

  _startTimer(){
    widget.buttonColor = Colors.red;
    widget.buttonText = 'Stop';
    timeInMinut = 25;
    int time = timeInMinut * 60;
    double secPercent = (time/100);
    percent = 0;
    
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
         if(time > 0){
          time--;
          if(time % 60 == 0){
            timeInMinut--;
          }
          if(time % secPercent == 0){
            if(percent < 1){
              percent += 0.01;
            }else{
              percent = 1;
            }
          }
        }else{
          percent = 0;
          timeInMinut = 25;
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xff1542bf), Color(0xff51a8ff)],
                begin: FractionalOffset(0.5, 1))),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 18.0),
              child: Text(
                "Pomodoro Clock",
                style: TextStyle(color: Colors.white, fontSize: 40.0),
              ),
            ),
            Expanded(
                child: CircularPercentIndicator(
                  circularStrokeCap: CircularStrokeCap.round,
                  backgroundColor: Colors.blue[50],
                  percent: percent,
                  animation: true,
                  animateFromLastPercent: true,
                  radius: 200,
                  lineWidth: 20,
                  progressColor: Colors.blue[300],
                  center: Text(
                    '$timeInMinut',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 80,
                    ),
                  ),
              )),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Padding(
                  padding: EdgeInsets.only(top: 30, left: 20, right: 20),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: Column(
                              children: <Widget>[
                                Text('Timer Lenght',
                                    style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '25',
                                  style: TextStyle(fontSize: 60,fontWeight: FontWeight.bold),
                                )
                              ],
                            )),
                            Expanded(
                                child: Column(
                              children: <Widget>[
                                Text('Pause Time',
                                    style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '5',
                                  style: TextStyle(fontSize: 60,fontWeight: FontWeight.bold),
                                )
                              ],
                            )),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 28),
                        child: RaisedButton(
                          onPressed: widget.buttonText == 'Stop' ? _stopTimer : _startTimer,
                            color: widget.buttonColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Text(
                                widget.buttonText,
                                style: TextStyle(
                                    fontSize: 46, color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
