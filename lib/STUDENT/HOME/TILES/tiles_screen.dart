import 'package:acespeak/STUDENT/HOME/LESSONS/units.dart';
import 'package:acespeak/STUDENT/HOME/TILES/UNIT_LESSONS/loading.dart';
import 'package:acespeak/STUDENT/HOME/TILES/post-assessment/audio%20choices/post-assessment.dart';
import 'package:acespeak/STUDENT/HOME/TILES/post-assessment/speech%20reco/speech_loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../LESSONS/UNIT_LESSONS/loading.dart';

class TilesScreen extends StatefulWidget {
  final String userId;
  final String grade;
  const TilesScreen({super.key, required this.userId, required this.grade});

  @override
  State<TilesScreen> createState() => _TilesScreenState();
}

class _TilesScreenState extends State<TilesScreen> {
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
          .doc(widget.userId+widget.grade)
          .get();

      if (!snapshot.exists) {
        print('No score found for the user ID: ${widget.userId}');
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
     final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
  
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/_bg.png',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.1,),
                  Container(
                    width: screenWidth * .8,
                    height: screenHeight * .1,  
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage('assets/images/title.png',),
                      fit: BoxFit.cover,
                      ),
                    ),
                child: Center(child: Text('Lessons', style: TextStyle(color:Colors.white, fontWeight: FontWeight.bold, fontSize: 25))),
            ),
            SizedBox(height: screenHeight * 0.05,),
                  Container(
                    width: double.infinity,
                    height: screenHeight * 0.6,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: screenWidth * 0.1, right: screenWidth * 0.1),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    //lesson 1 ----------------------------- level1
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                          return NextScreen1(userId: widget.userId, grade: widget.grade, number: 1, lesson: '1-1 lesson', item : '1-1');
                                        }));
                                      },
                                      child: Container(
                                        width: screenWidth * .2,
                                        height: screenHeight * .1,  
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(number >= 1 ?
                                            'assets/images/_tiles1.png' :
                                            'assets/images/_tiles3.png',),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: number >= 1 ? Text('1', style: TextStyle(fontSize: screenHeight * 0.05, color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold), textAlign: TextAlign.center,)
                                              : SizedBox.shrink()),
                                    ),
                          
                                    GestureDetector(
                                      onTap: (){
                                        print(score1);
                                          if(finished.contains('1-1') || number > 1){
                                            print('you may go');
                                            // add number + 1;
                                          Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                            return PostAssessment1(userId: widget.userId, grade: widget.grade, lesson : '1-1', post : '1',);
                                          }));
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(bottom: screenHeight * 0.03) ,
                                        width: screenWidth * .2,
                                        height: screenHeight * .1,  
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(finished.contains('1-1') || number > 1 ? 'assets/images/_tiles4.png' : 'assets/images/_tiles2.png'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            score1 >= 40 ? Icons.star : Icons.star_border_outlined,
                                            size: screenWidth * 0.05,
                                            color: Color.fromARGB(255, 215, 215, 106)  ),
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 5),
                                            child: Icon(
                                              score1 <= 55 && score1 > 40
                                                  ? Icons.star_half_outlined
                                                  : score1 > 55
                                                      ? Icons.star
                                                      : Icons.star_border_outlined,
                                              size: screenWidth * 0.05,
                                              color: Color.fromARGB(255, 215, 215, 106)
                                            ),
                                          ),
                                          Icon(
                                            score1 <= 85 && score1 > 70
                                                  ? Icons.star_half_outlined
                                                  : score1 > 85
                                                      ? Icons.star
                                                      : Icons.star_border_outlined,
                                            size: screenWidth * 0.05,
                                            color:Color.fromARGB(255, 215, 215, 106)
                                          ),
                                        ],
                                      ),
                                      ),
                                    ),
                          
                                    //lesson 2
                                    GestureDetector(
                                      onTap: (){
                                        print("lesson 1-2");
                                        if(number >= 2){
                                          Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                          return NextScreen1(userId: widget.userId, grade: widget.grade, number: 2, lesson: '1-2 lesson', item : '1-2');
                                        }));
                                        }
                                        else{
                                          EasyLoading.showError("You can't open this lesson yet.");
                                        }
                                      },
                                      child: Container(
                                        width: screenWidth * .2,
                                        height: screenHeight * .1,  
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(number >= 2 ?
                                            'assets/images/_tiles1.png' :
                                            'assets/images/_tiles3.png',),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: number >= 2 ? Text('2', style: TextStyle(fontSize: screenHeight * 0.05, color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold), textAlign: TextAlign.center,)
                                              : SizedBox.shrink()),
                                    ),
                                  
                                    GestureDetector(
                                      onTap: (){
                                        print(score1);
                                        if(finished.contains('1-2') || number > 2){
                                          print('you may go');
                                          // add number + 1;
                                        Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                          return PostAssessment1(userId: widget.userId, grade: widget.grade, lesson : '1-2', post : '2',);
                                        }));
                                        }
                                        else{
                                          EasyLoading.showInfo("You cant open this yet");
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(bottom: screenHeight * 0.03) ,
                                        width: screenWidth * .2,
                                        height: screenHeight * .1,  
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(finished.contains('1-2') || number > 2 ? 'assets/images/_tiles4.png' : 'assets/images/_tiles2.png'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            score2 >= 40 ? Icons.star : Icons.star_border_outlined,
                                            size: screenWidth * 0.05,
                                            color: Color.fromARGB(255, 215, 215, 106)  ),
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 5),
                                            child: Icon(
                                              score2 <= 55 && score2 > 40
                                                  ? Icons.star_half_outlined
                                                  : score2 > 55
                                                      ? Icons.star
                                                      : Icons.star_border_outlined,
                                              size: screenWidth * 0.05,
                                              color: Color.fromARGB(255, 215, 215, 106)
                                            ),
                                          ),
                                          Icon(
                                            score2 <= 85 && score2 > 70
                                                  ? Icons.star_half_outlined
                                                  : score2 > 85
                                                      ? Icons.star
                                                      : Icons.star_border_outlined,
                                            size: screenWidth * 0.05,
                                            color:Color.fromARGB(255, 215, 215, 106)
                                          ),
                                        ],
                                      ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        //-------------------
                          Padding(
                            padding: EdgeInsets.only(left: screenWidth * 0.1, right: screenWidth * 0.1,),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    //lesson 3
                                    GestureDetector(
                                      onTap: (){
                                        if(number >= 3){
                                          Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                          return NextScreen1(userId: widget.userId, grade: widget.grade, number: 3, lesson: '1-3 lesson', item : '1-3');
                                        }));
                                        }
                                        else{
                                          EasyLoading.showError("You can't open this lesson yet.");
                                        }
                                      },
                                      child: Container(
                                        width: screenWidth * .2,
                                        height: screenHeight * .1,  
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(number >= 3 ?
                                            'assets/images/_tiles1.png' :
                                            'assets/images/_tiles3.png',),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: number >= 3 ? Text('3', style: TextStyle(fontSize: screenHeight * 0.05, color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold), textAlign: TextAlign.center,)
                                              : SizedBox.shrink()),
                                    ),
                          
                                    GestureDetector(
                                      onTap: (){
                                        print(score3);
                                    if(finished.contains('1-3') || number > 3){
                                      print('you may go');
                                      // add number + 1;
                                    Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                      return  SpeechPostAssessment1(userId: widget.userId, grade: widget.grade, lesson : '1-3', post : '3');
                                    }));
                                    }
                                    else{
                                      EasyLoading.showInfo("You cant open this yet");
                                    }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(bottom: screenHeight * 0.03) ,
                                        width: screenWidth * .2,
                                        height: screenHeight * .1,  
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(finished.contains('1-3') || number > 3 ? 'assets/images/_tiles4.png' : 'assets/images/_tiles2.png'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            score3 >= 40 ? Icons.star : Icons.star_border_outlined,
                                            size: screenWidth * 0.05,
                                            color: Color.fromARGB(255, 215, 215, 106)  ),
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 5),
                                            child: Icon(
                                              score3 <= 55 && score3 > 40
                                                  ? Icons.star_half_outlined
                                                  : score3 > 55
                                                      ? Icons.star
                                                      : Icons.star_border_outlined,
                                              size: screenWidth * 0.05,
                                              color: Color.fromARGB(255, 215, 215, 106)
                                            ),
                                          ),
                                          Icon(
                                            score3 <= 85 && score3 > 70
                                                  ? Icons.star_half_outlined
                                                  : score3 > 85
                                                      ? Icons.star
                                                      : Icons.star_border_outlined,
                                            size: screenWidth * 0.05,
                                            color:Color.fromARGB(255, 215, 215, 106)
                                          ),
                                        ],
                                      ),
                                      ),
                                    ),
                          
                                    //lesson 4
                                    GestureDetector(
                                      onTap: (){
                                        if(number >= 4){
                                          Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                          return NextScreen1(userId: widget.userId, grade: widget.grade, number: 4, lesson: '1-4 lesson', item : '1-4');
                                        }));
                                        }
                                        else{
                                          EasyLoading.showError("You can't open this lesson yet.");
                                        }
                                      },
                                      child: Container(
                                        width: screenWidth * .2,
                                        height: screenHeight * .1,  
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(number >= 4 ?
                                            'assets/images/_tiles1.png' :
                                            'assets/images/_tiles3.png',),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: number >= 4 ? Text('4', style: TextStyle(fontSize: screenHeight * 0.05, color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold), textAlign: TextAlign.center,)
                                              : SizedBox.shrink()),
                                    ),
                                  
                                    GestureDetector(
                                      onTap: (){
                                        print(score4);
                                        if(finished.contains('1-4') || number > 4){
                                          print('you may go');
                                          // add number + 1;
                                        Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                          return  SpeechPostAssessment1(userId: widget.userId, grade: widget.grade, lesson : '1-4', post : '4');
                                        }));
                                        }
                                        else{
                                          EasyLoading.showInfo("You cant open this yet");
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(bottom: screenHeight * 0.03) ,
                                        width: screenWidth * .2,
                                        height: screenHeight * .1,  
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(finished.contains('1-4') || number > 4 ? 'assets/images/_tiles4.png' : 'assets/images/_tiles2.png'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                                  score4 >= 40 ? Icons.star : Icons.star_border_outlined,
                                                  size: screenWidth * 0.05,
                                                  color: Color.fromARGB(255, 215, 215, 106)
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(bottom: 5),
                                                  child: Icon(
                                                    score4 <= 55 && score4 > 40
                                                        ? Icons.star_half_outlined
                                                        : score4 > 55
                                                            ? Icons.star
                                                            : Icons.star_border_outlined,
                                                    size: screenWidth * 0.05,
                                                    color: Color.fromARGB(255, 215, 215, 106)
                                                  ),
                                                ),
                                                Icon(
                                                  score4 <= 85 && score4 > 70
                                                        ? Icons.star_half_outlined
                                                        : score4 > 85
                                                            ? Icons.star
                                                            : Icons.star_border_outlined,
                                                  size: screenWidth * 0.05,
                                                  color:Color.fromARGB(255, 215, 215, 106)
                                                ),
                                        ],
                                      ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                                  
                          //-------------------
                          Padding(
                            padding: EdgeInsets.only(left: screenWidth * 0.1, right: screenWidth * 0.1,),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    //lesson 5
                                    GestureDetector(
                                      onTap: (){
                                        if(number >= 5){
                                        Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                        return NextScreen1(userId: widget.userId, grade: widget.grade, number: 5, lesson: '1-5 lesson', item : '1-5');
                                      }));
                                      }
                                      else{
                                        EasyLoading.showError("You can't open this lesson yet.");
                                      }
                                      },
                                      child: Container(
                                        width: screenWidth * .2,
                                        height: screenHeight * .1,  
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(number >= 5 ?
                                            'assets/images/_tiles1.png' :
                                            'assets/images/_tiles3.png',),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: number >= 5 ? Text('5', style: TextStyle(fontSize: screenHeight * 0.05, color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold), textAlign: TextAlign.center,)
                                              : SizedBox.shrink()),
                                    ),
                          
                                    GestureDetector(
                                      onTap: (){
                                        print(score5);
                                        if(finished.contains('1-5') || number > 5){
                                          print('you may go');
                                          // add number + 1;
                                        Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                          return  SpeechPostAssessment1(userId: widget.userId, grade: widget.grade, lesson : '1-5', post : '5');
                                        }));
                                        }
                                        else{
                                          EasyLoading.showInfo("You cant open this yet");
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(bottom: screenHeight * 0.03) ,
                                        width: screenWidth * .2,
                                        height: screenHeight * .1,  
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(finished.contains('1-5') || number > 5 ? 'assets/images/_tiles4.png' : 'assets/images/_tiles2.png'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            score5 >= 40 ? Icons.star : Icons.star_border_outlined,
                                            size: screenWidth * 0.05,
                                            color: Color.fromARGB(255, 215, 215, 106)  ),
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 5),
                                            child: Icon(
                                              score5 <= 55 && score5 > 40
                                                  ? Icons.star_half_outlined
                                                  : score5 > 55
                                                      ? Icons.star
                                                      : Icons.star_border_outlined,
                                              size: screenWidth * 0.05,
                                              color: Color.fromARGB(255, 215, 215, 106)
                                            ),
                                          ),
                                          Icon(
                                            score5 <= 85 && score5 > 70
                                                  ? Icons.star_half_outlined
                                                  : score5 > 85
                                                      ? Icons.star
                                                      : Icons.star_border_outlined,
                                            size: screenWidth * 0.05,
                                            color:Color.fromARGB(255, 215, 215, 106)
                                          ),
                                        ],
                                      ),
                                      ),
                                    ),
                          
                                    //lesson 6
                                    GestureDetector(
                                      onTap: (){
                                        if(number >= 6){
                                          Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                          return NextScreen1(userId: widget.userId, grade: widget.grade, number: 6, lesson: '2-1 lesson', item : '2-1');
                                        }));
                                        }
                                        else{
                                          EasyLoading.showError("You can't open this lesson yet.");
                                        }
                                      },
                                      child: Container(
                                        width: screenWidth * .2,
                                        height: screenHeight * .1,  
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(number >= 6 ?
                                            'assets/images/_tiles1.png' :
                                            'assets/images/_tiles3.png',),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: number >= 6 ? Text('6', style: TextStyle(fontSize: screenHeight * 0.05, color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold), textAlign: TextAlign.center,)
                                              : SizedBox.shrink()),
                                    ),
                                  
                                    GestureDetector(
                                      onTap: (){
                                        print(score6);
                                        if(finished.contains('2-1') || number > 6){
                                          print('you may go');
                                          // add number + 1;
                                        Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                          return  SpeechPostAssessment1(userId: widget.userId, grade: widget.grade, lesson : '2-1', post : '6');
                                        }));
                                        }
                                        else{
                                          EasyLoading.showInfo("You cant open this yet");
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(bottom: screenHeight * 0.03) ,
                                        width: screenWidth * .2,
                                        height: screenHeight * .1,  
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(finished.contains('2-1') || number > 6 ? 'assets/images/_tiles4.png' : 'assets/images/_tiles2.png'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                                  score6 >= 40 ? Icons.star : Icons.star_border_outlined,
                                                  size: screenWidth * 0.05,
                                                  color: Color.fromARGB(255, 215, 215, 106)
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(bottom: 5),
                                                  child: Icon(
                                                    score6 <= 55 && score6 > 40
                                                        ? Icons.star_half_outlined
                                                        : score6 > 55
                                                            ? Icons.star
                                                            : Icons.star_border_outlined,
                                                    size: screenWidth * 0.05,
                                                    color: Color.fromARGB(255, 215, 215, 106)
                                                  ),
                                                ),
                                                Icon(
                                                  score6 <= 85 && score6 > 70
                                                        ? Icons.star_half_outlined
                                                        : score6 > 85
                                                            ? Icons.star
                                                            : Icons.star_border_outlined,
                                                  size: screenWidth * 0.05,
                                                  color:Color.fromARGB(255, 215, 215, 106)
                                                ),
                                        ],
                                      ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          
                           //-------------------
                          Padding(
                            padding: EdgeInsets.only(left: screenWidth * 0.1, right: screenWidth * 0.1,),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    //lesson 7
                                    GestureDetector(
                                      onTap: (){
                                        if(number >= 7){
                                          Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                          return NextScreen1(userId: widget.userId, grade: widget.grade, number: 7, lesson: '2-2 lesson', item : '2-1');
                                        }));
                                        }
                                        else{
                                          EasyLoading.showError("You can't open this lesson yet.");
                                        }
                                      },
                                      child: Container(
                                        width: screenWidth * .2,
                                        height: screenHeight * .1,  
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(number >= 7 ?
                                            'assets/images/_tiles1.png' :
                                            'assets/images/_tiles3.png',),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: number >= 7 ? Text('7', style: TextStyle(fontSize: screenHeight * 0.05, color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold), textAlign: TextAlign.center,)
                                              : SizedBox.shrink()),
                                    ),
                          
                                    GestureDetector(
                                      onTap: (){
                                        print(score7);
                                        if(finished.contains('2-2') || number > 7){
                                          print('you may go');
                                          // add number + 1;
                                        Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                          return  SpeechPostAssessment1(userId: widget.userId, grade: widget.grade, lesson : '2-2', post : '7');
                                        }));
                                        }
                                        else{
                                          EasyLoading.showInfo("You cant open this yet");
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(bottom: screenHeight * 0.03) ,
                                        width: screenWidth * .2,
                                        height: screenHeight * .1,  
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(finished.contains('2-2') || number > 7 ? 'assets/images/_tiles4.png' : 'assets/images/_tiles2.png'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            score7 >= 40 ? Icons.star : Icons.star_border_outlined,
                                            size: screenWidth * 0.05,
                                            color: Color.fromARGB(255, 215, 215, 106)  ),
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 5),
                                            child: Icon(
                                              score7 <= 55 && score7 > 40
                                                  ? Icons.star_half_outlined
                                                  : score7 > 55
                                                      ? Icons.star
                                                      : Icons.star_border_outlined,
                                              size: screenWidth * 0.05,
                                              color: Color.fromARGB(255, 215, 215, 106)
                                            ),
                                          ),
                                          Icon(
                                            score7 <= 85 && score7 > 70
                                                  ? Icons.star_half_outlined
                                                  : score7 > 85
                                                      ? Icons.star
                                                      : Icons.star_border_outlined,
                                            size: screenWidth * 0.05,
                                            color:Color.fromARGB(255, 215, 215, 106)
                                          ),
                                        ],
                                      ),
                                      ),
                                    ),
                          
                                    //lesson 8
                                    GestureDetector(
                                      onTap: (){
                                        if(number >= 8){
                                          Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                          return NextScreen1(userId: widget.userId, grade: widget.grade, number: 8, lesson: '2-3 lesson', item : '2-3');
                                        }));
                                        }
                                        else{
                                          EasyLoading.showError("You can't open this lesson yet.");
                                        }
                                      },
                                      child: Container(
                                        width: screenWidth * .2,
                                        height: screenHeight * .1,  
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(number >= 8 ?
                                            'assets/images/_tiles1.png' :
                                            'assets/images/_tiles3.png',),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: number >= 8 ? Text('8', style: TextStyle(fontSize: screenHeight * 0.05, color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold), textAlign: TextAlign.center,)
                                              : SizedBox.shrink()),
                                    ),
                                  
                                    GestureDetector(
                                      onTap: (){
                                        print(score8);
                                        if(finished.contains('2-3') || number > 8){
                                          print('you may go');
                                          // add number + 1;
                                        Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                          return  SpeechPostAssessment1(userId: widget.userId, grade: widget.grade, lesson : '2-3', post : '8');
                                        }));
                                        }
                                        else{
                                          EasyLoading.showInfo("You cant open this yet");
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(bottom: screenHeight * 0.03) ,
                                        width: screenWidth * .2,
                                        height: screenHeight * .1,  
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(finished.contains('2-3') || number > 8 ? 'assets/images/_tiles4.png' : 'assets/images/_tiles2.png'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                                  score8 >= 40 ? Icons.star : Icons.star_border_outlined,
                                                  size: screenWidth * 0.05,
                                                  color: Color.fromARGB(255, 215, 215, 106)
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(bottom: 5),
                                                  child: Icon(
                                                    score8 <= 55 && score8 > 40
                                                        ? Icons.star_half_outlined
                                                        : score8 > 55
                                                            ? Icons.star
                                                            : Icons.star_border_outlined,
                                                    size: screenWidth * 0.05,
                                                    color: Color.fromARGB(255, 215, 215, 106)
                                                  ),
                                                ),
                                                Icon(
                                                  score8 <= 85 && score8 > 70
                                                        ? Icons.star_half_outlined
                                                        : score8 > 85
                                                            ? Icons.star
                                                            : Icons.star_border_outlined,
                                                  size: screenWidth * 0.05,
                                                  color:Color.fromARGB(255, 215, 215, 106)
                                                ),
                                        ],
                                      ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                                  
                          //-------------------
                          Padding(
                            padding: EdgeInsets.only(left: screenWidth * 0.1, right: screenWidth * 0.1,),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    //lesson 9
                                    GestureDetector(
                                      onTap: (){
                                        if(number >= 9){
                                      Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                      return NextScreen1(userId: widget.userId, grade: widget.grade, number: 9, lesson: '2-4 lesson', item : '2-4');
                                    }));
                                    }
                                    else{
                                      EasyLoading.showError("You can't open this lesson yet.");
                                    }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(bottom: screenHeight * 0.03) ,
                                        width: screenWidth * .2,
                                        height: screenHeight * .1,  
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(number >= 9 ?
                                            'assets/images/_tiles1.png' :
                                            'assets/images/_tiles3.png',),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: number >= 9 ? Text('9', style: TextStyle(fontSize: screenHeight * 0.05, color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold), textAlign: TextAlign.center,)
                                              : SizedBox.shrink()),
                                    ),
                          
                                    GestureDetector(
                                      onTap: (){
                                          if(finished.contains('2-4') || number > 9){
                                        print('you may go');
                                        // add number + 1;
                                      Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                        return  SpeechPostAssessment1(userId: widget.userId, grade: widget.grade, lesson : '2-4', post : '9');
                                      }));
                                      }
                                      else{
                                        EasyLoading.showInfo("You cant open this yet");
                                      }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(bottom: screenHeight * 0.03) ,
                                        width: screenWidth * .2,
                                        height: screenHeight * .1,  
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(finished.contains('2-4') || number > 9 ? 'assets/images/_tiles4.png' : 'assets/images/_tiles2.png'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            score9 >= 40 ? Icons.star : Icons.star_border_outlined,
                                            size: screenWidth * 0.05,
                                            color: Color.fromARGB(255, 215, 215, 106)  ),
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 5),
                                            child: Icon(
                                              score9 <= 55 && score9 > 40
                                                  ? Icons.star_half_outlined
                                                  : score9 > 55
                                                      ? Icons.star
                                                      : Icons.star_border_outlined,
                                              size: screenWidth * 0.05,
                                              color: Color.fromARGB(255, 215, 215, 106)
                                            ),
                                          ),
                                          Icon(
                                            score9 <= 85 && score9 > 70
                                                  ? Icons.star_half_outlined
                                                  : score9 > 85
                                                      ? Icons.star
                                                      : Icons.star_border_outlined,
                                            size: screenWidth * 0.05,
                                            color:Color.fromARGB(255, 215, 215, 106)
                                          ),
                                        ],
                                      ),
                                      ),
                                    ),
                          
                                    //lesson 10
                                    GestureDetector(
                                      onTap: (){
                                        if(number >= 10){
                                          Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                          return NextScreen(userId: widget.userId, grade: widget.grade, number: 10, lesson: '2-5 lesson', item : '2-5');
                                        }));
                                        }
                                        else{
                                          EasyLoading.showError("You can't open this lesson yet.");
                                        }
                                      },
                                      child: Container(
                                        width: screenWidth * .2,
                                        height: screenHeight * .1,  
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(number >= 10 ?
                                            'assets/images/_tiles1.png' :
                                            'assets/images/_tiles3.png',),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: number >= 10 ? Text('10', style: TextStyle(fontSize: screenHeight * 0.05, color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold), textAlign: TextAlign.center,)
                                              : SizedBox.shrink()),
                                    ),
                                  
                                    GestureDetector(
                                      onTap: (){
                                        print(score10);
                                      if(finished.contains('2-5') || number > 10){
                                        print('you may go');
                                        // add number + 1;
                                      Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                        return  SpeechPostAssessment1(userId: widget.userId, grade: widget.grade, lesson : '2-5', post : '10');
                                      }));
                                      }
                                      else{
                                        EasyLoading.showInfo("You cant open this yet");
                                      }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(bottom: screenHeight * 0.03) ,
                                        width: screenWidth * .2,
                                        height: screenHeight * .1,  
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(finished.contains('2-5') || number > 10 ? 'assets/images/_tiles4.png' : 'assets/images/_tiles2.png'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                                  score10 >= 40 ? Icons.star : Icons.star_border_outlined,
                                                  size: screenWidth * 0.05,
                                                  color: Color.fromARGB(255, 215, 215, 106)
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(bottom: 5),
                                                  child: Icon(
                                                    score10 <= 55 && score10 > 40
                                                        ? Icons.star_half_outlined
                                                        : score10 > 55
                                                            ? Icons.star
                                                            : Icons.star_border_outlined,
                                                    size: screenWidth * 0.05,
                                                    color: Color.fromARGB(255, 215, 215, 106)
                                                  ),
                                                ),
                                                Icon(
                                                  score10 <= 85 && score10 > 70
                                                        ? Icons.star_half_outlined
                                                        : score10 > 85
                                                            ? Icons.star
                                                            : Icons.star_border_outlined,
                                                  size: screenWidth * 0.05,
                                                  color:Color.fromARGB(255, 215, 215, 106)
                                                ),
                                        ],
                                      ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          
                          //-------------------
                          Padding(
                            padding: EdgeInsets.only(left: screenWidth * 0.1, right: screenWidth * 0.1,),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    //lesson 11
                                    GestureDetector(
                                      onTap: (){
                                        if(number >= 11){
                                          Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                          return NextScreen1(userId: widget.userId, grade: widget.grade, number: 11, lesson: '3-1 lesson', item : '3-1');
                                        }));
                                        }
                                        else{
                                          EasyLoading.showError("You can't open this lesson yet.");
                                        }
                                      },
                                      child: Container(
                                        width: screenWidth * .2,
                                        height: screenHeight * .1,  
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(number >= 11 ?
                                            'assets/images/_tiles1.png' :
                                            'assets/images/_tiles3.png',),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: number >= 11 ? Text('11', style: TextStyle(fontSize: screenHeight * 0.05, color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold), textAlign: TextAlign.center,)
                                              : SizedBox.shrink()
                                      ),
                                    ),
                          
                                    GestureDetector(
                                      onTap: (){
                                          print(score11);
                                        if(finished.contains('3-1') || number > 11){
                                          print('you may go');
                                          // add number + 1;
                                        Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                          return  SpeechPostAssessment1(userId: widget.userId, grade: widget.grade, lesson : '3-1', post : '11');
                                        }));
                                        }
                                        else{
                                          EasyLoading.showInfo("You cant open this yet");
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(bottom: screenHeight * 0.03) ,
                                        width: screenWidth * .2,
                                        height: screenHeight * .1,  
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(finished.contains('3-1') || number > 11 ? 'assets/images/_tiles4.png' : 'assets/images/_tiles2.png'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            score11 >= 40 ? Icons.star : Icons.star_border_outlined,
                                            size: screenWidth * 0.05,
                                            color: Color.fromARGB(255, 215, 215, 106)  ),
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 5),
                                            child: Icon(
                                              score11 <= 55 && score11 > 40
                                                  ? Icons.star_half_outlined
                                                  : score11 > 55
                                                      ? Icons.star
                                                      : Icons.star_border_outlined,
                                              size: screenWidth * 0.05,
                                              color: Color.fromARGB(255, 215, 215, 106)
                                            ),
                                          ),
                                          Icon(
                                            score11 <= 85 && score11 > 70
                                                  ? Icons.star_half_outlined
                                                  : score11 > 85
                                                      ? Icons.star
                                                      : Icons.star_border_outlined,
                                            size: screenWidth * 0.05,
                                            color:Color.fromARGB(255, 215, 215, 106)
                                          ),
                                        ],
                                      ),
                                      ),
                                    ),
                          
                                    //lesson 12
                                    GestureDetector(
                                      onTap: (){
                                        if(number >= 12){
                                          Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                          return NextScreen1(userId: widget.userId, grade: widget.grade, number: 12, lesson: '3-2 lesson', item : '3-2');
                                        }));
                                        }
                                        else{
                                          EasyLoading.showError("You can't open this lesson yet.");
                                        }
                                      },
                                      child: Container(
                                        width: screenWidth * .2,
                                        height: screenHeight * .1,  
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(number >= 12 ?
                                            'assets/images/_tiles1.png' :
                                            'assets/images/_tiles3.png',),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: number >= 12 ? Text('12', style: TextStyle(fontSize: screenHeight * 0.05, color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold), textAlign: TextAlign.center,)
                                              : SizedBox.shrink()
                                      ),
                                    ),
                                  
                                    GestureDetector(
                                      onTap: (){
                                        print(score12);
                                    if(finished.contains('3-2') || number > 12){
                                      print('you may go');
                                      // add number + 1;
                                    Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                      return  SpeechPostAssessment1(userId: widget.userId, grade: widget.grade, lesson : '3-2', post : '12');
                                    }));
                                    }
                                    else{
                                      EasyLoading.showInfo("You cant open this yet");
                                    }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(bottom: screenHeight * 0.03) ,
                                        width: screenWidth * .2,
                                        height: screenHeight * .1,  
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(finished.contains('3-2') || number > 12 ? 'assets/images/_tiles4.png' : 'assets/images/_tiles2.png'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                                  score12 >= 40 ? Icons.star : Icons.star_border_outlined,
                                                  size: screenWidth * 0.05,
                                                  color: Color.fromARGB(255, 215, 215, 106)
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(bottom: 5),
                                                  child: Icon(
                                                    score12 <= 55 && score12 > 40
                                                        ? Icons.star_half_outlined
                                                        : score12 > 55
                                                            ? Icons.star
                                                            : Icons.star_border_outlined,
                                                    size: screenWidth * 0.05,
                                                    color: Color.fromARGB(255, 215, 215, 106)
                                                  ),
                                                ),
                                                Icon(
                                                  score12 <= 85 && score12 > 70
                                                        ? Icons.star_half_outlined
                                                        : score12 > 85
                                                            ? Icons.star
                                                            : Icons.star_border_outlined,
                                                  size: screenWidth * 0.05,
                                                  color:Color.fromARGB(255, 215, 215, 106)
                                                ),
                                        ],
                                      ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                                  
                          //-------------------
                          Padding(
                            padding: EdgeInsets.only(left: screenWidth * 0.1, right: screenWidth * 0.1,),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    //lesson 13
                                    GestureDetector(
                                      onTap: (){
                                        if(number >= 13){
                                          Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                          return NextScreen1(userId: widget.userId, grade: widget.grade, number: 13, lesson: '3-3 lesson', item : '3-3');
                                        }));
                                        }
                                        else{
                                          EasyLoading.showError("You can't open this lesson yet.");
                                        }
                                      },
                                      child: Container(
                                        width: screenWidth * .2,
                                        height: screenHeight * .1,  
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(number >= 13 ?
                                            'assets/images/_tiles1.png' :
                                            'assets/images/_tiles3.png',),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: number >= 13 ? Text('13', style: TextStyle(fontSize: screenHeight * 0.05, color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold), textAlign: TextAlign.center,)
                                              : SizedBox.shrink()
                                      ),
                                    ),
                          
                                    GestureDetector(
                                      onTap: (){
                                         print(score13);
                                        if(finished.contains('3-3') || number > 13){
                                          print('you may go');
                                          // add number + 1;
                                        Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                          return  SpeechPostAssessment1(userId: widget.userId, grade: widget.grade, lesson : '3-3', post : '13');
                                        }));
                                        }
                                        else{
                                          EasyLoading.showInfo("You cant open this yet");
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(bottom: screenHeight * 0.03) ,
                                        width: screenWidth * .2,
                                        height: screenHeight * .1,  
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(finished.contains('3-3') || number > 13 ? 'assets/images/_tiles4.png' : 'assets/images/_tiles2.png'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            score13 >= 40 ? Icons.star : Icons.star_border_outlined,
                                            size: screenWidth * 0.05,
                                            color: Color.fromARGB(255, 215, 215, 106)  ),
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 5),
                                            child: Icon(
                                              score13 <= 55 && score13 > 40
                                                  ? Icons.star_half_outlined
                                                  : score13 > 55
                                                      ? Icons.star
                                                      : Icons.star_border_outlined,
                                              size: screenWidth * 0.05,
                                              color: Color.fromARGB(255, 215, 215, 106)
                                            ),
                                          ),
                                          Icon(
                                            score13 <= 85 && score13 > 70
                                                  ? Icons.star_half_outlined
                                                  : score13 > 85
                                                      ? Icons.star
                                                      : Icons.star_border_outlined,
                                            size: screenWidth * 0.05,
                                            color:Color.fromARGB(255, 215, 215, 106)
                                          ),
                                        ],
                                      ),
                                      ),
                                    ),
                          
                                    //lesson 14
                                    GestureDetector(
                                      onTap: (){
                                        if(number >= 14){
                                          Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                          return NextScreen1(userId: widget.userId, grade: widget.grade, number: 14, lesson: '3-4 lesson', item : '3-4');
                                        }));
                                        }
                                        else{
                                          EasyLoading.showError("You can't open this lesson yet.");
                                        }
                                      },
                                      child: Container(
                                        width: screenWidth * .2,
                                        height: screenHeight * .1,  
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(number >= 14 ?
                                            'assets/images/_tiles1.png' :
                                            'assets/images/_tiles3.png',),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: number >= 14 ? Text('14', style: TextStyle(fontSize: screenHeight * 0.05, color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold), textAlign: TextAlign.center,)
                                              : SizedBox.shrink()
                                      ),
                                    ),
                                  
                                    GestureDetector(
                                      onTap: (){
                                        print(score14);
                                    if(finished.contains('3-4') || number > 14){
                                      print('you may go');
                                      // add number + 1;
                                    Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                      return  SpeechPostAssessment1(userId: widget.userId, grade: widget.grade, lesson : '3-4', post : '14');
                                    }));
                                    }
                                    else{
                                      EasyLoading.showInfo("You cant open this yet");
                                    }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(bottom: screenHeight * 0.03) ,
                                        width: screenWidth * .2,
                                        height: screenHeight * .1,  
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(finished.contains('3-4') || number > 14 ? 'assets/images/_tiles4.png' : 'assets/images/_tiles2.png'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                                  score14 >= 40 ? Icons.star : Icons.star_border_outlined,
                                                  size: screenWidth * 0.05,
                                                  color: Color.fromARGB(255, 215, 215, 106)
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(bottom: 5),
                                                  child: Icon(
                                                    score14 <= 55 && score14 > 40
                                                        ? Icons.star_half_outlined
                                                        : score14 > 55
                                                            ? Icons.star
                                                            : Icons.star_border_outlined,
                                                    size: screenWidth * 0.05,
                                                    color: Color.fromARGB(255, 215, 215, 106)
                                                  ),
                                                ),
                                                Icon(
                                                  score14 <= 85 && score14> 70
                                                        ? Icons.star_half_outlined
                                                        : score14 > 85
                                                            ? Icons.star
                                                            : Icons.star_border_outlined,
                                                  size: screenWidth * 0.05,
                                                  color:Color.fromARGB(255, 215, 215, 106)
                                                ),
                                        ],
                                      ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                                  
                           //-------------------
                          Padding(
                            padding: EdgeInsets.only(left: screenWidth * 0.1, right: screenWidth * 0.1,),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    //lesson 13
                                    GestureDetector(
                                      onTap: (){
                                        if(number >= 15){
                                          Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                          return NextScreen1(userId: widget.userId, grade: widget.grade, number: 15, lesson: '3-5 lesson', item : '3-5');
                                        }));
                                        }
                                        else{
                                          EasyLoading.showError("You can't open this lesson yet.");
                                        }
                                      },
                                      child: Container(
                                        width: screenWidth * .2,
                                        height: screenHeight * .1,  
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(number >= 15 ?
                                            'assets/images/_tiles1.png' :
                                            'assets/images/_tiles3.png',),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: number >= 15 ? Text('15', style: TextStyle(fontSize: screenHeight * 0.05, color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold), textAlign: TextAlign.center,)
                                              : SizedBox.shrink()
                                      ),
                                    ),
                          
                                    GestureDetector(
                                      onTap: (){
                                         print(score15);
                                        if(finished.contains('3-5') || number > 15){
                                          print('you may go');
                                          // add number + 1;
                                        Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                          return  SpeechPostAssessment1(userId: widget.userId, grade: widget.grade, lesson : '3-5', post : '15');
                                        }));
                                        }
                                        else{
                                          EasyLoading.showInfo("You cant open this yet");
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(bottom: screenHeight * 0.03) ,
                                        width: screenWidth * .2,
                                        height: screenHeight * .1,  
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(finished.contains('3-5') || number > 15 ? 'assets/images/_tiles4.png' : 'assets/images/_tiles2.png'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            score15 >= 40 ? Icons.star : Icons.star_border_outlined,
                                            size: screenWidth * 0.05,
                                            color: Color.fromARGB(255, 215, 215, 106)  ),
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 5),
                                            child: Icon(
                                              score15 <= 55 && score15 > 40
                                                  ? Icons.star_half_outlined
                                                  : score15 > 55
                                                      ? Icons.star
                                                      : Icons.star_border_outlined,
                                              size: screenWidth * 0.05,
                                              color: Color.fromARGB(255, 215, 215, 106)
                                            ),
                                          ),
                                          Icon(
                                            score15 <= 85 && score15 > 70
                                                  ? Icons.star_half_outlined
                                                  : score15 > 85
                                                      ? Icons.star
                                                      : Icons.star_border_outlined,
                                            size: screenWidth * 0.05,
                                            color:Color.fromARGB(255, 215, 215, 106)
                                          ),
                                        ],
                                      ),
                                      ),
                                    ),
                          
                                    //lesson 16
                                    GestureDetector(
                                      onTap: (){
                                        if(number >= 16){
                                          Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                          return NextScreen1(userId: widget.userId, grade: widget.grade, number: 16, lesson: '4-1 lesson', item : '4-1');
                                        }));
                                        }
                                        else{
                                          EasyLoading.showError("You can't open this lesson yet.");
                                        }
                                      },
                                      child: Container(
                                        width: screenWidth * .2,
                                        height: screenHeight * .1,  
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(number >= 16 ?
                                            'assets/images/_tiles1.png' :
                                            'assets/images/_tiles3.png',),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: number >= 16 ? Text('16', style: TextStyle(fontSize: screenHeight * 0.05, color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold), textAlign: TextAlign.center,)
                                              : SizedBox.shrink()
                                      ),
                                    ),
                                  
                                    GestureDetector(
                                      onTap: (){
                                    print(score16);
                                    if(finished.contains('4-1') || number > 16){
                                      print('you may go');
                                      // add number + 1;
                                    Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                      return  SpeechPostAssessment1(userId: widget.userId, grade: widget.grade, lesson : '4-1', post : '16');
                                    }));
                                    }
                                    else{
                                      EasyLoading.showInfo("You cant open this yet");
                                    }
                                  },
                                      child: Container(
                                        padding: EdgeInsets.only(bottom: screenHeight * 0.03) ,
                                        width: screenWidth * .2,
                                        height: screenHeight * .1,  
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(finished.contains('4-1') || number > 16 ? 'assets/images/_tiles4.png' : 'assets/images/_tiles2.png'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                                  score16 >= 40 ? Icons.star : Icons.star_border_outlined,
                                                  size: screenWidth * 0.05,
                                                  color: Color.fromARGB(255, 215, 215, 106)
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(bottom: 5),
                                                  child: Icon(
                                                    score16 <= 55 && score16 > 40
                                                        ? Icons.star_half_outlined
                                                        : score16 > 55
                                                            ? Icons.star
                                                            : Icons.star_border_outlined,
                                                    size: screenWidth * 0.05,
                                                    color: Color.fromARGB(255, 215, 215, 106)
                                                  ),
                                                ),
                                                Icon(
                                                  score16 <= 85 && score16> 70
                                                        ? Icons.star_half_outlined
                                                        : score16 > 85
                                                            ? Icons.star
                                                            : Icons.star_border_outlined,
                                                  size: screenWidth * 0.05,
                                                  color:Color.fromARGB(255, 215, 215, 106)
                                                ),
                                        ],
                                      ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                                  
                          //-------------------
                          Padding(
                            padding: EdgeInsets.only(left: screenWidth * 0.1, right: screenWidth * 0.1,),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    //lesson 17
                                    GestureDetector(
                                      onTap: (){
                                         if(number >= 17){
                                          Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                          return NextScreen1(userId: widget.userId, grade: widget.grade, number: 17, lesson: '4-2 lesson', item : '4-2');
                                        }));
                                        }
                                        else{
                                          EasyLoading.showError("You can't open this lesson yet.");
                                        }
                                      },
                                      child: Container(
                                        width: screenWidth * .2,
                                        height: screenHeight * .1,  
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(number >= 17 ?
                                            'assets/images/_tiles1.png' :
                                            'assets/images/_tiles3.png',),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: number >= 17 ? Text('17', style: TextStyle(fontSize: screenHeight * 0.05, color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold), textAlign: TextAlign.center,)
                                              : SizedBox.shrink()
                                      ),
                                    ),
                          
                                    GestureDetector(
                                      onTap: (){
                                        print(score17);
                                        if(finished.contains('4-2') || number > 17){
                                          print('you may go');
                                          // add number + 1;
                                        Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                          return  SpeechPostAssessment1(userId: widget.userId, grade: widget.grade, lesson : '4-2', post : '17');
                                        }));
                                        }
                                        else{
                                          EasyLoading.showInfo("You cant open this yet");
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(bottom: screenHeight * 0.03) ,
                                        width: screenWidth * .2,
                                        height: screenHeight * .1,  
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(finished.contains('4-2') || number > 17 ? 'assets/images/_tiles4.png' : 'assets/images/_tiles2.png'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            score17 >= 40 ? Icons.star : Icons.star_border_outlined,
                                            size: screenWidth * 0.05,
                                            color: Color.fromARGB(255, 215, 215, 106)  ),
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 5),
                                            child: Icon(
                                              score17 <= 55 && score17 > 40
                                                  ? Icons.star_half_outlined
                                                  : score17 > 55
                                                      ? Icons.star
                                                      : Icons.star_border_outlined,
                                              size: screenWidth * 0.05,
                                              color: Color.fromARGB(255, 215, 215, 106)
                                            ),
                                          ),
                                          Icon(
                                            score17 <= 85 && score17 > 70
                                                  ? Icons.star_half_outlined
                                                  : score17 > 85
                                                      ? Icons.star
                                                      : Icons.star_border_outlined,
                                            size: screenWidth * 0.05,
                                            color:Color.fromARGB(255, 215, 215, 106)
                                          ),
                                        ],
                                      ),
                                      ),
                                    ),
                          
                                    //lesson 18
                                    GestureDetector(
                                      onTap: (){
                                         if(number >= 18){
                                          Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                          return NextScreen1(userId: widget.userId, grade: widget.grade, number: 18, lesson: '4-3 lesson', item : '4-3');
                                        }));
                                        }
                                        else{
                                          EasyLoading.showError("You can't open this lesson yet.");
                                        }
                                      },
                                      child: Container(
                                        width: screenWidth * .2,
                                        height: screenHeight * .1,  
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(number >= 18 ?
                                            'assets/images/_tiles1.png' :
                                            'assets/images/_tiles3.png',),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: number >= 18 ? Text('18', style: TextStyle(fontSize: screenHeight * 0.05, color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold), textAlign: TextAlign.center,)
                                              : SizedBox.shrink()
                                      ),
                                    ),
                                  
                                    GestureDetector(
                                      onTap: (){
                                        print(score18);
                                        if(finished.contains('4-3') || number > 18){
                                          print('you may go');
                                          // add number + 1;
                                        Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                          return  SpeechPostAssessment1(userId: widget.userId, grade: widget.grade, lesson : '4-3', post : '18');
                                        }));
                                        }
                                        else{
                                          EasyLoading.showInfo("You cant open this yet");
                                        }
                                  },
                                      child: Container(
                                        padding: EdgeInsets.only(bottom: screenHeight * 0.03) ,
                                        width: screenWidth * .2,
                                        height: screenHeight * .1,  
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(finished.contains('4-3') || number > 18 ? 'assets/images/_tiles4.png' : 'assets/images/_tiles2.png'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                                  score18 >= 40 ? Icons.star : Icons.star_border_outlined,
                                                  size: screenWidth * 0.05,
                                                  color: Color.fromARGB(255, 215, 215, 106)
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(bottom: 5),
                                                  child: Icon(
                                                    score18 <= 55 && score18 > 40
                                                        ? Icons.star_half_outlined
                                                        : score18 > 55
                                                            ? Icons.star
                                                            : Icons.star_border_outlined,
                                                    size: screenWidth * 0.05,
                                                    color: Color.fromARGB(255, 215, 215, 106)
                                                  ),
                                                ),
                                                Icon(
                                                  score18 <= 85 && score18> 70
                                                        ? Icons.star_half_outlined
                                                        : score18 > 85
                                                            ? Icons.star
                                                            : Icons.star_border_outlined,
                                                  size: screenWidth * 0.05,
                                                  color:Color.fromARGB(255, 215, 215, 106)
                                                ),
                                        ],
                                      ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                                  
                          //-------------------
                          Padding(
                            padding: EdgeInsets.only(left: screenWidth * 0.1, right: screenWidth * 0.1,),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    //lesson 19
                                    GestureDetector(
                                      onTap: (){
                                         if(number >= 19){
                                          Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                          return NextScreen1(userId: widget.userId, grade: widget.grade, number: 19, lesson: '4-4 lesson', item : '4-4');
                                        }));
                                        }
                                        else{
                                          EasyLoading.showError("You can't open this lesson yet.");
                                        }
                                      },
                                      child: Container(
                                        width: screenWidth * .2,
                                        height: screenHeight * .1,  
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(number >= 19 ?
                                            'assets/images/_tiles1.png' :
                                            'assets/images/_tiles3.png',),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: number >= 19 ? Text('19', style: TextStyle(fontSize: screenHeight * 0.05, color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold), textAlign: TextAlign.center,)
                                              : SizedBox.shrink()
                                      ),
                                    ),
                          
                                    GestureDetector(
                                      onTap: (){
                                        print(score19);
                                        if(finished.contains('4-4') || number > 19){
                                          print('you may go');
                                          // add number + 1;
                                        Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                          return  SpeechPostAssessment1(userId: widget.userId, grade: widget.grade, lesson : '4-4', post : '19');
                                        }));
                                        }
                                        else{
                                          EasyLoading.showInfo("You cant open this yet");
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(bottom: screenHeight * 0.03) ,
                                        width: screenWidth * .2,
                                        height: screenHeight * .1,  
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(finished.contains('4-4') || number > 19 ? 'assets/images/_tiles4.png' : 'assets/images/_tiles2.png'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            score19 >= 40 ? Icons.star : Icons.star_border_outlined,
                                            size: screenWidth * 0.05,
                                            color: Color.fromARGB(255, 215, 215, 106)  ),
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 5),
                                            child: Icon(
                                              score19 <= 55 && score19 > 40
                                                  ? Icons.star_half_outlined
                                                  : score19 > 55
                                                      ? Icons.star
                                                      : Icons.star_border_outlined,
                                              size: screenWidth * 0.05,
                                              color: Color.fromARGB(255, 215, 215, 106)
                                            ),
                                          ),
                                          Icon(
                                            score19 <= 85 && score19 > 70
                                                  ? Icons.star_half_outlined
                                                  : score19 > 85
                                                      ? Icons.star
                                                      : Icons.star_border_outlined,
                                            size: screenWidth * 0.05,
                                            color:Color.fromARGB(255, 215, 215, 106)
                                          ),
                                        ],
                                      ),
                                      ),
                                    ),
                          
                                    //lesson 20
                                    GestureDetector(
                                      onTap: (){
                                          if(number >= 20){
                                          Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                          return NextScreen1(userId: widget.userId, grade: widget.grade, number: 20, lesson: '4-5 lesson', item : '4-5');
                                        }));
                                        }
                                        else{
                                          EasyLoading.showError("You can't open this lesson yet.");
                                        }
                                      },
                                      child: Container(
                                        width: screenWidth * .2,
                                        height: screenHeight * .1,  
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(number >= 20 ?
                                            'assets/images/_tiles1.png' :
                                            'assets/images/_tiles3.png',),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: number >= 20 ? Text('20', style: TextStyle(fontSize: screenHeight * 0.05, color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold), textAlign: TextAlign.center,)
                                              : SizedBox.shrink()
                                      ),
                                    ),
                                  
                                    GestureDetector(
                                      onTap: (){
                                        print(score20);
                                      if(finished.contains('4-5') || number > 20){
                                        print('you may go');
                                        // add number + 1;
                                      Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                        return  SpeechPostAssessment1(userId: widget.userId, grade: widget.grade, lesson : '4-5', post : '20');
                                      }));
                                      }
                                      else{
                                        EasyLoading.showInfo("You cant open this yet");
                                      }
                                  },
                                      child: Container(
                                        padding: EdgeInsets.only(bottom: screenHeight * 0.03) ,
                                        width: screenWidth * .2,
                                        height: screenHeight * .1,  
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(finished.contains('4-5') || number > 20 ? 'assets/images/_tiles4.png' : 'assets/images/_tiles2.png'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                                  score20 >= 40 ? Icons.star : Icons.star_border_outlined,
                                                  size: screenWidth * 0.05,
                                                  color: Color.fromARGB(255, 215, 215, 106)
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(bottom: 5),
                                                  child: Icon(
                                                    score20 <= 55 && score20 > 40
                                                        ? Icons.star_half_outlined
                                                        : score20 > 55
                                                            ? Icons.star
                                                            : Icons.star_border_outlined,
                                                    size: screenWidth * 0.05,
                                                    color: Color.fromARGB(255, 215, 215, 106)
                                                  ),
                                                ),
                                                Icon(
                                                  score20 <= 85 && score20> 70
                                                        ? Icons.star_half_outlined
                                                        : score20 > 85
                                                            ? Icons.star
                                                            : Icons.star_border_outlined,
                                                  size: screenWidth * 0.05,
                                                  color:Color.fromARGB(255, 215, 215, 106)
                                                ),
                                        ],
                                      ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                                  
                                  
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
             Positioned(
              top: 20,
              right: 20,
                child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                  return UnitScreen(userid: widget.userId);
                }));
               },
             ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> postAssessmentScore() async {
    try {
      String documentId = widget.userId;
      CollectionReference scoreCollection =
          FirebaseFirestore.instance.collection('score');

      DocumentSnapshot docSnapshot =
          await scoreCollection.doc(documentId+widget.grade).get();

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