import 'dart:math';
import 'package:acespeak/STUDENT/HOME/LESSONS/post-assessment/speech%20reco/speech_score.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Loading_scores extends StatefulWidget {
  final String userId;
  final String grade;
  final String lesson;
  final String docId;
  final String pre_assessment;
  const Loading_scores({super.key,
  required this.userId,
    required this.grade,
    required this.lesson,
    required this.docId,
    required this.pre_assessment,
  });

  @override
  State<Loading_scores> createState() => _Loading_scoresState();
}

class _Loading_scoresState extends State<Loading_scores> {
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
            Score();
    });
  }
  List<String>scores =[];
  Future<void> Score() async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('score').doc(widget.userId+widget.grade).get();

      if (userDoc.exists) {
        Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;

        scores = (data[widget.lesson + ' lesson'] as List<dynamic>?)?.cast<String>() ?? [];
        print(scores);
      }

      Navigator.push(context, MaterialPageRoute(builder: (ctx) {
        return SpeechPost_Assessment_Score(
        userId: widget.userId,
        lesson: widget.lesson,
        grade: widget.grade, 
        docId: widget.docId,
        pre_assessment: widget.pre_assessment,
      );
      }));       
    } catch (e) {
      print('Error updating score: $e');
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