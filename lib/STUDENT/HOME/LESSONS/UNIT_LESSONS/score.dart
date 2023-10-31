import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../map_screen.dart';
import 'lessons.dart';

class LessonScore extends StatefulWidget {
  final String userId;
  final String grade;
  final String lesson;
  int index;
  final int number;
  final String item;
  List<String> phonic;
  List<String> spell;
  List<String> overall;
  final String score;
  LessonScore({
    Key? key,
    required this.phonic,
    required this.score,
    required this.spell,
    required this.overall,
    required this.userId,
    required this.item,
    required this.grade,
    required this.lesson,
    required this.index,
    required this.number,
  }) : super(key: key);

  @override
  _LessonScoreState createState() => _LessonScoreState();
}

class _LessonScoreState extends State<LessonScore> {
  

  @override
  Widget build(BuildContext context) {
    int? score= int.tryParse(widget.score);
    return Scaffold(
      body: score != null ?
      SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/score.png',
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 180),
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.green,
                        width: 3.0,
                        
                      ),
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: Text(
                      widget.score +'%',
                        style: TextStyle(
                          fontSize: 43,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                    score! >= 90 && score <= 100
                        ? 'Excellent'
                        : score >= 80 && score < 90
                            ? 'Very Good'
                            : score >= 70 && score < 80
                                ? 'Good'
                                : score >= 60 && score < 70
                                    ? 'Fair'
                                    : 'Poor',
                    style: TextStyle(
                      fontSize: 25,
                      color: score > 60 ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  ),
                  ElevatedButton(
                    onPressed: () async {
                        if(widget.index == 11){
                          await FirebaseFirestore.instance
                          .collection('score')
                          .doc(widget.userId+widget.grade)
                          .update({
                            'finished': FieldValue.arrayUnion([widget.item]),
                          });
                          Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                            return MapScreen(
                                userId: widget.userId, grade: widget.grade);
                          }));
                        }
                      else{
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) {
                            return Lesson_Screen(
                              userId: widget.userId,
                              grade: widget.grade,
                              lesson: widget.lesson,
                              index: widget.index,
                              number: widget.number,
                              item: widget.item,
                            );
                          },
                        ),
                      );
                      }
                    },
                    child: Text(widget.index == '11' ? 'Done' : 'Next', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                  ),
                  SizedBox(height: 5),
                  Center(child: Text('Phoneme-level Results', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Spell', style: TextStyle(color: Colors.blue,)),
                      Text('Sound',style: TextStyle(color: Colors.blue,)),
                      Text('Score', style: TextStyle(color: Colors.blue,))
                    ],
                  ),
                  SingleChildScrollView(
                    child: Container(
                      height: 200,
                      child: ListView.builder(
                        itemCount: widget.spell.length, 
                        itemBuilder: (context, index) {
                          if (index < widget.phonic.length && index < widget.overall.length) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(widget.spell[index]),
                                Text(widget.phonic[index]),
                                Text(widget.overall[index]),
                              ],
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),

                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: -10,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                child: Image.asset(
                  'assets/images/grass 1.png',
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
                  return MapScreen(
                    userId: widget.userId, grade: widget.grade);
                  }));
              },
            ),
          ),
          ],
        ),
      ) : Center(
        child: CircularProgressIndicator(),
      )
    );
  }
}
