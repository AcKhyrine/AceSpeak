import 'package:acespeak/STUDENT/HOME/LESSONS/post-assessment/speech%20reco/speech_speech.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
  final player = AudioPlayer();
  
  Future<void> playAudio(String url) async{
    AudioPlayer player = AudioPlayer();
  await player.setPlaybackRate(.75);
  await Future.delayed(Duration(seconds: 1));
  await player.play(UrlSource(url));
    // await Future.delayed(Duration(seconds: 1));
    // await player.play(UrlSource(url));
  }

   String _audio = "";
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
        setState(() {
          _audio = data['audio'];
        });
        print(_audio+"...............................................................");
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
    if(_audio == "true"){
      playAudio('https://firebasestorage.googleapis.com/v0/b/casptone-14c19.appspot.com/o/audio%2Finstructions2.mp3?alt=media&token=4b6c7005-59a9-46be-8007-e81eed4f4506');
    }
  }

  @override
  void initState() {
    audioValue();
    super.initState();
  }
  @override
  void dispose() {
    player.stop();
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
                            setState(() {
                              _audio = "false";
                            });
                            player.stop();
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
                            player.stop();
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