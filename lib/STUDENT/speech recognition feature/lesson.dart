import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:acespeak/STUDENT/speech%20recognition%20feature/speech_recognition.dart';

class LessonScreen extends StatefulWidget {
  final String userId;
  final String grade;
  final String level;
  const LessonScreen(
      {super.key,
      required this.userId,
      required this.grade,
      required this.level});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  int lesson1 = 0, lesson2 = 0, lesson3 = 0, lesson4 = 0;
  @override
  void initState() {
    super.initState();
    lesson();
  }

  Future<void> lesson() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('score')
          .doc(widget.userId)
          .get();

      if (!snapshot.exists) {
        print('No documents found for the user ID: ${widget.userId}');
        return;
      }

      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      List<dynamic> assessmentArray = data['assessment'];
      lesson1 = data[widget.level + '-1 lesson'].length;
      lesson2 = data[widget.level + '-2 lesson'].length;
      lesson3 = data[widget.level + '-3 lesson'].length;
      lesson4 = data[widget.level + '-4 lesson'].length;
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                      return SpeechRecognition(
                          userId: widget.userId,
                          lesson: widget.level + '-1 lesson',
                          grade: widget.grade);
                    }));
                  },
                  child: Text(
                    'Lesson 1',
                  )),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (lesson1 == 10) {
                      Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                        return SpeechRecognition(
                            userId: widget.userId,
                            lesson: widget.level + '-2 lesson',
                            grade: widget.grade);
                      }));
                    } else {
                      EasyLoading.showError(
                          'Please complete lesson 1 before proceeding to lesson 2.');
                    }
                  },
                  child: Text(
                    'Lesson 2',
                  )),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (lesson2 == 10) {
                      Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                        return SpeechRecognition(
                            userId: widget.userId,
                            lesson: widget.level + '-3 lesson',
                            grade: widget.grade);
                      }));
                    } else {
                      EasyLoading.showError(
                          'Please complete lesson 2 before proceeding to lesson 3.');
                    }
                  },
                  child: Text('Lesson 3')),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (lesson3 == 10) {
                      Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                        return SpeechRecognition(
                            userId: widget.userId,
                            lesson: widget.level + '-4 lesson',
                            grade: widget.grade);
                      }));
                    } else {
                      EasyLoading.showError(
                          'Please complete lesson 3 before proceeding to lesson 4.');
                    }
                  },
                  child: Text('Lesson 4')),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (lesson4 == 10) {
                      Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                        return SpeechRecognition(
                            userId: widget.userId,
                            lesson: widget.level + '-5 lesson',
                            grade: widget.grade);
                      }));
                    } else {
                      EasyLoading.showError(
                          'Please complete lesson 4 before proceeding to lesson 5.');
                    }
                  },
                  child: Text('Lesson 5')),
            ],
          ),
        ),
      ),
    );
  }
}
