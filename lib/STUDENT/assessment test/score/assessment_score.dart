import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../MAIN FEATURE/student_classroom.dart';
import 'package:audioplayers/audioplayers.dart';
class AssessmentScoreScreen extends StatefulWidget {
  final String userId;
  final String lesson;
  final String grade;
  final String classroomID;
  final String classCode;
  const AssessmentScoreScreen({super.key, required this.classCode, required this.userId, required this.lesson, required this.grade, required this.classroomID});

  @override
  State<AssessmentScoreScreen> createState() => _AssessmentScoreScreenState();
}

class _AssessmentScoreScreenState extends State<AssessmentScoreScreen> {

  final player = AudioPlayer();
  Future<void> playAudio(String url) async{
    await Future.delayed(Duration(seconds: 1));
    await player.play(UrlSource(url));
    print("Playing...");
    await Future.delayed(Duration(seconds: 13));
    Navigator.push(context, MaterialPageRoute(builder: (ctx){
      return ClassRoomScreen(userId: widget.userId, grade : widget.grade, classroomID : widget.classroomID);
    }));
  }

  @override
  void initState() {
    playAudio('https://firebasestorage.googleapis.com/v0/b/casptone-14c19.appspot.com/o/audio%2Fdownload%20(2).mp3?alt=media&token=8c0d576c-c456-42a5-a9fc-555fc088f193');
    super.initState();
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/bg1.png',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Text(
                            ' Great Job!',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        Text(
                          "You've completed the assessment. You're ready to make the most of our app to learn and grow. Let's go!",
                        ),
                        SizedBox(height: 10,),
                        // ElevatedButton(
                        //   onPressed: () {
                        //     player.pause();
                        //     Navigator.push(context, MaterialPageRoute(builder: (ctx){
                        //       return ClassRoomScreen(userId: widget.userId, grade : widget.grade);
                        //     }));
                        //   },
                        //   child: Text('Next'),
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Image.asset('assets/images/talking lion.gif'), 
        ),
      ],
    ),
  );
}
}