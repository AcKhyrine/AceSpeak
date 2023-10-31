import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../HOME/student_classroom.dart';

class ProgressHistory extends StatefulWidget {
  final String userId;
  final String grade;
  const ProgressHistory({ required this.userId, required this.grade});

  @override
  State<ProgressHistory> createState() => _ProgressHistoryState();
}

class _ProgressHistoryState extends State<ProgressHistory> {
  int score1=0, score2=0, score3=0, score4=0, score5=0, score6=0, score7=0, score8=0, score9=0, score10=0, score11=0, score12=0, score13=0, score14=0, score15=0, score16=0, score17=0, score18=0, score19=0, score20=0;
  @override
  void initState() {
    postAssessmentScore();
    super.initState();
  }

  void postAssessmentScore() async {
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
            print('lesson 3');
            print(scores);
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
              score3 = totalScore ~/ numberOfScores;
            } else {
              score3 = 0;
            }
          }else{
            print('none');
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
    setState(() { });
  }


  @override
  Widget build(BuildContext context) {
    print('SCORES');
    print(score1);
    print(score2);
    print(score3);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
            width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Choose.jpg'),
                  fit: BoxFit.cover, 
                ),
              ),
              child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 70,),
                    Text("Progress History",style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                    Container(
                      width: 300,
                      height: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('lesson 1: '),
                          Text(score1.toString() + "%"),
                        ],
                      ),
                    ),
                    Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        SizedBox(height: 0,),
                        Container(
                          width: 300, 
                          height: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.grey, 
                          ),
                        ),
                        Container(
                          width: score1 * 3, 
                          height: 10, 
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              bottomLeft: Radius.circular(25),
                              topRight: Radius.circular(0), 
                              bottomRight: Radius.circular(0), 
                            ),
                            color: Colors.blue, 
                          ),
                        ),
                      ],
                    ),
              
                    SizedBox(height: 15,),
                    Container(
                      width: 300,
                      height: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('lesson 2: '),
                          Text(score2.toString()+ "%"),
                        ],
                      ),
                    ),
                    Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        SizedBox(height: 0,),
                        Container(
                          width: 300, 
                          height: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.grey, 
                          ),
                        ),
                        Container(
                          width: score2 * 3, 
                          height: 10, 
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              bottomLeft: Radius.circular(25),
                              topRight: Radius.circular(0), 
                              bottomRight: Radius.circular(0), 
                            ),
                            color: Colors.blue, 
                          ),
                        ),
                      ],
                    ),
              
                    SizedBox(height: 15,),
                    Container(
                      width: 300,
                      height: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('lesson 3: '),
                          Text(score3.toString()+ "%"),
                        ],
                      ),
                    ),
                    Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        SizedBox(height: 0,),
                        Container(
                          width: 300, 
                          height: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.grey, 
                          ),
                        ),
                        Container(
                          width: score3 * 3, 
                          height: 10, 
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              bottomLeft: Radius.circular(25),
                              topRight: Radius.circular(0), 
                              bottomRight: Radius.circular(0), 
                            ),
                            color: Colors.blue, 
                          ),
                        ),
                      ],
                    ),
              
                    SizedBox(height: 15,),
                    Container(
                      width: 300,
                      height: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('lesson 4: '),
                          Text(score4.toString()+ "%"),
                        ],
                      ),
                    ),
                    Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        SizedBox(height: 0,),
                        Container(
                          width: 300, 
                          height: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.grey, 
                          ),
                        ),
                        Container(
                          width: score4 * 3, 
                          height: 10, 
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              bottomLeft: Radius.circular(25),
                              topRight: Radius.circular(0), 
                              bottomRight: Radius.circular(0), 
                            ),
                            color: Colors.blue, 
                          ),
                        ),
                      ],
                    ),
              
                    SizedBox(height: 15,),
                    Container(
                      width: 300,
                      height: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('lesson 5: '),
                          Text(score5.toString()+ "%"),
                        ],
                      ),
                    ),
                    Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        SizedBox(height: 0,),
                        Container(
                          width: 300, 
                          height: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.grey, 
                          ),
                        ),
                        Container(
                          width: score5 * 3, 
                          height: 10, 
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              bottomLeft: Radius.circular(25),
                              topRight: Radius.circular(0), 
                              bottomRight: Radius.circular(0), 
                            ),
                            color: Colors.blue, 
                          ),
                        ),
                      ],
                    ),
              
                    SizedBox(height: 15,),
                    Container(
                      width: 300,
                      height: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('lesson 6: '),
                          Text(score6.toString()+ "%"),
                        ],
                      ),
                    ),
                    Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        SizedBox(height: 0,),
                        Container(
                          width: 300, 
                          height: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.grey, 
                          ),
                        ),
                        Container(
                          width: score6 * 3, 
                          height: 10, 
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              bottomLeft: Radius.circular(25),
                              topRight: Radius.circular(0), 
                              bottomRight: Radius.circular(0), 
                            ),
                            color: Colors.blue, 
                          ),
                        ),
                      ],
                    ),
              
                    SizedBox(height: 15,),
                    Container(
                      width: 300,
                      height: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('lesson 7: '),
                          Text(score7.toString()+ "%"),
                        ],
                      ),
                    ),
                    Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        SizedBox(height: 0,),
                        Container(
                          width: 300, 
                          height: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.grey, 
                          ),
                        ),
                        Container(
                          width: score7 * 3, 
                          height: 10, 
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              bottomLeft: Radius.circular(25),
                              topRight: Radius.circular(0), 
                              bottomRight: Radius.circular(0), 
                            ),
                            color: Colors.blue, 
                          ),
                        ),
                      ],
                    ),
              
                    SizedBox(height: 15,),
                    Container(
                      width: 300,
                      height: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('lesson 8: '),
                          Text(score8.toString()+ "%"),
                        ],
                      ),
                    ),
                    Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        SizedBox(height: 0,),
                        Container(
                          width: 300, 
                          height: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.grey, 
                          ),
                        ),
                        Container(
                          width: score8 * 3, 
                          height: 10, 
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              bottomLeft: Radius.circular(25),
                              topRight: Radius.circular(0), 
                              bottomRight: Radius.circular(0), 
                            ),
                            color: Colors.blue, 
                          ),
                        ),
                      ],
                    ),
              
                    SizedBox(height: 15,),
                    Container(
                      width: 300,
                      height: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('lesson 9: '),
                          Text(score9.toString()+ "%"),
                        ],
                      ),
                    ),
                    Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        SizedBox(height: 0,),
                        Container(
                          width: 300, 
                          height: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.grey, 
                          ),
                        ),
                        Container(
                          width: score9 * 3, 
                          height: 10, 
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              bottomLeft: Radius.circular(25),
                              topRight: Radius.circular(0), 
                              bottomRight: Radius.circular(0), 
                            ),
                            color: Colors.blue, 
                          ),
                        ),
                      ],
                    ),
              
                    SizedBox(height: 15,),
                    Container(
                      width: 300,
                      height: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('lesson 10: '),
                          Text(score10.toString()+ "%"),
                        ],
                      ),
                    ),
                    Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        SizedBox(height: 0,),
                        Container(
                          width: 300, 
                          height: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.grey, 
                          ),
                        ),
                        Container(
                          width: score10 * 3, 
                          height: 10, 
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              bottomLeft: Radius.circular(25),
                              topRight: Radius.circular(0), 
                              bottomRight: Radius.circular(0), 
                            ),
                            color: Colors.blue, 
                          ),
                        ),
                      ],
                    ),
              
                    SizedBox(height: 15,),
                    Container(
                      width: 300,
                      height: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('lesson 11: '),
                          Text(score11.toString()+ "%"),
                        ],
                      ),
                    ),
                    Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        SizedBox(height: 0,),
                        Container(
                          width: 300, 
                          height: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.grey, 
                          ),
                        ),
                        Container(
                          width: score11 * 3, 
                          height: 10, 
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              bottomLeft: Radius.circular(25),
                              topRight: Radius.circular(0), 
                              bottomRight: Radius.circular(0), 
                            ),
                            color: Colors.blue, 
                          ),
                        ),
                      ],
                    ),
              
                    SizedBox(height: 15,),
                    Container(
                      width: 300,
                      height: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('lesson 12: '),
                          Text(score12.toString()+ "%"),
                        ],
                      ),
                    ),
                    Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        SizedBox(height: 0,),
                        Container(
                          width: 300, 
                          height: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.grey, 
                          ),
                        ),
                        Container(
                          width: score12 * 3, 
                          height: 10, 
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              bottomLeft: Radius.circular(25),
                              topRight: Radius.circular(0), 
                              bottomRight: Radius.circular(0), 
                            ),
                            color: Colors.blue, 
                          ),
                        ),
                      ],
                    ),
              
                    SizedBox(height: 15,),
                    Container(
                      width: 300,
                      height: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('lesson 13: '),
                          Text(score13.toString()+ "%"),
                        ],
                      ),
                    ),
                    Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        SizedBox(height: 0,),
                        Container(
                          width: 300, 
                          height: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.grey, 
                          ),
                        ),
                        Container(
                          width: score13 * 3, 
                          height: 10, 
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              bottomLeft: Radius.circular(25),
                              topRight: Radius.circular(0), 
                              bottomRight: Radius.circular(0), 
                            ),
                            color: Colors.blue, 
                          ),
                        ),
                      ],
                    ),
              
                    SizedBox(height: 15,),
                    Container(
                      width: 300,
                      height: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('lesson 14: '),
                          Text(score14.toString()+ "%"),
                        ],
                      ),
                    ),
                    Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        SizedBox(height: 0,),
                        Container(
                          width: 300, 
                          height: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.grey, 
                          ),
                        ),
                        Container(
                          width: score14 * 3, 
                          height: 10, 
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              bottomLeft: Radius.circular(25),
                              topRight: Radius.circular(0), 
                              bottomRight: Radius.circular(0), 
                            ),
                            color: Colors.blue, 
                          ),
                        ),
                      ],
                    ),
              
                    SizedBox(height: 15,),
                    Container(
                      width: 300,
                      height: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('lesson 15: '),
                          Text(score15.toString()+ "%"),
                        ],
                      ),
                    ),
                    Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        SizedBox(height: 0,),
                        Container(
                          width: 300, 
                          height: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.grey, 
                          ),
                        ),
                        Container(
                          width: score15 * 3, 
                          height: 10, 
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              bottomLeft: Radius.circular(25),
                              topRight: Radius.circular(0), 
                              bottomRight: Radius.circular(0), 
                            ),
                            color: Colors.blue, 
                          ),
                        ),
                      ],
                    ),
              
                    SizedBox(height: 15,),
                    Container(
                      width: 300,
                      height: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('lesson 16: '),
                          Text(score16.toString()+ "%"),
                        ],
                      ),
                    ),
                    Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        SizedBox(height: 0,),
                        Container(
                          width: 300, 
                          height: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.grey, 
                          ),
                        ),
                        Container(
                          width: score16 * 3, 
                          height: 10, 
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              bottomLeft: Radius.circular(25),
                              topRight: Radius.circular(0), 
                              bottomRight: Radius.circular(0), 
                            ),
                            color: Colors.blue, 
                          ),
                        ),
                      ],
                    ),
              
                    SizedBox(height: 15,),
                    Container(
                      width: 300,
                      height: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('lesson 17: '),
                          Text(score17.toString()+ "%"),
                        ],
                      ),
                    ),
                    Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        SizedBox(height: 0,),
                        Container(
                          width: 300, 
                          height: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.grey, 
                          ),
                        ),
                        Container(
                          width: score17 * 3, 
                          height: 10, 
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              bottomLeft: Radius.circular(25),
                              topRight: Radius.circular(0), 
                              bottomRight: Radius.circular(0), 
                            ),
                            color: Colors.blue, 
                          ),
                        ),
                      ],
                    ),
              
                    SizedBox(height: 15,),
                    Container(
                      width: 300,
                      height: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('lesson 18: '),
                          Text(score18.toString()+ "%"),
                        ],
                      ),
                    ),
                    Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        SizedBox(height: 0,),
                        Container(
                          width: 300, 
                          height: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.grey, 
                          ),
                        ),
                        Container(
                          width: score18 * 3, 
                          height: 10, 
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              bottomLeft: Radius.circular(25),
                              topRight: Radius.circular(0), 
                              bottomRight: Radius.circular(0), 
                            ),
                            color: Colors.blue, 
                          ),
                        ),
                      ],
                    ),
              
                    SizedBox(height: 15,),
                    Container(
                      width: 300,
                      height: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('lesson 19: '),
                          Text(score19.toString()+ "%"),
                        ],
                      ),
                    ),
                    Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        SizedBox(height: 0,),
                        Container(
                          width: 300, 
                          height: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.grey, 
                          ),
                        ),
                        Container(
                          width: score19 * 3, 
                          height: 10, 
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              bottomLeft: Radius.circular(25),
                              topRight: Radius.circular(0), 
                              bottomRight: Radius.circular(0), 
                            ),
                            color: Colors.blue, 
                          ),
                        ),
                      ],
                    ),
              
                    SizedBox(height: 15,),
                    Container(
                      width: 300,
                      height: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('lesson 20: '),
                          Text(score20.toString()+ "%"),
                        ],
                      ),
                    ),
                    
                    Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        SizedBox(height: 0,),
                        Container(
                          width: 300, 
                          height: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.grey, 
                          ),
                        ),
                        Container(
                          width: score20 * 3, 
                          height: 10, 
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              bottomLeft: Radius.circular(25),
                              topRight: Radius.circular(0), 
                              bottomRight: Radius.circular(0), 
                            ),
                            color: Colors.blue, 
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
            ),
            ),
            Positioned(
                    top: 20,
                    right: 20,
                    child: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                        // Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                        //   return ClassRoomScreen(userId: widget.userId);
                        //   }));
                      },
                    ),
                  ),
          ],
        )
      ),
    );
  }
}
