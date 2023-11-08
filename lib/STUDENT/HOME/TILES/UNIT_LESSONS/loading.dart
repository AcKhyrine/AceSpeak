import 'package:acespeak/STUDENT/HOME/TILES/UNIT_LESSONS/introduction.dart';
import 'package:acespeak/STUDENT/HOME/TILES/UNIT_LESSONS/lessons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class NextScreen1 extends StatefulWidget {
  final String userId;
  final String grade;
  final int number;
  final String lesson;
  final String item;
  const NextScreen1({super.key, required this.userId, required this.item, required this.grade, required this.number, required this.lesson});

  @override
  State<NextScreen1> createState() => _NextScreen1State();
}

class _NextScreen1State extends State<NextScreen1> {
  int num = 0;
  @override
  void initState() {
    super.initState();
    assessment();
  }

  void assessment() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('score')
          .doc(widget.userId+ widget.grade)
          .get();

      if (!snapshot.exists) {
        print('No documents found for the user ID: ${widget.userId}');
        return;
      }

      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        int index = 0;
        if(data[widget.item] != null && data[widget.item] >= 1 && data[widget.item] <= 10){
          index = data[widget.item];
          print('index: ');
          print(index);
          Navigator.push(context, MaterialPageRoute(builder: (ctx){
              return Lesson_Screen1(userId: widget.userId, grade: widget.grade, lesson: widget.lesson, index : index, number:widget.number, item:widget.item);
            }));

        }else{
          index = 0;
          Navigator.push(context, MaterialPageRoute(builder: (ctx){
              return LessonIntro1(userId: widget.userId,  grade: widget.grade, lesson: widget.lesson, index: index, number:widget.number, item:widget.item);
            }));
        }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Center(child: Image.asset('assets/L1.gif')),
      ),
    );
  }
}