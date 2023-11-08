import 'dart:math';
import 'package:acespeak/STUDENT/HOME/TILES/post-assessment/audio%20choices/post-assessment-intro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PostAssessment1 extends StatefulWidget {
  final String userId;
  final String grade;
  final String lesson;
  final String post;
  const PostAssessment1({super.key, required this.userId, required this.grade, required this.lesson, required this.post});

  @override
  State<PostAssessment1> createState() => _PostAssessment1State();
}

class _PostAssessment1State extends State<PostAssessment1> {
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
      if (length > 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (ctx) {
            return PostAssessmentInstructionsScreen1(
              userId: widget.userId,
              grade: widget.grade,
              pre_assessment: widget.post,
              length: length + 1,
              lesson: widget.lesson,
            );
          }),
        );
      } else {
        Navigator.push(
      context,
      MaterialPageRoute(builder: (ctx) {
        return PostAssessmentInstructionsScreen1(
          userId: widget.userId,
          grade: widget.grade,
          pre_assessment: widget.post,
          length: 1,
          lesson: widget.lesson,
        );
      }),
    );
      }
    } else {
      await FirebaseFirestore.instance
        .collection('score')
        .doc(widget.userId+widget.grade)
        .update({
          widget.lesson + ' lesson': [],
          widget.lesson + 'wrong' : []
        });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (ctx) {
          return PostAssessmentInstructionsScreen1(
            userId: widget.userId,
            grade: widget.grade,
            pre_assessment: widget.post,
            length: 1,
            lesson: widget.lesson,
          );
        }),
      );
    }
  } else {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (ctx) {
        return PostAssessmentInstructionsScreen1(
          userId: widget.userId,
          grade: widget.grade,
          pre_assessment: widget.post,
          length: 1,
          lesson: widget.lesson,
        );
      }),
    );
  }

    // if (data[pre] != null) {
    //   if (data[pre].length < 9) {
    //     int length = data[pre].length;
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(builder: (ctx) {
    //         return PostAssessmentInstructionsScreen(
    //           userId: widget.userId,
    //           grade: widget.grade,
    //           pre_assessment: widget.post,
    //           length: data[pre].length,
    //           lesson: widget.lesson,
    //         );
    //       }),
    //     );
    //   } else {
    //     await FirebaseFirestore.instance
    //       .collection('score')
    //       .doc(widget.userId)
    //       .update({
    //          widget.lesson + ' lesson': [],
    //       });
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(builder: (ctx) {
    //         return PostAssessmentInstructionsScreen(
    //           userId: widget.userId,
    //           grade: widget.grade,
    //           pre_assessment: widget.post,
    //           length: 1,
    //           lesson: widget.lesson,
    //         );
    //       }),
    //     );
    //   }
    // } else {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (ctx) {
    //       return PostAssessmentInstructionsScreen(
    //         userId: widget.userId,
    //         grade: widget.grade,
    //         pre_assessment: widget.post,
    //         length: 1,
    //         lesson: widget.lesson,
    //       );
    //     }),
    //   );
    // }
  } catch (e) {
    print('Error fetching data: $e');
  }
}


  final List<String> gifPaths = [
    'assets/L1.gif',
    'assets/L2.gif',
    'assets/L3.gif',
    // 'assets/loading1.gif',
    // 'assets/loading2.gif',
    // 'assets/loading3.gif',
    // 'assets/loading4.gif',
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