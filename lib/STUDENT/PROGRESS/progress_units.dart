import 'package:acespeak/STUDENT/PROGRESS/progress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../HOME/student_classroom.dart';

class ProgressUnitScreen extends StatefulWidget {
  final userid;
  const ProgressUnitScreen({super.key, required this.userid});

  @override
  State<ProgressUnitScreen> createState() => _ProgressUnitScreenState();
}

class _ProgressUnitScreenState extends State<ProgressUnitScreen> {


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
            Text('Progress'),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (ctx){
                return ProgressHistory(userId: widget.userid, grade: 'Grade 1',);
              }));
            }, child: Text('Unit 1')),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (ctx){
                return ProgressHistory(userId: widget.userid, grade: 'Grade 2',);
              }));
            }, child: Text('Unit 2')),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (ctx){
                return ProgressHistory(userId: widget.userid, grade: 'Grade 3',);
              }));
            }, child: Text('Unit 3')),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (ctx){
                return ProgressHistory(userId: widget.userid, grade: 'Grade 4',);
              }));
            }, child: Text('Unit 4')),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (ctx){
                return ProgressHistory(userId: widget.userid, grade: 'Grade 5',);
              }));
            }, child: Text('Unit 5')),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (ctx){
                return ProgressHistory(userId: widget.userid, grade: 'Grade 6',);
              }));
            }, child: Text('Unit 6'))
          ],
        ),
      ),
    );
  }
}