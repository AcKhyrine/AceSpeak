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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: Image.asset(
                'assets/images/bg1.png',
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
                  style: TextStyle(color: Color(0xFF07883A), fontWeight: FontWeight.bold, fontSize: 27),
                ),
                Text(
                  'Progress History',
                  style: TextStyle(color: Color(0xFF07883A), fontSize: 15),
                ),
                SizedBox(height: screenHeight * .035,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (ctx){
                      return ProgressHistory(userId: widget.userid, grade: 'Grade 1',);
                    }));
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
                    Navigator.push(context, MaterialPageRoute(builder: (ctx){
                      return ProgressHistory(userId: widget.userid, grade: 'Grade 2',);
                    }));
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
                      child: Text('Unit 2', style: TextStyle(color: Colors.white)),
                    ),
                 )
                ),
                 SizedBox(height: screenHeight * .01,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (ctx){
                      return ProgressHistory(userId: widget.userid, grade: 'Grade 3',);
                    }));
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
                      child: Text('Unit 3', style: TextStyle(color: Colors.white)),
                    ),
                 )
                ),
                 SizedBox(height: screenHeight * .01,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (ctx){
                      return ProgressHistory(userId: widget.userid, grade: 'Grade 4',);
                    }));
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
                      child: Text('Unit 4', style: TextStyle(color: Colors.white)),
                    ),
                 )
                ),
                 SizedBox(height: screenHeight * .01,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (ctx){
                      return ProgressHistory(userId: widget.userid, grade: 'Grade 5',);
                    }));
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
                      child: Text('Unit 5', style: TextStyle(color: Colors.white)),
                    ),
                 )
                ),
                 SizedBox(height: screenHeight * .01,),
                GestureDetector(
                  onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (ctx){
                      return ProgressHistory(userId: widget.userid, grade: 'Grade 6',);
                    }));
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