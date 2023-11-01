import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

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
  bool grade2 = false, grade3 = false, grade4 = false, grade5 = false, grade6 = false;
  
  @override
  void initState() {
    Access();
    super.initState();
  }

void Access() async {
  for (int i = 1; i <= 6; i++) {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
      .collection('score')
      .doc(widget.userid + "Grade $i")
      .get();

    if (!snapshot.exists) {
      print('No documents found for the: ${widget.userid}grade $i');
    } else {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      bool containsValue = false;
      if (data['finished'] != null) {
        List<dynamic> finishedList = data['finished'];
        print(finishedList);

        for (String item in finishedList) {
          if (item.contains("4-5")) {
            containsValue = true;
            print(containsValue);
            break;
          }
        }
      }

      if (containsValue) {
        if(i == 1){
          setState(() {
            grade2 = true;
          });
        }
        if(i == 2){
          setState(() {
            grade3 = true;
          });
        }
        if(i == 3){
          setState(() {
            grade4 = true;
          });
        }
        if(i == 4){
          setState(() {
            grade5 = true;
          });
        }
        if(i == 5){
          setState(() {
            grade6 = true;
          });
        }
      } else {
        print("'4-5' was not found in the list for Grade $i.");
      }
    }
  }
}

  

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
      if (data['number']!= null) {
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
              assessmentCheck('Grade 1');
            }, child: Text('Unit 1')),
            ElevatedButton(onPressed: (){
              if(grade2 == true){
                assessmentCheck('Grade 2');
              }else{
                EasyLoading.showInfo("You cannot access this at the moment. Please complete the unit above first.");
              }
            }, child: Text('Unit 2')),
            ElevatedButton(onPressed: (){
              if(grade3 == true){
                assessmentCheck('Grade 3');
              }else{
                EasyLoading.showInfo("You cannot access this at the moment. Please complete the unit above first.");
              }
            }, child: Text('Unit 3')),
            ElevatedButton(onPressed: (){
              if(grade4 == true){
                assessmentCheck('Grade 4');
              }else{
                EasyLoading.showInfo("You cannot access this at the moment. Please complete the unit above first.");
              }
            }, child: Text('Unit 4')),
            ElevatedButton(onPressed: (){
              if(grade5 == true){
                assessmentCheck('Grade 5');
              }else{
                EasyLoading.showInfo("You cannot access this at the moment. Please complete the unit above first.");
              }
            }, child: Text('Unit 5')),
            ElevatedButton(onPressed: (){
              if(grade6 == true){
                assessmentCheck('Grade 6');
              }else{
                EasyLoading.showInfo("You cannot access this at the moment. Please complete the unit above first.");
              }
            }, child: Text('Unit 6'))
          ],
        ),
      ),
    );
  }
}