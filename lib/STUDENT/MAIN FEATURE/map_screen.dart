import 'package:acespeak/STUDENT/MAIN%20FEATURE/LESSONS/lessons.dart';
import 'package:acespeak/STUDENT/MAIN%20FEATURE/post-assessment/audio%20choices/post-assessment.dart';
import 'package:acespeak/STUDENT/MAIN%20FEATURE/post-assessment/speech%20reco/speech_loading.dart';
import 'package:acespeak/STUDENT/MAIN%20FEATURE/student_classroom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'LESSONS/loading.dart';

class MapScreen extends StatefulWidget {
  final String userId;
  final String grade;
  final String classroomID;
  const MapScreen({super.key, required this.userId, required this.grade, required this.classroomID});
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  int level = 0;
  int number = 0;
  List<dynamic> finished = [];
  int score1=0, score2=0, score3=0, score4=0, score5=0, score6=0, score7=0, score8=0, score9=0, score10=0, score11=0, score12=0, score13=0, score14=0, score15=0, score16=0, score17=0, score18=0, score19=0, score20=0;
  @override
  void initState() {
    super.initState();
    assessment();
    postAssessmentScore();
   
  }

  void assessment() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('score')
          .doc(widget.userId)
          .get();

      if (!snapshot.exists) {
        print('No documents found for the user ID: ${widget.userId}');
        return;
      }

      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      setState(() {
        level = data['assessment'];
        number = data['number'];
        if(data['finished'] != null){
          finished = data['finished'];
        }
        print(number);
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
     print("Score: ");
     print(score3 );
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
        reverse: true,
        child: Container(
          height: MediaQuery.of(context).size.height * 4, 
          width: double.infinity,
          child: Stack(
            children: [
              // Background Images
              Column(
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      child: Image.asset('assets/map 1.png', fit: BoxFit.fill, alignment: Alignment.center),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      child: Image.asset('assets/map 1.png', fit: BoxFit.fill, alignment: Alignment.center),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      child: Image.asset('assets/map 2.png', fit: BoxFit.fill, alignment: Alignment.center),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      child: Image.asset('assets/map 2.png', fit: BoxFit.fill, alignment: Alignment.center),
                    ),
                  ),
                ],
              ),

              // Icons and Markers
              LayoutBuilder(
                builder: (context, constraints) {
                  double screenWidth = constraints.maxWidth;
                  double screenHeight = constraints.maxHeight;

                  return Stack(
                    children: [
///////////////////////// LEVEL 1 //////////////////////////////////////////////////////
                      // Positioned(
                      //   left: screenWidth * 0.62,
                      //   top: screenHeight * 0.982,
                      //   child: Row(
                      //     children: [
                      //       Image.asset(
                      //         'assets/unlock.png',
                      //       width: 40,),
                      //       Text('Level 1', style: TextStyle(color: Colors.white),)
                      //     ],
                      //   ),
                      // ),
                      // LESSON 1
                      Positioned(
                        left: screenWidth * 0.70,
                        top: screenHeight * 0.965,
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (ctx){
                              return NextScreen(userId: widget.userId, grade: widget.grade, number: 1, lesson: '1-1 lesson', item : '1-1', classroomID : widget.classroomID);
                            }));
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                number >= 1 ?
                                'assets/lesson.png' :
                                'assets/lessons.png',
                              width: 40,),
                              number == 1 
                              ? Image.asset('assets/flag.png',
                              width: 50)
                              : SizedBox.shrink()
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: screenWidth * 0.53,
                        top: screenHeight * 0.932,
                        child: GestureDetector(
                          onTap: (){
                            print(score1);
                            if(finished.contains('1-1') || number > 1){
                              print('you may go');
                              // add number + 1;
                            Navigator.push(context, MaterialPageRoute(builder: (ctx){
                              return PostAssessment(userId: widget.userId, grade: widget.grade, lesson : '1-1', post : '1', classroomID : widget.classroomID);
                            }));
                            }
                            else{
                              EasyLoading.showInfo("You cant open this yet");
                            }
                          },
                          child: Column(
                            children: [
                              Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Icon(
                                      finished.contains('1-1') ? Icons.circle_rounded : Icons.circle_outlined,
                                      size: screenWidth * 0.07, 
                                      color: Colors.red
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        score1 >= 40 ? Icons.star : Icons.star_border_outlined,
                                        size: screenWidth * 0.05,
                                        color: Colors.red
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 5),
                                        child: Icon(
                                          score1 <= 55 && score1 > 40
                                              ? Icons.star_half_outlined
                                              : score1 > 55
                                                  ? Icons.star
                                                  : Icons.star_border_outlined,
                                          size: screenWidth * 0.05,
                                          color: Colors.red,
                                        ),
                                      ),
                                      Icon(
                                        score1 <= 85 && score1 > 70
                                              ? Icons.star_half_outlined
                                              : score1 > 85
                                                  ? Icons.star
                                                  : Icons.star_border_outlined,
                                        size: screenWidth * 0.05,
                                        color:Colors.red,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ),
                      // LESSON 2
                      Positioned(
                        left: screenWidth * 0.16,
                        top: screenHeight * 0.913,
                        child: GestureDetector(
                          onTap: (){
                            print("lesson 1-2");
                            if(number >= 2){
                              Navigator.push(context, MaterialPageRoute(builder: (ctx){
                              return NextScreen(userId: widget.userId, grade: widget.grade, number: 2, lesson: '1-2 lesson', item : '1-2', classroomID : widget.classroomID);
                            }));
                            }
                            else{
                              EasyLoading.showError("You can't open this lesson yet.");
                            }
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                number >= 2 ?
                                'assets/lesson.png' :
                                'assets/lessons.png',
                              width: 40,),
                              number == 2 
                              ? Image.asset('assets/flag.png',
                              width: 50)
                              : SizedBox.shrink()
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: screenWidth * 0.40,
                        top: screenHeight * 0.893,
                        child: GestureDetector(
                          onTap: (){
                            print(score1);
                            if(finished.contains('1-2') || number > 2){
                              print('you may go');
                              // add number + 1;
                            Navigator.push(context, MaterialPageRoute(builder: (ctx){
                              return PostAssessment(userId: widget.userId, grade: widget.grade, lesson : '1-2', post : '2', classroomID : widget.classroomID);
                            }));
                            }
                            else{
                              EasyLoading.showInfo("You cant open this yet");
                            }
                          },
                          child: Column(
                              children: [
                                Stack(
                                  alignment: Alignment.topCenter,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Icon(
                                        finished.contains('1-2') ? Icons.circle_rounded : Icons.circle_outlined,
                                        size: screenWidth * 0.07, 
                                        color: Colors.red
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(
                                          score2 >= 40 ? Icons.star : Icons.star_border_outlined,
                                          size: screenWidth * 0.05,
                                          color: Colors.red
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 5),
                                          child: Icon(
                                            score2 <= 55 && score2 > 40
                                                ? Icons.star_half_outlined
                                                : score2 > 55
                                                    ? Icons.star
                                                    : Icons.star_border_outlined,
                                            size: screenWidth * 0.05,
                                            color: Colors.red,
                                          ),
                                        ),
                                        Icon(
                                          score2 <= 85 && score2 > 70
                                                ? Icons.star_half_outlined
                                                : score2 > 85
                                                    ? Icons.star
                                                    : Icons.star_border_outlined,
                                          size: screenWidth * 0.05,
                                          color:Colors.red,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                        ),
                      ),
                      // LESSON 3
                      Positioned(
                        left: screenWidth * 0.68,
                        top: screenHeight * 0.890,
                        child: GestureDetector(
                          onTap: (){
                            if(number >= 3){
                              Navigator.push(context, MaterialPageRoute(builder: (ctx){
                              return NextScreen(userId: widget.userId, grade: widget.grade, number: 3, lesson: '1-3 lesson', item : '1-3', classroomID : widget.classroomID);
                            }));
                            }
                            else{
                              EasyLoading.showError("You can't open this lesson yet.");
                            }
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                number >= 3 ?
                                'assets/lesson.png' :
                                'assets/lessons.png',
                              width: 40,),
                              number == 3 
                              ? Image.asset('assets/flag.png',
                              width: 50)
                              : SizedBox.shrink()
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: screenWidth * 0.69,
                        top: screenHeight * 0.850,
                        child: GestureDetector(
                          onTap: (){
                            print(score3);
                            if(finished.contains('1-3') || number > 3){
                              print('you may go');
                              // add number + 1;
                            Navigator.push(context, MaterialPageRoute(builder: (ctx){
                              return  SpeechPostAssessment(userId: widget.userId, grade: widget.grade, lesson : '1-3', post : '3', classroomID : widget.classroomID);
                            }));
                            }
                            else{
                              EasyLoading.showInfo("You cant open this yet");
                            }
                          },
                          child: Column(
                              children: [
                                Stack(
                                  alignment: Alignment.topCenter,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Icon(
                                        finished.contains('1-3') ? Icons.circle_rounded : Icons.circle_outlined,
                                        size: screenWidth * 0.07, 
                                        color: Colors.red
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(
                                          score3 >= 40 ? Icons.star : Icons.star_border_outlined,
                                          size: screenWidth * 0.05,
                                          color: Colors.red
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 5),
                                          child: Icon(
                                            score3 <= 55 && score3 > 40
                                                ? Icons.star_half_outlined
                                                : score3 > 55
                                                    ? Icons.star
                                                    : Icons.star_border_outlined,
                                            size: screenWidth * 0.05,
                                            color: Colors.red,
                                          ),
                                        ),
                                        Icon(
                                          score3 <= 85 && score3 > 70
                                                ? Icons.star_half_outlined
                                                : score3 > 85
                                                    ? Icons.star
                                                    : Icons.star_border_outlined,
                                          size: screenWidth * 0.05,
                                          color:Colors.red,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                        )
                      ),
                      // LESSON 4
                      Positioned(
                        left: screenWidth * 0.50,
                        top: screenHeight * 0.821,
                        child: GestureDetector(
                          onTap: (){
                            if(number >= 4){
                              Navigator.push(context, MaterialPageRoute(builder: (ctx){
                              return NextScreen(userId: widget.userId, grade: widget.grade, number: 4, lesson: '1-4 lesson', item : '1-4', classroomID : widget.classroomID);
                            }));
                            }
                            else{
                              EasyLoading.showError("You can't open this lesson yet.");
                            }
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                number >= 4 ?
                                'assets/lesson.png' :
                                'assets/lessons.png',
                              width: 40,),
                              number == 4 
                              ? Image.asset('assets/flag.png',
                              width: 50)
                              : SizedBox.shrink()
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: screenWidth * 0.15,
                        top: screenHeight * 0.803,
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Icon(
                                    Icons.circle_outlined,
                                    size: screenWidth * 0.07, 
                                    color: Color.fromARGB(255, 228, 14, 14),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.star_border_outlined,
                                      size: screenWidth * 0.05,
                                      color: Color.fromARGB(255, 228, 14, 14),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Icon(
                                        Icons.star_border_outlined,
                                        size: screenWidth * 0.05,
                                        color: Color.fromARGB(255, 228, 14, 14),
                                      ),
                                    ),
                                    Icon(
                                      Icons.star_border_outlined,
                                      size: screenWidth * 0.05,
                                      color: Color.fromARGB(255, 228, 14, 14),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )
                      ),
                      // LESSON 5
                      Positioned(
                        left: screenWidth * 0.30,
                        top: screenHeight * 0.778,
                        child: GestureDetector(
                          onTap: (){
                            if(number >= 5){
                              Navigator.push(context, MaterialPageRoute(builder: (ctx){
                              return NextScreen(userId: widget.userId, grade: widget.grade, number: 5, lesson: '1-5 lesson', item : '1-5', classroomID : widget.classroomID);
                            }));
                            }
                            else{
                              EasyLoading.showError("You can't open this lesson yet.");
                            }
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                number >= 5 ?
                                'assets/lesson.png' :
                                'assets/lessons.png',
                              width: 40,),
                              number == 5 
                              ? Image.asset('assets/flag.png',
                              width: 50)
                              : SizedBox.shrink()
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: screenWidth * 0.45,
                        top: screenHeight * 0.750,
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Icon(
                                    Icons.circle_outlined,
                                    size: screenWidth * 0.07, 
                                    color: Color.fromARGB(255, 228, 14, 14),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.star_border_outlined,
                                      size: screenWidth * 0.05,
                                      color: Color.fromARGB(255, 228, 14, 14),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Icon(
                                        Icons.star_border_outlined,
                                        size: screenWidth * 0.05,
                                        color: Color.fromARGB(255, 228, 14, 14),
                                      ),
                                    ),
                                    Icon(
                                      Icons.star_border_outlined,
                                      size: screenWidth * 0.05,
                                      color: Color.fromARGB(255, 228, 14, 14),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )
                      ),

///////////////////////// LEVEL 2 //////////////////////////////////////////////////////
                      // Positioned(
                      //   left: screenWidth * 0.62,
                      //   top: screenHeight * 0.727,
                      //   child: Row(
                      //     children: [
                      //       Image.asset(
                      //         level > 4 ?
                      //         'assets/unlock.png'
                      //         : 'assets/lock.png' ,
                      //       width: 40,),
                      //       Text('Level 2')
                      //     ],
                      //   ),
                      // ),
                      // LESSON 1
                      Positioned(
                        left: screenWidth * 0.70,
                        top: screenHeight * 0.712,
                        child: GestureDetector(
                          onTap: (){
                            if(number >= 6){
                              Navigator.push(context, MaterialPageRoute(builder: (ctx){
                              return NextScreen(userId: widget.userId, grade: widget.grade, number: 6, lesson: '2-1 lesson', item : '2-1', classroomID : widget.classroomID);
                            }));
                            }
                            else{
                              EasyLoading.showError("You can't open this lesson yet.");
                            }
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                number >= 6 ?
                                'assets/lesson.png' :
                                'assets/lessons.png',
                              width: 40,),
                              number == 6 
                              ? Image.asset('assets/flag.png',
                              width: 50)
                              : SizedBox.shrink()
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: screenWidth * 0.53,
                        top: screenHeight * 0.68,
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Icon(
                                    Icons.circle_outlined,
                                    size: screenWidth * 0.07, 
                                    color: Color.fromARGB(255, 228, 14, 14),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.star_border_outlined,
                                      size: screenWidth * 0.05,
                                      color: Color.fromARGB(255, 228, 14, 14),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Icon(
                                        Icons.star_border_outlined,
                                        size: screenWidth * 0.05,
                                        color: Color.fromARGB(255, 228, 14, 14),
                                      ),
                                    ),
                                    Icon(
                                      Icons.star_border_outlined,
                                      size: screenWidth * 0.05,
                                      color: Color.fromARGB(255, 228, 14, 14),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )
                      ),
                      // LESSON 2
                      Positioned(
                        left: screenWidth * 0.16,
                        top: screenHeight * 0.67,
                        child: GestureDetector(
                          onTap: (){
                            if(number >= 7){
                              Navigator.push(context, MaterialPageRoute(builder: (ctx){
                              return NextScreen(userId: widget.userId, grade: widget.grade, number: 7, lesson: '2-2 lesson', item : '2-1',classroomID : widget.classroomID);
                            }));
                            }
                            else{
                              EasyLoading.showError("You can't open this lesson yet.");
                            }
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                number >= 7 ?
                                'assets/lesson.png' :
                                'assets/lessons.png',
                              width: 40,),
                              number == 7 
                              ? Image.asset('assets/flag.png',
                              width: 50)
                              : SizedBox.shrink()
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: screenWidth * 0.40,
                        top: screenHeight * 0.642,
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Icon(
                                    Icons.circle_outlined,
                                    size: screenWidth * 0.07, 
                                    color: Color.fromARGB(255, 228, 14, 14),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.star_border_outlined,
                                      size: screenWidth * 0.05,
                                      color: Color.fromARGB(255, 228, 14, 14),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Icon(
                                        Icons.star_border_outlined,
                                        size: screenWidth * 0.05,
                                        color: Color.fromARGB(255, 228, 14, 14),
                                      ),
                                    ),
                                    Icon(
                                      Icons.star_border_outlined,
                                      size: screenWidth * 0.05,
                                      color: Color.fromARGB(255, 228, 14, 14),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )
                      ),
                      // LESSON 3
                      Positioned(
                        left: screenWidth * 0.75,
                        top: screenHeight * 0.640,
                        child: GestureDetector(
                          onTap: (){
                            if(number >= 8){
                              Navigator.push(context, MaterialPageRoute(builder: (ctx){
                              return NextScreen(userId: widget.userId, grade: widget.grade, number: 8, lesson: '2-3 lesson', item : '2-3', classroomID : widget.classroomID);
                            }));
                            }
                            else{
                              EasyLoading.showError("You can't open this lesson yet.");
                            }
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                number >= 8 ?
                                'assets/lesson.png' :
                                'assets/lessons.png',
                              width: 40,),
                              number == 8 
                              ? Image.asset('assets/flag.png',
                              width: 50)
                              : SizedBox.shrink()
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: screenWidth * 0.69,
                        top: screenHeight * 0.600,
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Icon(
                                    Icons.circle_outlined,
                                    size: screenWidth * 0.07, 
                                    color: Color.fromARGB(255, 228, 14, 14),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.star_border_outlined,
                                      size: screenWidth * 0.05,
                                      color: Color.fromARGB(255, 228, 14, 14),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Icon(
                                        Icons.star_border_outlined,
                                        size: screenWidth * 0.05,
                                        color: Color.fromARGB(255, 228, 14, 14),
                                      ),
                                    ),
                                    Icon(
                                      Icons.star_border_outlined,
                                      size: screenWidth * 0.05,
                                      color: Color.fromARGB(255, 228, 14, 14),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )
                      ),
                      // LESSON 4
                      Positioned(
                        left: screenWidth * 0.50,
                        top: screenHeight * 0.574,
                        child: GestureDetector(
                          onTap: (){
                            if(number >= 9){
                              Navigator.push(context, MaterialPageRoute(builder: (ctx){
                              return NextScreen(userId: widget.userId, grade: widget.grade, number: 9, lesson: '2-4 lesson', item : '2-4', classroomID : widget.classroomID);
                            }));
                            }
                            else{
                              EasyLoading.showError("You can't open this lesson yet.");
                            }
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                number >= 9 ?
                                'assets/lesson.png' :
                                'assets/lessons.png',
                              width: 40,),
                              number == 9 
                              ? Image.asset('assets/flag.png',
                              width: 50)
                              : SizedBox.shrink()
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: screenWidth * 0.15,
                        top: screenHeight * 0.557,
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Icon(
                                    Icons.circle_outlined,
                                    size: screenWidth * 0.07, 
                                    color: Color.fromARGB(255, 228, 14, 14),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.star_border_outlined,
                                      size: screenWidth * 0.05,
                                      color: Color.fromARGB(255, 228, 14, 14),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Icon(
                                        Icons.star_border_outlined,
                                        size: screenWidth * 0.05,
                                        color: Color.fromARGB(255, 228, 14, 14),
                                      ),
                                    ),
                                    Icon(
                                      Icons.star_border_outlined,
                                      size: screenWidth * 0.05,
                                      color: Color.fromARGB(255, 228, 14, 14),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )
                      ),
                      // LESSON 5
                      Positioned(
                        left: screenWidth * 0.25,
                        top: screenHeight * 0.534,
                        child: GestureDetector(
                          onTap: (){
                            if(number >= 10){
                              Navigator.push(context, MaterialPageRoute(builder: (ctx){
                              return NextScreen(userId: widget.userId, grade: widget.grade, number: 10, lesson: '2-5 lesson', item : '2-5', classroomID : widget.classroomID);
                            }));
                            }
                            else{
                              EasyLoading.showError("You can't open this lesson yet.");
                            }
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                number >= 10 ?
                                'assets/lesson.png' :
                                'assets/lessons.png',
                              width: 40,),
                              number == 10 
                              ? Image.asset('assets/flag.png',
                              width: 50)
                              : SizedBox.shrink()
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: screenWidth * 0.42,
                        top: screenHeight * 0.505,
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Icon(
                                    Icons.circle_outlined,
                                    size: screenWidth * 0.07, 
                                    color: Color.fromARGB(255, 228, 14, 14),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.star_border_outlined,
                                      size: screenWidth * 0.05,
                                      color: Color.fromARGB(255, 228, 14, 14),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Icon(
                                        Icons.star_border_outlined,
                                        size: screenWidth * 0.05,
                                        color: Color.fromARGB(255, 228, 14, 14),
                                      ),
                                    ),
                                    Icon(
                                      Icons.star_border_outlined,
                                      size: screenWidth * 0.05,
                                      color: Color.fromARGB(255, 228, 14, 14),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )
                      ),

///////////////////////// LEVEL 3 //////////////////////////////////////////////////////
                      // Positioned(
                      //   left: screenWidth * 0.62,
                      //   top: screenHeight * 0.477,
                      //   child: Row(
                      //     children: [
                      //       Image.asset(
                      //         level > 8 ?
                      //         'assets/unlock.png'
                      //         : 'assets/lock.png' ,
                      //       width: 40,),
                      //       Text('Level 3')
                      //     ],
                      //   ),
                      // ),
                      // LESSON 1
                      Positioned(
                        left: screenWidth * 0.70,
                        top: screenHeight * 0.463,
                        child: GestureDetector(
                          onTap: (){
                            if(number >= 11){
                              Navigator.push(context, MaterialPageRoute(builder: (ctx){
                              return NextScreen(userId: widget.userId, grade: widget.grade, number: 11, lesson: '3-1 lesson', item : '3-1', classroomID : widget.classroomID);
                            }));
                            }
                            else{
                              EasyLoading.showError("You can't open this lesson yet.");
                            }
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                number >= 11 ?
                                'assets/lesson.png' :
                                'assets/lessons.png',
                              width: 40,),
                              number == 11 
                              ? Image.asset('assets/flag.png',
                              width: 50)
                              : SizedBox.shrink()
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: screenWidth * 0.53,
                        top: screenHeight * 0.43,
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Icon(
                                    Icons.circle_outlined,
                                    size: screenWidth * 0.07, 
                                    color: Color.fromARGB(255, 228, 14, 14),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.star_border_outlined,
                                      size: screenWidth * 0.05,
                                      color: Color.fromARGB(255, 228, 14, 14),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Icon(
                                        Icons.star_border_outlined,
                                        size: screenWidth * 0.05,
                                        color: Color.fromARGB(255, 228, 14, 14),
                                      ),
                                    ),
                                    Icon(
                                      Icons.star_border_outlined,
                                      size: screenWidth * 0.05,
                                      color: Color.fromARGB(255, 228, 14, 14),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )
                      ),
                      // LESSON 2
                      Positioned(
                        left: screenWidth * 0.16,
                        top: screenHeight * 0.423,
                        child: GestureDetector(
                          onTap: (){
                            if(number >= 12){
                              Navigator.push(context, MaterialPageRoute(builder: (ctx){
                              return NextScreen(userId: widget.userId, grade: widget.grade, number: 12, lesson: '3-2 lesson', item : '3-2', classroomID : widget.classroomID);
                            }));
                            }
                            else{
                              EasyLoading.showError("You can't open this lesson yet.");
                            }
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                number >= 12 ?
                                'assets/lesson.png' :
                                'assets/lessons.png',
                              width: 40,),
                              number == 12 
                              ? Image.asset('assets/flag.png',
                              width: 50)
                              : SizedBox.shrink()
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: screenWidth * 0.40,
                        top: screenHeight * 0.394,
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Icon(
                                    Icons.circle_outlined,
                                    size: screenWidth * 0.07, 
                                    color: Color.fromARGB(255, 228, 14, 14),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.star_border_outlined,
                                      size: screenWidth * 0.05,
                                      color: Color.fromARGB(255, 228, 14, 14),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Icon(
                                        Icons.star_border_outlined,
                                        size: screenWidth * 0.05,
                                        color: Color.fromARGB(255, 228, 14, 14),
                                      ),
                                    ),
                                    Icon(
                                      Icons.star_border_outlined,
                                      size: screenWidth * 0.05,
                                      color: Color.fromARGB(255, 228, 14, 14),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )
                      ),
                      // LESSON 3
                      Positioned(
                        left: screenWidth * 0.75,
                        top: screenHeight * 0.391,
                        child: GestureDetector(
                          onTap: (){
                            if(number >= 13){
                              Navigator.push(context, MaterialPageRoute(builder: (ctx){
                              return NextScreen(userId: widget.userId, grade: widget.grade, number: 13, lesson: '3-3 lesson', item : '3-3', classroomID : widget.classroomID);
                            }));
                            }
                            else{
                              EasyLoading.showError("You can't open this lesson yet.");
                            }
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                number >= 13 ?
                                'assets/lesson.png' :
                                'assets/lessons.png',
                              width: 40,),
                              number == 13 
                              ? Image.asset('assets/flag.png',
                              width: 50)
                              : SizedBox.shrink()
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: screenWidth * 0.70,
                        top: screenHeight * 0.352,
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Icon(
                                    Icons.circle_outlined,
                                    size: screenWidth * 0.07, 
                                    color: Color.fromARGB(255, 228, 14, 14),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.star_border_outlined,
                                      size: screenWidth * 0.05,
                                      color: Color.fromARGB(255, 228, 14, 14),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Icon(
                                        Icons.star_border_outlined,
                                        size: screenWidth * 0.05,
                                        color: Color.fromARGB(255, 228, 14, 14),
                                      ),
                                    ),
                                    Icon(
                                      Icons.star_border_outlined,
                                      size: screenWidth * 0.05,
                                      color: Color.fromARGB(255, 228, 14, 14),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )
                      ),
                      // LESSON 4
                      Positioned(
                        left: screenWidth * 0.55,
                        top: screenHeight * 0.325,
                        child: GestureDetector(
                          onTap: (){
                            if(number >= 14){
                              Navigator.push(context, MaterialPageRoute(builder: (ctx){
                              return NextScreen(userId: widget.userId, grade: widget.grade, number: 14, lesson: '3-4 lesson', item : '3-4', classroomID : widget.classroomID);
                            }));
                            }
                            else{
                              EasyLoading.showError("You can't open this lesson yet.");
                            }
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                number >= 14 ?
                                'assets/lesson.png' :
                                'assets/lessons.png',
                              width: 40,),
                              number == 14 
                              ? Image.asset('assets/flag.png',
                              width: 50)
                              : SizedBox.shrink()
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: screenWidth * 0.15,
                        top: screenHeight * 0.308,
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Icon(
                                    Icons.circle_outlined,
                                    size: screenWidth * 0.07, 
                                    color: Color.fromARGB(255, 228, 14, 14),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.star_border_outlined,
                                      size: screenWidth * 0.05,
                                      color: Color.fromARGB(255, 228, 14, 14),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Icon(
                                        Icons.star_border_outlined,
                                        size: screenWidth * 0.05,
                                        color: Color.fromARGB(255, 228, 14, 14),
                                      ),
                                    ),
                                    Icon(
                                      Icons.star_border_outlined,
                                      size: screenWidth * 0.05,
                                      color: Color.fromARGB(255, 228, 14, 14),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )
                      ),
                      // LESSON 5
                      Positioned(
                        left: screenWidth * 0.30,
                        top: screenHeight * 0.280,
                        child: GestureDetector(
                          onTap: (){
                            if(number >= 15){
                              Navigator.push(context, MaterialPageRoute(builder: (ctx){
                              return NextScreen(userId: widget.userId, grade: widget.grade, number: 15, lesson: '3-5 lesson', item : '3-5', classroomID : widget.classroomID);
                            }));
                            }
                            else{
                              EasyLoading.showError("You can't open this lesson yet.");
                            }
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                number >= 15 ?
                                'assets/lesson.png' :
                                'assets/lessons.png',
                              width: 40,),
                              number == 15 
                              ? Image.asset('assets/flag.png',
                              width: 50)
                              : SizedBox.shrink()
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: screenWidth * 0.42,
                        top: screenHeight * 0.256,
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Icon(
                                    Icons.circle_outlined,
                                    size: screenWidth * 0.07, 
                                    color: Color.fromARGB(255, 228, 14, 14),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.star_border_outlined,
                                      size: screenWidth * 0.05,
                                      color: Color.fromARGB(255, 228, 14, 14),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Icon(
                                        Icons.star_border_outlined,
                                        size: screenWidth * 0.05,
                                        color: Color.fromARGB(255, 228, 14, 14),
                                      ),
                                    ),
                                    Icon(
                                      Icons.star_border_outlined,
                                      size: screenWidth * 0.05,
                                      color: Color.fromARGB(255, 228, 14, 14),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )
                      ),

///////////////////////// LEVEL 4 //////////////////////////////////////////////////////
                      // Positioned(
                      //   left: screenWidth * 0.62,
                      //   top: screenHeight * 0.225,
                      //   child: Row(
                      //     children: [
                      //       Image.asset(
                      //         level > 13 ?
                      //         'assets/unlock.png'
                      //         : 'assets/lock.png' ,
                      //       width: 40,),
                      //       Text('Level 4')
                      //     ],
                      //   ),
                      // ),
                      // LESSON 1
                      Positioned(
                        left: screenWidth * 0.70,
                        top: screenHeight * 0.20,
                        child: GestureDetector(
                          onTap: (){
                            if(number >= 16){
                              Navigator.push(context, MaterialPageRoute(builder: (ctx){
                              return NextScreen(userId: widget.userId, grade: widget.grade, number: 16, lesson: '4-1 lesson', item : '4-1', classroomID : widget.classroomID);
                            }));
                            }
                            else{
                              EasyLoading.showError("You can't open this lesson yet.");
                            }
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                number >= 16 ?
                                'assets/lesson.png' :
                                'assets/lessons.png',
                              width: 40,),
                              number == 16 
                              ? Image.asset('assets/flag.png',
                              width: 50)
                              : SizedBox.shrink()
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: screenWidth * 0.53,
                        top: screenHeight * 0.180,
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Icon(
                                    Icons.circle_outlined,
                                    size: screenWidth * 0.07, 
                                    color: Color.fromARGB(255, 228, 14, 14),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.star_border_outlined,
                                      size: screenWidth * 0.05,
                                      color: Color.fromARGB(255, 228, 14, 14),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Icon(
                                        Icons.star_border_outlined,
                                        size: screenWidth * 0.05,
                                        color: Color.fromARGB(255, 228, 14, 14),
                                      ),
                                    ),
                                    Icon(
                                      Icons.star_border_outlined,
                                      size: screenWidth * 0.05,
                                      color: Color.fromARGB(255, 228, 14, 14),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )
                      ),
                      // LESSON 2
                      Positioned(
                        left: screenWidth * 0.16,
                        top: screenHeight * 0.17,
                        child: GestureDetector(
                          onTap: (){
                            if(number >= 17){
                              Navigator.push(context, MaterialPageRoute(builder: (ctx){
                              return NextScreen(userId: widget.userId, grade: widget.grade, number: 17, lesson: '4-2 lesson', item : '4-2', classroomID : widget.classroomID);
                            }));
                            }
                            else{
                              EasyLoading.showError("You can't open this lesson yet.");
                            }
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                number >= 17 ?
                                'assets/lesson.png' :
                                'assets/lessons.png',
                              width: 40,),
                              number == 17 
                              ? Image.asset('assets/flag.png',
                              width: 50)
                              : SizedBox.shrink()
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: screenWidth * 0.40,
                        top: screenHeight * 0.145,
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Icon(
                                    Icons.circle_outlined,
                                    size: screenWidth * 0.07, 
                                    color: Color.fromARGB(255, 228, 14, 14),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.star_border_outlined,
                                      size: screenWidth * 0.05,
                                      color: Color.fromARGB(255, 228, 14, 14),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Icon(
                                        Icons.star_border_outlined,
                                        size: screenWidth * 0.05,
                                        color: Color.fromARGB(255, 228, 14, 14),
                                      ),
                                    ),
                                    Icon(
                                      Icons.star_border_outlined,
                                      size: screenWidth * 0.05,
                                      color: Color.fromARGB(255, 228, 14, 14),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )
                      ),
                      // LESSON 3
                      Positioned(
                        left: screenWidth * 0.75,
                        top: screenHeight * 0.14,
                        child: GestureDetector(
                          onTap: (){
                            if(number >= 18){
                              Navigator.push(context, MaterialPageRoute(builder: (ctx){
                              return NextScreen(userId: widget.userId, grade: widget.grade, number: 18, lesson: '4-3 lesson', item : '4-3', classroomID : widget.classroomID);
                            }));
                            }
                            else{
                              EasyLoading.showError("You can't open this lesson yet.");
                            }
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                number >= 18 ?
                                'assets/lesson.png' :
                                'assets/lessons.png',
                              width: 40,),
                              number == 18 
                              ? Image.asset('assets/flag.png',
                              width: 50)
                              : SizedBox.shrink()
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: screenWidth * 0.68,
                        top: screenHeight * 0.10,
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Icon(
                                    Icons.circle_outlined,
                                    size: screenWidth * 0.07, 
                                    color: Color.fromARGB(255, 228, 14, 14),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.star_border_outlined,
                                      size: screenWidth * 0.05,
                                      color: Color.fromARGB(255, 228, 14, 14),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Icon(
                                        Icons.star_border_outlined,
                                        size: screenWidth * 0.05,
                                        color: Color.fromARGB(255, 228, 14, 14),
                                      ),
                                    ),
                                    Icon(
                                      Icons.star_border_outlined,
                                      size: screenWidth * 0.05,
                                      color: Color.fromARGB(255, 228, 14, 14),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )
                      ),
                      // LESSON 4
                      Positioned(
                        left: screenWidth * 0.50,
                        top: screenHeight * 0.07,
                        child: GestureDetector(
                          onTap: (){
                            if(number >= 19){
                              Navigator.push(context, MaterialPageRoute(builder: (ctx){
                              return NextScreen(userId: widget.userId, grade: widget.grade, number: 19, lesson: '4-4 lesson', item : '4-4', classroomID : widget.classroomID);
                            }));
                            }
                            else{
                              EasyLoading.showError("You can't open this lesson yet.");
                            }
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                number >= 19 ?
                                'assets/lesson.png' :
                                'assets/lessons.png',
                              width: 40,),
                              number == 19 
                              ? Image.asset('assets/flag.png',
                              width: 50)
                              : SizedBox.shrink()
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: screenWidth * 0.15,
                        top: screenHeight * 0.06,
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Icon(
                                    Icons.circle_outlined,
                                    size: screenWidth * 0.07, 
                                    color: Color.fromARGB(255, 228, 14, 14),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.star_border_outlined,
                                      size: screenWidth * 0.05,
                                      color: Color.fromARGB(255, 228, 14, 14),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Icon(
                                        Icons.star_border_outlined,
                                        size: screenWidth * 0.05,
                                        color: Color.fromARGB(255, 228, 14, 14),
                                      ),
                                    ),
                                    Icon(
                                      Icons.star_border_outlined,
                                      size: screenWidth * 0.05,
                                      color: Color.fromARGB(255, 228, 14, 14),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )
                      ),
                      // LESSON 5
                      Positioned(
                        left: screenWidth * 0.25,
                        top: screenHeight * 0.04,
                        child: GestureDetector(
                          onTap: (){
                            if(number >= 20){
                              Navigator.push(context, MaterialPageRoute(builder: (ctx){
                              return NextScreen(userId: widget.userId, grade: widget.grade, number: 20, lesson: '4-5 lesson', item : '4-5', classroomID : widget.classroomID);
                            }));
                            }
                            else{
                              EasyLoading.showError("You can't open this lesson yet.");
                            }
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                number >= 20 ?
                                'assets/lesson.png' :
                                'assets/lessons.png',
                              width: 40,),
                              number == 20 
                              ? Image.asset('assets/flag.png',
                              width: 50)
                              : SizedBox.shrink()
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: screenWidth * 0.38,
                        top: screenHeight * 0.01,
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Icon(
                                    Icons.circle_outlined,
                                    size: screenWidth * 0.07, 
                                    color: Color.fromARGB(255, 228, 14, 14),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.star_border_outlined,
                                      size: screenWidth * 0.05,
                                      color: Color.fromARGB(255, 228, 14, 14),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Icon(
                                        Icons.star_border_outlined,
                                        size: screenWidth * 0.05,
                                        color: Color.fromARGB(255, 228, 14, 14),
                                      ),
                                    ),
                                    Icon(
                                      Icons.star_border_outlined,
                                      size: screenWidth * 0.05,
                                      color: Color.fromARGB(255, 228, 14, 14),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
          Positioned(
            top: 20,
            right: 20,
            child: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                  return ClassRoomScreen(userId: widget.userId, grade: widget.grade, classroomID: widget.classroomID);
                  }));
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> postAssessmentScore() async {
    try {
      String documentId = widget.userId;
      CollectionReference scoreCollection =
          FirebaseFirestore.instance.collection('score');

      DocumentSnapshot docSnapshot =
          await scoreCollection.doc(documentId).get();

      if (docSnapshot.exists) {
        Map<String, dynamic>? data =
            docSnapshot.data() as Map<String, dynamic>?;

        if (data != null) {
    // lesson 1 scores
          if(data['1-1 lesson'] != null && data['1-1 lesson'].length == 10){
            List<dynamic>? scores = data['1-1 lesson'] as List<dynamic>?;
            int totalScore = 0;
            int numberOfScores = 0;

            for (dynamic score in scores!) {
              if (score is String) {
                int? parsedScore = int.tryParse(score);
                if (parsedScore != null) {
                  totalScore += parsedScore;
                  numberOfScores++;
                } else {
                  print('Warning: Failed to parse score $score as an integer.');
                }
              }
            }
            if (numberOfScores > 0) {
              score1 = totalScore ~/ numberOfScores;
            } else {
              score1 = 0;
            }
            print(score1);
          }    
          // lesson 2 scores
          if(data['1-2 lesson'] != null && data['1-2 lesson'].length == 10){
            List<dynamic>? scores = data['1-2 lesson'] as List<dynamic>?;
            int totalScore = 0;
            int numberOfScores = 0;

            for (dynamic score in scores!) {
              if (score is String) {
                int? parsedScore = int.tryParse(score);
                if (parsedScore != null) {
                  totalScore += parsedScore;
                  numberOfScores++;
                } else {
                  print('Warning: Failed to parse score $score as an integer.');
                }
              }
            }
            if (numberOfScores > 0) {
              score2 = totalScore ~/ numberOfScores;
            } else {
              score2 = 0;
            }
          }  
          // lesson 3 scores
          if(data['1-3 lesson'] != null && data['1-3 lesson'].length == 10){
            List<dynamic>? scores = data['1-3 lesson'] as List<dynamic>?;
            int totalScore = 0;
            int numberOfScores = 0;

            for (dynamic score in scores!) {
              if (score is String) {
                int? parsedScore = int.tryParse(score);
                if (parsedScore != null) {
                  totalScore += parsedScore;
                  numberOfScores++;
                } else {
                  print('Warning: Failed to parse score $score as an integer.');
                }
              }
            }
            if (numberOfScores > 0) {
              setState(() {
                score3 = totalScore ~/ numberOfScores;
              });
            } else {
              score3 = 0;
            }
          }  
          // lesson 4 scores
          if(data['1-4 lesson'] != null && data['1-4 lesson'].length == 10){
            List<dynamic>? scores = data['1-4 lesson'] as List<dynamic>?;
            int totalScore = 0;
            int numberOfScores = 0;

            for (dynamic score in scores!) {
              if (score is String) {
                int? parsedScore = int.tryParse(score);
                if (parsedScore != null) {
                  totalScore += parsedScore;
                  numberOfScores++;
                } else {
                  print('Warning: Failed to parse score $score as an integer.');
                }
              }
            }
            if (numberOfScores > 0) {
              score4= totalScore ~/ numberOfScores;
            } else {
              score4 = 0;
            }
          }  
          // lesson 5 scores
          if(data['1-5 lesson'] != null && data['1-5 lesson'].length == 10){
            List<dynamic>? scores = data['1-5 lesson'] as List<dynamic>?;
            int totalScore = 0;
            int numberOfScores = 0;

            for (dynamic score in scores!) {
              if (score is String) {
                int? parsedScore = int.tryParse(score);
                if (parsedScore != null) {
                  totalScore += parsedScore;
                  numberOfScores++;
                } else {
                  print('Warning: Failed to parse score $score as an integer.');
                }
              }
            }
            if (numberOfScores > 0) {
              score5 = totalScore ~/ numberOfScores;
            } else {
              score5 = 0;
            }
          }  
          // lesson 6 scores
          if(data['2-1 lesson'] != null && data['2-1 lesson'].length == 10){
            List<dynamic>? scores = data['2-1 lesson'] as List<dynamic>?;
            int totalScore = 0;
            int numberOfScores = 0;

            for (dynamic score in scores!) {
              if (score is String) {
                int? parsedScore = int.tryParse(score);
                if (parsedScore != null) {
                  totalScore += parsedScore;
                  numberOfScores++;
                } else {
                  print('Warning: Failed to parse score $score as an integer.');
                }
              }
            }
            if (numberOfScores > 0) {
              score6 = totalScore ~/ numberOfScores;
            } else {
              score6 = 0;
            }
          }  
          // lesson 7 scores
          if(data['2-2 lesson'] != null && data['2-2 lesson'].length == 10){
            List<dynamic>? scores = data['2-2 lesson'] as List<dynamic>?;
            int totalScore = 0;
            int numberOfScores = 0;

            for (dynamic score in scores!) {
              if (score is String) {
                int? parsedScore = int.tryParse(score);
                if (parsedScore != null) {
                  totalScore += parsedScore;
                  numberOfScores++;
                } else {
                  print('Warning: Failed to parse score $score as an integer.');
                }
              }
            }
            if (numberOfScores > 0) {
              score7 = totalScore ~/ numberOfScores;
            } else {
              score7 = 0;
            }
          }
          // lesson 8 scores
          if(data['2-3 lesson'] != null && data['2-3 lesson'].length == 10){
            List<dynamic>? scores = data['2-3 lesson'] as List<dynamic>?;
            int totalScore = 0;
            int numberOfScores = 0;

            for (dynamic score in scores!) {
              if (score is String) {
                int? parsedScore = int.tryParse(score);
                if (parsedScore != null) {
                  totalScore += parsedScore;
                  numberOfScores++;
                } else {
                  print('Warning: Failed to parse score $score as an integer.');
                }
              }
            }
            if (numberOfScores > 0) {
              score8 = totalScore ~/ numberOfScores;
            } else {
              score8 = 0;
            }
          }
          // lesson 9 scores
          if(data['2-4 lesson'] != null && data['2-4 lesson'].length == 10){
            List<dynamic>? scores = data['2-4 lesson'] as List<dynamic>?;
            int totalScore = 0;
            int numberOfScores = 0;

            for (dynamic score in scores!) {
              if (score is String) {
                int? parsedScore = int.tryParse(score);
                if (parsedScore != null) {
                  totalScore += parsedScore;
                  numberOfScores++;
                } else {
                  print('Warning: Failed to parse score $score as an integer.');
                }
              }
            }
            if (numberOfScores > 0) {
              score9 = totalScore ~/ numberOfScores;
            } else {
              score9 = 0;
            }
          }
          // lesson 10 scores
          if(data['2-5 lesson'] != null && data['2-5 lesson'].length == 10){
            List<dynamic>? scores = data['2-5 lesson'] as List<dynamic>?;
            int totalScore = 0;
            int numberOfScores = 0;

            for (dynamic score in scores!) {
              if (score is String) {
                int? parsedScore = int.tryParse(score);
                if (parsedScore != null) {
                  totalScore += parsedScore;
                  numberOfScores++;
                } else {
                  print('Warning: Failed to parse score $score as an integer.');
                }
              }
            }
            if (numberOfScores > 0) {
              score10 = totalScore ~/ numberOfScores;
            } else {
              score10 = 0;
            }
          }
          // lesson 11 scores
          if(data['3-1 lesson'] != null && data['3-1 lesson'].length == 10){
            List<dynamic>? scores = data['3-1 lesson'] as List<dynamic>?;
            int totalScore = 0;
            int numberOfScores = 0;

            for (dynamic score in scores!) {
              if (score is String) {
                int? parsedScore = int.tryParse(score);
                if (parsedScore != null) {
                  totalScore += parsedScore;
                  numberOfScores++;
                } else {
                  print('Warning: Failed to parse score $score as an integer.');
                }
              }
            }
            if (numberOfScores > 0) {
              score11 = totalScore ~/ numberOfScores;
            } else {
              score11 = 0;
            }
          }
          // lesson 12 scores
          if(data['3-2 lesson'] != null && data['3-2 lesson'].length == 10){
            List<dynamic>? scores = data['3-2 lesson'] as List<dynamic>?;
            int totalScore = 0;
            int numberOfScores = 0;

            for (dynamic score in scores!) {
              if (score is String) {
                int? parsedScore = int.tryParse(score);
                if (parsedScore != null) {
                  totalScore += parsedScore;
                  numberOfScores++;
                } else {
                  print('Warning: Failed to parse score $score as an integer.');
                }
              }
            }
            if (numberOfScores > 0) {
              score12 = totalScore ~/ numberOfScores;
            } else {
              score12 = 0;
            }
          }
          // lesson 13 scores
          if(data['3-3 lesson'] != null && data['3-3 lesson'].length == 10){
            List<dynamic>? scores = data['3-3 lesson'] as List<dynamic>?;
            int totalScore = 0;
            int numberOfScores = 0;

            for (dynamic score in scores!) {
              if (score is String) {
                int? parsedScore = int.tryParse(score);
                if (parsedScore != null) {
                  totalScore += parsedScore;
                  numberOfScores++;
                } else {
                  print('Warning: Failed to parse score $score as an integer.');
                }
              }
            }
            if (numberOfScores > 0) {
              score13 = totalScore ~/ numberOfScores;
            } else {
              score13 = 0;
            }
          }
          // lesson 14 scores
          if(data['3-4 lesson'] != null && data['3-4 lesson'].length == 10){
            List<dynamic>? scores = data['3-4 lesson'] as List<dynamic>?;
            int totalScore = 0;
            int numberOfScores = 0;

            for (dynamic score in scores!) {
              if (score is String) {
                int? parsedScore = int.tryParse(score);
                if (parsedScore != null) {
                  totalScore += parsedScore;
                  numberOfScores++;
                } else {
                  print('Warning: Failed to parse score $score as an integer.');
                }
              }
            }
            if (numberOfScores > 0) {
              score14 = totalScore ~/ numberOfScores;
            } else {
              score14 = 0;
            }
          }
          // lesson 15 scores
          if(data['3-5 lesson'] != null && data['3-5 lesson'].length == 10){
            List<dynamic>? scores = data['3-5 lesson'] as List<dynamic>?;
            int totalScore = 0;
            int numberOfScores = 0;

            for (dynamic score in scores!) {
              if (score is String) {
                int? parsedScore = int.tryParse(score);
                if (parsedScore != null) {
                  totalScore += parsedScore;
                  numberOfScores++;
                } else {
                  print('Warning: Failed to parse score $score as an integer.');
                }
              }
            }
            if (numberOfScores > 0) {
              score15 = totalScore ~/ numberOfScores;
            } else {
              score15 = 0;
            }
          }
          // lesson 16 scores
          if(data['4-1 lesson'] != null && data['4-1 lesson'].length == 10){
            List<dynamic>? scores = data['4-1 lesson'] as List<dynamic>?;
            int totalScore = 0;
            int numberOfScores = 0;

            for (dynamic score in scores!) {
              if (score is String) {
                int? parsedScore = int.tryParse(score);
                if (parsedScore != null) {
                  totalScore += parsedScore;
                  numberOfScores++;
                } else {
                  print('Warning: Failed to parse score $score as an integer.');
                }
              }
            }
            if (numberOfScores > 0) {
              score16 = totalScore ~/ numberOfScores;
            } else {
              score16 = 0;
            }
          }
          // lesson 17 scores
          if(data['4-2 lesson'] != null && data['4-2 lesson'].length == 10){
            List<dynamic>? scores = data['4-2 lesson'] as List<dynamic>?;
            int totalScore = 0;
            int numberOfScores = 0;

            for (dynamic score in scores!) {
              if (score is String) {
                int? parsedScore = int.tryParse(score);
                if (parsedScore != null) {
                  totalScore += parsedScore;
                  numberOfScores++;
                } else {
                  print('Warning: Failed to parse score $score as an integer.');
                }
              }
            }
            if (numberOfScores > 0) {
              score17 = totalScore ~/ numberOfScores;
            } else {
              score17 = 0;
            }
          }
          // lesson 18 scores
          if(data['4-3 lesson'] != null && data['4-3 lesson'].length == 10){
            List<dynamic>? scores = data['4-3 lesson'] as List<dynamic>?;
            int totalScore = 0;
            int numberOfScores = 0;

            for (dynamic score in scores!) {
              if (score is String) {
                int? parsedScore = int.tryParse(score);
                if (parsedScore != null) {
                  totalScore += parsedScore;
                  numberOfScores++;
                } else {
                  print('Warning: Failed to parse score $score as an integer.');
                }
              }
            }
            if (numberOfScores > 0) {
              score18 = totalScore ~/ numberOfScores;
            } else {
              score18 = 0;
            }
          }
          // lesson 19 scores
          if(data['4-4 lesson'] != null && data['4-4 lesson'].length == 10){
            List<dynamic>? scores = data['4-4 lesson'] as List<dynamic>?;
            int totalScore = 0;
            int numberOfScores = 0;

            for (dynamic score in scores!) {
              if (score is String) {
                int? parsedScore = int.tryParse(score);
                if (parsedScore != null) {
                  totalScore += parsedScore;
                  numberOfScores++;
                } else {
                  print('Warning: Failed to parse score $score as an integer.');
                }
              }
            }
            if (numberOfScores > 0) {
              score19 = totalScore ~/ numberOfScores;
            } else {
              score19 = 0;
            }
          }
          // lesson 20 scores
          if(data['4-5 lesson'] != null && data['4-5 lesson'].length == 10){
            List<dynamic>? scores = data['4-5 lesson'] as List<dynamic>?;
            int totalScore = 0;
            int numberOfScores = 0;

            for (dynamic score in scores!) {
              if (score is String) {
                int? parsedScore = int.tryParse(score);
                if (parsedScore != null) {
                  totalScore += parsedScore;
                  numberOfScores++;
                } else {
                  print('Warning: Failed to parse score $score as an integer.');
                }
              }
            }
            if (numberOfScores > 0) {
              score20 = totalScore ~/ numberOfScores;
            } else {
              score20 = 0;
            }
          }


        }
      }
    } catch (e) {
      print('Error calculating average score: $e');
    }
  }

}
