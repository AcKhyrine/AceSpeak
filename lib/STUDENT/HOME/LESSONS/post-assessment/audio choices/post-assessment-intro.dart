import 'package:acespeak/STUDENT/HOME/LESSONS/post-assessment/audio%20choices/test.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../map_screen.dart';

class PostAssessmentInstructionsScreen extends StatefulWidget {
  final String userId;
  final String grade;
  final String pre_assessment;
  int length;
  final String lesson;
PostAssessmentInstructionsScreen({super.key,
    required this.length,
    required this.userId,
    required this.grade,
    required this.pre_assessment,
    required this.lesson,});

  @override
  State<PostAssessmentInstructionsScreen> createState() => _PostAssessmentInstructionsScreenState();
}

class _PostAssessmentInstructionsScreenState extends State<PostAssessmentInstructionsScreen> {
  final player = AudioPlayer();
  Future<void> playAudio(String url) async{
    await player.setPlaybackRate(.75);
    await Future.delayed(Duration(seconds: 1));
    await player.play(UrlSource(url));
  }

  String _audio = "true";
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
      playAudio('https://firebasestorage.googleapis.com/v0/b/casptone-14c19.appspot.com/o/audio%2Finstructions.mp3?alt=media&token=062797aa-4e5a-4afb-82cf-4e9ad8e99709');
    }
  }
  @override
  void initState() {
    audioValue();
    super.initState();
  }
  @override
  void dispose() {
    playAudio('https://firebasestorage.googleapis.com/v0/b/casptone-14c19.appspot.com/o/audio%2Finstructions.mp3?alt=media&token=062797aa-4e5a-4afb-82cf-4e9ad8e99709');
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
                            player.stop();
                            Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                              return Post_Assessment_Screen(
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