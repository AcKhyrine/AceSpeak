import 'dart:math';
import 'package:acespeak/STUDENT/MAIN%20FEATURE/post-assessment/speech%20reco/speech_intro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SpeechPostAssessment extends StatefulWidget {
  final String userId;
  final String grade;
  final String lesson;
  final String classroomID;
  final String post;
  SpeechPostAssessment({super.key, required this.userId, required this.grade, required this.classroomID, required this.lesson, required this.post});

  @override
  State<SpeechPostAssessment> createState() => _SpeechPostAssessmentState();
}

class _SpeechPostAssessmentState extends State<SpeechPostAssessment> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      assessment();
    });
  }

void assessment() async {
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
    String pre = widget.lesson + ' lesson';
    if (data[pre] != null) {
    if (data[pre].length < 9) {
      int length = data[pre].length;
      if (length > 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (ctx) {
            return SpeechPostAssessmentInstructionsScreen(
              userId: widget.userId,
              grade: widget.grade,
              pre_assessment: widget.post,
              length: length,
              lesson: widget.lesson,
              classroomID : widget.classroomID
            );
          }),
        );
      } else {
        Navigator.push(
      context,
      MaterialPageRoute(builder: (ctx) {
        return SpeechPostAssessmentInstructionsScreen(
          userId: widget.userId,
          grade: widget.grade,
          pre_assessment: widget.post,
          length: 1,
          lesson: widget.lesson,
          classroomID : widget.classroomID
        );
      }),
    );
      }
    } else {
      await FirebaseFirestore.instance
        .collection('score')
        .doc(widget.userId)
        .update({
          widget.lesson + ' lesson': [],
          widget.lesson + 'wrong' : []
        });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (ctx) {
          return SpeechPostAssessmentInstructionsScreen(
            userId: widget.userId,
            grade: widget.grade,
            pre_assessment: widget.post,
            length: 1,
            lesson: widget.lesson,
            classroomID : widget.classroomID
          );
        }),
      );
    }
  } else {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (ctx) {
        return SpeechPostAssessmentInstructionsScreen(
          userId: widget.userId,
          grade: widget.grade,
          pre_assessment: widget.post,
          length: 1,
          lesson: widget.lesson,
          classroomID : widget.classroomID
        );
      }),
    );
  }

  } catch (e) {
    print('Error fetching data: $e');
  }
}


  final List<String> gifPaths = [
    // 'assets/loading1.gif',
    'assets/loading2.gif',
    'assets/loading3.gif',
    'assets/loading4.gif',
    // 'assets/loading5.gif',
  ];



  @override
  Widget build(BuildContext context) {
    int randomIndex = Random().nextInt(gifPaths.length);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
           Center(child: 
           Image.asset(gifPaths[randomIndex])
           )
        ],
      ),
    );
  }
}