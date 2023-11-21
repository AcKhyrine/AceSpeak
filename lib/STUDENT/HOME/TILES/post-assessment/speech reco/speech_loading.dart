import 'dart:math';
import 'package:acespeak/STUDENT/HOME/TILES/post-assessment/speech%20reco/speech_intro.dart';
import 'package:acespeak/STUDENT/HOME/TILES/post-assessment/speech%20reco/speech_speech.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SpeechPostAssessment1 extends StatefulWidget {
  final String userId;
  final String grade;
  final String lesson;
  final String post;
  SpeechPostAssessment1({super.key, required this.userId, required this.grade, required this.lesson, required this.post});

  @override
  State<SpeechPostAssessment1> createState() => _SpeechPostAssessment1State();
}

class _SpeechPostAssessment1State extends State<SpeechPostAssessment1> {
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
        .doc(widget.userId+widget.grade)
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
      print(length.toString()+'...........................................');
      if (length > 0) {
        Navigator.push(context, MaterialPageRoute(builder: (ctx) {
          return SpeechRecoScreen1(
          userId: widget.userId,
          grade: widget.grade,
          lesson: widget.lesson, 
          length: length,
          pre_assessment: widget.post,
         );
         }));
      } else {
        Navigator.push(
        context,
        MaterialPageRoute(builder: (ctx) {
          return SpeechPostAssessmentInstructionsScreen1(
            userId: widget.userId,
            grade: widget.grade,
            pre_assessment: widget.post,
            length: 0,
            lesson: widget.lesson,
          );
        }),
      );
      }
    } else {
      int i = 0;
      String len;
      while (true) {
        len = widget.lesson + ' ' + i.toString();
        if (data[len+ ' lesson'] != null) {
          int length = data[len + ' lesson'].length;
          if(length < 9){
            Navigator.push(
            context,
            MaterialPageRoute(builder: (ctx) {
              return SpeechPostAssessmentInstructionsScreen1(
                userId: widget.userId,
                grade: widget.grade,
                pre_assessment: widget.post,
                length: length > 0 ? length : 0,
                lesson: len,
              );
            }),
          );
          break;
          }else{
            i++;
          }
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (ctx) {
              return SpeechPostAssessmentInstructionsScreen1(
                userId: widget.userId,
                grade: widget.grade,
                pre_assessment: widget.post,
                length: 0,
                lesson: len,
              );
            }),
          );
          break;
        }
      }
    }
  } else {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (ctx) {
        return SpeechPostAssessmentInstructionsScreen1(
          userId: widget.userId,
          grade: widget.grade,
          pre_assessment: widget.post,
          length: 0,
          lesson: widget.lesson,
        );
      }),
    );
  }

  } catch (e) {
    print('Error fetching data: $e');
  }
}

  final List<String> gifPaths = [
    'assets/L1.gif',
    'assets/L2.gif',
    'assets/L3.gif'
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