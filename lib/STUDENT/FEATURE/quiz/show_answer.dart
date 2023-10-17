import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ShowAnswerScreen extends StatefulWidget {
  final String question;
  final String answer;
  final String userAnswer;
  final List<dynamic> choices;

  ShowAnswerScreen(
      {Key? key,
      required this.question,
      required this.answer,
      required this.choices,
      required this.userAnswer})
      : super(key: key);

  @override
  _ShowAnswerScreenState createState() => _ShowAnswerScreenState();
}

class _ShowAnswerScreenState extends State<ShowAnswerScreen> {
  int _secondsRemaining = 5;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _timer.cancel();
          Navigator.of(context).pop(); 
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/bg4.png',
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      '$_secondsRemaining seconds.',
                      style: TextStyle(fontSize: 30, color: Color.fromARGB(255, 9, 77, 11), fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    height: 200.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/board.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: ListView(
                      children: <Widget>[
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              widget.question,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 22.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 320,
                    child: ListView.builder(
                      itemCount: widget.choices.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          height: 80.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                widget.userAnswer == widget.answer &&
                                        widget.choices[index] == widget.answer
                                    ? 'assets/images/correct.png'
                                    : (widget.userAnswer != widget.answer &&
                                            widget.userAnswer ==
                                                widget.choices[index]
                                        ? 'assets/images/wrong.png'
                                        : (widget.answer ==
                                                widget.choices[index]
                                            ? 'assets/images/correct.png'
                                            : 'assets/images/choices.png')),
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                widget.choices[index],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
