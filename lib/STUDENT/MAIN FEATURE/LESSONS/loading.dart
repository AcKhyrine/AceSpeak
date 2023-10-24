import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'introduction.dart';
import 'lessons.dart';

class NextScreen extends StatefulWidget {
  final String userId;
  final String grade;
  final int number;
  final String lesson;
  final String item;
  final String classroomID;
  const NextScreen({super.key, required this.userId, required this.classroomID, required this.item, required this.grade, required this.number, required this.lesson});

  @override
  State<NextScreen> createState() => _NextScreenState();
}

class _NextScreenState extends State<NextScreen> {
  int num = 0;
  String _classCode = '';
  @override
  void initState() {
    super.initState();
    classCode();
  }

  void classCode()async{
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('classroom')
          .doc(widget.classroomID)
          .get();

      if (!snapshot.exists) {
        print('No documents found for the user ID: ${widget.userId}');
        return;
      }

      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        setState(() {
          _classCode = data['Class Code'];
          assessment();
        });
        print(_classCode);
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void assessment() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('score')
          .doc(widget.userId+_classCode)
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
              return Lesson_Screen(userId: widget.userId, grade: widget.grade, lesson: widget.lesson, index : index, number:widget.number, item:widget.item, classroomID : widget.classroomID);
            }));

        }else{
          index = 0;
          Navigator.push(context, MaterialPageRoute(builder: (ctx){
              return LessonIntro(userId: widget.userId,  grade: widget.grade, lesson: widget.lesson, index: index, number:widget.number, item:widget.item, classroomID : widget.classroomID);
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
        child: CircularProgressIndicator(),
      ),
    );
  }
}