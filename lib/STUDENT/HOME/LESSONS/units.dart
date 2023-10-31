import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../PRE-ASSESSMENT/start.dart';
import '../student_classroom.dart';
import 'mapORlist.dart';

class UnitScreen extends StatefulWidget {
  final userid;
  const UnitScreen({super.key, required this.userid});

  @override
  State<UnitScreen> createState() => _UnitScreenState();
}

class _UnitScreenState extends State<UnitScreen> {

  void assessmentCheck(grade) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('score')
          .doc(widget.userid + grade)
          .get();

      if (!snapshot.exists) {
        print('No documents found for the user ID: ${widget.userid}');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) {
              return AssessmentStart(userId: widget.userid, grade: grade);
            },
          ),
        );
        return;
      }
      else{
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      if (data['assessment']!= null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) {
              return NavigateUserChoice(userid:widget.userid, grade: grade);
            },
          ),
        );return;
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) {
              return AssessmentStart(userId: widget.userid, grade: grade);
            },
          ),
        );return;
      }
      }

      
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: ((context) {
            return ClassRoomScreen(userId: widget.userid);
          })));
        }, icon: Icon(Icons.arrow_back)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Lesson'),
            ElevatedButton(onPressed: (){

            }, child: Text('Unit 1')),
            ElevatedButton(onPressed: (){

            }, child: Text('Unit 2')),
            ElevatedButton(onPressed: (){

            }, child: Text('Unit 3')),
            ElevatedButton(onPressed: (){
              assessmentCheck('Grade 4');
            }, child: Text('Unit 4')),
            ElevatedButton(onPressed: (){
              // assessmentCheck('Grade 5');
            }, child: Text('Unit 5')),
            ElevatedButton(onPressed: (){
              assessmentCheck('Grade 6');
            }, child: Text('Unit 6'))
          ],
        ),
      ),
    );
  }
}