import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'assessment_record.dart';
import 'score/assessment_score.dart';

class AssessmentSpeech extends StatefulWidget {
  final String userId;
  final String lesson = 'assessment';
  final String grade;
  AssessmentSpeech(
      {Key? key,
      required this.userId,
      required this.grade})
      : super(key: key);

  @override
  _AssessmentSpeechState createState() => _AssessmentSpeechState();
}

class _AssessmentSpeechState extends State<AssessmentSpeech> {
  List<Reference> references = [];
  final FlutterTts flutterTts = FlutterTts();
  double speechRate = 0.50;
  List<String> level = [];
  int next = 0;

  Speak(text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1);
    await flutterTts.setSpeechRate(speechRate);
    await flutterTts.speak(text);
  }

  Future<void> lesson() async {
    var docID;
      if(widget.grade == 'Grade 1'){
        docID = 'klpfg14MaQIRm5yfqk4u';
      }
      else if(widget.grade == 'Grade 2'){
        docID = 'VSqeQfpysqAkYYHhSWGA';
      }
      else if(widget.grade == 'Grade 3'){
        docID = '1sX5TLd6MXl8kQD42q43';
      }
      else if(widget.grade == 'Grade 4'){
        docID = '5hlL0bScnBpTJaPFDcWt';
      }
      else if(widget.grade == 'Grade 5'){
        docID = 'EmjyO4Qf9dBU8zYmpZct';
      }
      else if(widget.grade == 'Grade 6'){
        docID = 'I7v0oFqQeVnrBR3hF9qm';
      }
      else{
        print('check your grade level');
      }

    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('lessons')
          .doc(docID)
          .get();

      if (!snapshot.exists) {
        print('No document found with the provided docID');
        return;
      }

      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      if (data == null || data.isEmpty) {
        print('Document data is empty');
        return;
      }

      if (!data.containsKey(widget.lesson)) {
        print('No data found for the specified lesson');
        return;
      }

      List<dynamic> levelData = data['assessment'] as List<dynamic>;
      if (levelData == null || levelData.isEmpty) {
        print('No data found for the specified lesson level');
        return;
      }

      level = List<String>.from(levelData);
      setState(() {
      });

      print('Level data: $level');
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<void> number() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('score')
          .doc(widget.userId+widget.grade)
          .get();

      if (!snapshot.exists) {
        print('No documents found for the user ID: ${widget.userId}');
        return;
      }

      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      if (data.containsKey(widget.lesson)) {
        setState(() {
          next = List<String>.from(data[widget.lesson]).length;
          print(next);
          if (next == 10) {
            Navigator.push(context, MaterialPageRoute(builder: (ctx) {
              return AssessmentScoreScreen(
                  userId: widget.userId,grade: widget.grade
                );
            }));
          }
        });
        print('Level data: $level');
      } else {
        print('No "level" data found in the document.');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  void initState() {
    number();
    lesson();
    _onUploadComplete();
    super.initState();
  }

  void moveToNextWord() {
  if (level.isNotEmpty) {
    setState(() {
      next = (next + 1) % level.length;
      if (next == 0) {
        Navigator.push(context, MaterialPageRoute(builder: (ctx) {
          return AssessmentScoreScreen(
              userId: widget.userId,
              grade : widget.grade);
        }));
      }
    });
  }
}


  Future<void> _onUploadComplete() async {
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    ListResult listResult =
        await firebaseStorage.ref().child('student_record').list();
    setState(() {
      references = listResult.items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: level.isNotEmpty ? 
      Stack(
      children: [
        Image.asset(
          'assets/images/assessment.png',
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        
        Column(
          children: [
            SizedBox(height: 170),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text('Pre Assessment',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),),
                        Divider( 
                        thickness: 1,
                        color: Color.fromARGB(255, 59, 58, 58),
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: Container(
                          child: Padding(
                            padding: EdgeInsets.all(18),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 230,
                                  height: 230,
                                  decoration: BoxDecoration(
                                    // border: Border.all(
                                    //   color: Colors.black,
                                    //   width: 2.0,
                                    // ),
                                    color: Colors.white,
                                  ),
                                  child: Image.asset(
                                    'assets/assessment/' + widget.grade + '/' + level[next] + '.png',
                                  ),
                                ),
                                Text(
                                  level.isNotEmpty ? level[next] : 'Loading...',
                                  style: TextStyle(
                                    color: Color(0xFF0592F8),
                                    fontSize: 25
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: AssessmentRecord(
                          onUploadComplete: _onUploadComplete,
                          moveToNextWord: moveToNextWord,
                          level: level.isNotEmpty ? level[next] : 'No data available',
                          isLevelEmpty: level.isEmpty,
                          userId: widget.userId,
                          lesson: widget.lesson,
                          grade : widget.grade
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ]
    ) : Center(child: CircularProgressIndicator())
  ); 
 } 
}

