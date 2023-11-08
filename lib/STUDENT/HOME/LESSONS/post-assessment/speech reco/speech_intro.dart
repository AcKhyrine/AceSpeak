import 'package:acespeak/STUDENT/HOME/LESSONS/post-assessment/speech%20reco/speech_speech.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../../map_screen.dart';

class SpeechPostAssessmentInstructionsScreen extends StatefulWidget {
  final String userId;
  final String grade;
  final String pre_assessment;
  int length;
  final String lesson;
SpeechPostAssessmentInstructionsScreen({super.key,
    required this.length,
    required this.userId,
    required this.grade,
    required this.pre_assessment,
    required this.lesson});

  @override
  State<SpeechPostAssessmentInstructionsScreen> createState() => _SpeechPostAssessmentInstructionsScreenState();
}

class _SpeechPostAssessmentInstructionsScreenState extends State<SpeechPostAssessmentInstructionsScreen> {
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
    await flutterTts.speak("Hi learners, the post-assessment for today involves saying the words that are displayed. Click the mic to start recording and the post button to stop. You can listen to your pronunciation and reset. then click the arrow to proceed. goodluck!");
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
                Text('1. Click the microphone to start recording.'),
                SizedBox(height: 8.0),
                Text('2.  Click the pause button to stop recording.'),
                SizedBox(height: 8.0),
                Text('3. You can listen to your pronunciation, and you can repeat it if you want.'),
                SizedBox(height: 8.0),
                Text('4.  Click the arrow button to proceed to the next question.'),
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
                              return SpeechRecoScreen(
                              userId: widget.userId,
                              grade: widget.grade,
                              lesson: widget.lesson, 
                              length: widget.length,
                              pre_assessment: widget.pre_assessment,
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
                              return MapScreen(
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