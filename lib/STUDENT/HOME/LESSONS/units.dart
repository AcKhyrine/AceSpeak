import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../PRE-ASSESSMENT/start.dart';
import '../TILES/tiles_screen.dart';
import '../map_screen.dart';
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
  String method = "";
  @override
  void initState() {
    MethodofLearning();
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
        if(method == "map"){
          Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) {
              return MapScreen(userId:widget.userid, grade: grade);
            },
          ),
        );return;
        }else if(method == "tiles"){
          Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) {
              return TilesScreen(userId:widget.userid, grade: grade);
            },
          ),
        );return;
        }else{
          Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) {
              return NavigateUserChoice(userid:widget.userid, grade: grade);
            },
          ),
        );return;
        }
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

  void MethodofLearning() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userid)
          .get();

      if (!snapshot.exists) {
        print('No documents found for the user ID: ${widget.userid}');
        return;
      }
      else{
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      if (data['method'] == "map" || data['method'] == "tiles") {
        setState(() {
          method = data["method"];
        });
      }
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: Image.asset(
                'assets/images/image 2.png',
                fit: BoxFit.cover,
              ),
            ),
          Padding(
            padding: EdgeInsets.only(left: screenWidth * 0.1, right: screenWidth * 0.1, top: screenHeight * 0.13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Lessons',
                  style: TextStyle(color: Color(0xFF07883A), fontWeight: FontWeight.bold, fontSize: screenHeight * .05),
                ),
                SizedBox(height: screenHeight * .035,),
                GestureDetector(
                  onTap: (){
                    assessmentCheck('Grade 1');
                  },
                  child: Container(
                    height: screenHeight * 0.09,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/unit.png'), 
                        fit: BoxFit.fill, 
                      ),
                    ),
                    child: Center(
                      child: Text('Unit 1', style: TextStyle(color: Colors.white)),
                    ),
                 )
                ),
                SizedBox(height: screenHeight * .01,),
                GestureDetector(
                  onTap: (){
                    if(grade2 == true){
                    assessmentCheck('Grade 2');
                    }else{
                      EasyLoading.showInfo("You cannot access this at the moment. Please complete the unit above first.");
                    }
                  },
                  child: Container(
                    height: screenHeight * 0.09,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(grade2 == true ? 'assets/images/unit.png' : 'assets/images/unit_lock.png'), 
                        fit: BoxFit.fill, 
                      ),
                    ),
                    child: Center(
                      child: Text('Unit 2', style: TextStyle(color: Colors.white)),
                    ),
                 )
                ),
                SizedBox(height: screenHeight * .01,),
                GestureDetector(
                  onTap: (){
                    if(grade3 == true){
                    assessmentCheck('Grade 3');
                    }else{
                      EasyLoading.showInfo("You cannot access this at the moment. Please complete the unit above first.");
                    }
                  },
                  child: Container(
                    height: screenHeight * 0.09,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(grade3 == true ? 'assets/images/unit.png' : 'assets/images/unit_lock.png'), 
                        fit: BoxFit.fill, 
                      ),
                    ),
                    child: Center(
                      child: Text('Unit 3', style: TextStyle(color: Colors.white)),
                    ),
                 )
                ),
                SizedBox(height: screenHeight * .01,),
                GestureDetector(
                  onTap: (){
                    if(grade4 == true){
                    assessmentCheck('Grade 4');
                    }else{
                      EasyLoading.showInfo("You cannot access this at the moment. Please complete the unit above first.");
                    }
                  },
                  child: Container(
                    height:screenHeight * 0.09,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(grade4 == true ? 'assets/images/unit.png' : 'assets/images/unit_lock.png'), 
                        fit: BoxFit.fill, 
                      ),
                    ),
                    child: Center(
                      child: Text('Unit 4', style: TextStyle(color: Colors.white)),
                    ),
                 )
                ),
                SizedBox(height: screenHeight * .01,),
                GestureDetector(
                  onTap: (){
                    if(grade5 == true){
                    assessmentCheck('Grade 5');
                    }else{
                      EasyLoading.showInfo("You cannot access this at the moment. Please complete the unit above first.");
                    }
                  },
                  child: Container(
                    height:screenHeight * 0.09,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(grade5 == true ? 'assets/images/unit.png' : 'assets/images/unit_lock.png'), 
                        fit: BoxFit.fill, 
                      ),
                    ),
                    child: Center(
                      child: Text('Unit 5', style: TextStyle(color: Colors.white)),
                    ),
                 )
                ),
                SizedBox(height: screenHeight * .01,),
                GestureDetector(
                  onTap: (){
                     if(grade6 == true){
                    assessmentCheck('Grade 6');
                    }else{
                      EasyLoading.showInfo("You cannot access this at the moment. Please complete the unit above first.");
                    }
                  },
                  child: Container(
                    height:screenHeight * 0.09,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(grade6 == true ? 'assets/images/unit.png' : 'assets/images/unit_lock.png'), 
                        fit: BoxFit.fill, 
                      ),
                    ),
                    child: Center(
                      child: Text('Unit 6', style: TextStyle(color: Colors.white)),
                    ),
                 )
                ),
              ],
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: ((context) {
                return ClassRoomScreen(userId: widget.userid);
              })));
              }, child: Row(
                children: [
                  Icon(Icons.arrow_back, color: Colors.black,),
                  Text('Back', style: TextStyle(color: Colors.black),)
                ],
              ),)
          ),
        ],
      ),
    );
  }
}