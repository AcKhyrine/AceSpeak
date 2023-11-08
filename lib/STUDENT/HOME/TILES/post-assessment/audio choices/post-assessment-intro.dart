import 'package:acespeak/STUDENT/HOME/TILES/post-assessment/audio%20choices/test.dart';
import 'package:acespeak/STUDENT/HOME/TILES/tiles_screen.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';


class PostAssessmentInstructionsScreen1 extends StatefulWidget {
  final String userId;
  final String grade;
  final String pre_assessment;
  int length;
  final String lesson;
PostAssessmentInstructionsScreen1({super.key,
    required this.length,
    required this.userId,
    required this.grade,
    required this.pre_assessment,
    required this.lesson,});

  @override
  State<PostAssessmentInstructionsScreen1> createState() => _PostAssessmentInstructionsScreen1State();
}

class _PostAssessmentInstructionsScreen1State extends State<PostAssessmentInstructionsScreen1> {
  final FlutterTts flutterTts = FlutterTts();

  void audioValue() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .get();

      if (!snapshot.exists) {
        print('No documents found for the user ID: ${widget.userId}');
        return;
      }

      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      setState(() {
        if(data['audio'] == "true"){
          audio();
        }
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  void initState() {
    audioValue();
    super.initState();
  }
  void audio()async{
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(0.8);
    await flutterTts.setSpeechRate(0.25);
    await flutterTts.speak("Hello, these are your post-assessment instructions. First, you must listen to the pronunciation carefully by clicking the choices a, b, c, and d. After listening, choose the best pronunciation, and then click next to proceed to the next pronunciation. Goodluck!");
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
            image: AssetImage('assets/images/instructions.png'), 
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 33, right: 27, top: 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20,),
                Center(
                  child: Text(
                    'Instructions:',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Text('1. Listen to the pronunciations carefully.'),
                SizedBox(height: 8.0),
                Text('2. Click on choices A, B, C, and D to hear the pronunciations.'),
                SizedBox(height: 8.0),
                Text('3. After listening to all options, choose the best pronunciation.'),
                SizedBox(height: 8.0),
                Text('4. Click "Next" to proceed to the next question.'),
                SizedBox(height: 16.0),
                Center(
                  child: Text(
                    'Good luck!',
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(20), 
                        ),
                        height: 40,
                        child: TextButton(
                          onPressed: () {
                            flutterTts.stop();
                            Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                              return Post_Assessment_Screen1(
                              userId: widget.userId,
                              grade: widget.grade,
                              pre_assessment: widget.pre_assessment,
                              length: widget.length,
                              lesson: widget.lesson,
                            );
                            }));
                          },
                          child: Text('Start Assessment', style: TextStyle(color:Colors.black)),
                        ),
                      ),
                      SizedBox(height: 3),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20), 
                        ),
                        child: TextButton(
                          onPressed: () {
                            flutterTts.stop();
                            Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                              return TilesScreen(
                                userId: widget.userId, grade: widget.grade);
                            }));
                          },
                          child: Text('Cancel', style: TextStyle(color:Colors.black),),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}