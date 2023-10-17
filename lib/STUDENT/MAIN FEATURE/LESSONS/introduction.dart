import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../map_screen.dart';
import 'lessons.dart';

class LessonIntro extends StatefulWidget {
  final String userId;
  final String grade;
  final String lesson;
  final int index;
  final int number;
  final String item;
  final String classroomID;
  const LessonIntro({super.key,required this.classroomID, required this.userId, required this.item, required this.grade, required this.lesson, required this.index, required this.number});

  @override
  State<LessonIntro> createState() => _LessonIntroState();
}

class _LessonIntroState extends State<LessonIntro> {
  final FlutterTts flutterTts = FlutterTts();
  String docID = '';
  String intro = '';
  
  @override
  void initState() {
    super.initState();
    Introduction();
    print(widget.lesson);
  }

  void Introduction() async {
    if(widget.grade == 'Grade 6'){ // change this into grade 1 later
      docID = 'I7v0oFqQeVnrBR3hF9qm';
    }
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('lessons')
          .doc(docID)
          .get();

      if (!snapshot.exists) {
        print('No documents found for the user ID: ${widget.userId}');
        return;
      }

      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      setState(() {
         intro = data['intro ' + widget.lesson];
         audio();
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void audio()async{
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(0.8);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak(intro);
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/frame.jpg'), 
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: GestureDetector(
                    onTap: (){
                      audio();
                    },
                    child: Text(
                      intro,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 60, right: 60),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          await FirebaseFirestore.instance
                            .collection('score')
                            .doc(widget.userId)
                            .update({
                              widget.item : 1,
                            });

                          flutterTts.stop();
                          Navigator.push(context, MaterialPageRoute(builder: (ctx){
                            return Lesson_Screen(classroomID : widget.classroomID,userId: widget.userId, grade: widget.grade, lesson: widget.lesson, index: widget.index, number: widget.number, item: widget.item,);
                          }));
                        },
                        child: Text('Start'),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 60, right: 60),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          flutterTts.stop();
                          Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                            return MapScreen(
                                userId: widget.userId, grade: widget.grade, classroomID : widget.classroomID);
                          }));
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
                        ),
                        child: Text('Cancel'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}