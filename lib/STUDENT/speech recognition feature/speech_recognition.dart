import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:acespeak/STUDENT/speech%20recognition%20feature/score/score.dart';
import 'record.dart';

class SpeechRecognition extends StatefulWidget {
  final String userId;
  final String lesson;
  final String grade;
  SpeechRecognition(
      {Key? key,
      required this.userId,
      required this.lesson,
      required this.grade})
      : super(key: key);

  @override
  _SpeechRecognitionState createState() => _SpeechRecognitionState();
}

class _SpeechRecognitionState extends State<SpeechRecognition> {
  
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
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('words')
          .where('Grade', isEqualTo: widget.grade)
          .get();

      print('Fetched ${snapshot.docs.length} documents');

      if (snapshot.docs.isEmpty) {
        print('No documents found with grade');
        return;
      }

      final firstDocument = snapshot.docs.first;
      final levelData = firstDocument[widget.lesson];
      if (levelData == null) {
        print('No "level " data found in the first document.');
        return;
      }

      setState(() {
        level = List<String>.from(levelData);
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
          .doc(widget.userId)
          .get();

      if (!snapshot.exists) {
        lesson();
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
              return ScoreScreen(userId: widget.userId, lesson: widget.lesson);
            }));
          } else {
            lesson();
          }
        });
        print('Level data: $level');
      } else {
        lesson();
        print('No "level" data found in the document.');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  void initState() {
    number();
    _onUploadComplete();
    super.initState();
  }

  void moveToNextWord() {
    setState(() {
      next = (next + 1) % level.length;
      if (next == 0) {
        Navigator.push(context, MaterialPageRoute(builder: (ctx) {
          return ScoreScreen(userId: widget.userId, lesson: widget.lesson);
        }));
      }
    });
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
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                child: Padding(
                  padding: EdgeInsets.all(22),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(level.isNotEmpty ? level[next] : 'Loading...'),
                      ElevatedButton(
                        onPressed:
                            level.isNotEmpty ? () => Speak(level[next]) : null,
                        child: Text('AUDIO'),
                      ),
                      SizedBox(height: 20),
                      DropdownButton<double>(
                        value: speechRate,
                        onChanged: (double? newValue) {
                          setState(() {
                            speechRate = newValue!;
                          });
                        },
                        items: [
                          DropdownMenuItem<double>(
                            value: 1.75,
                            child: Text('1.75x'),
                          ),
                          DropdownMenuItem<double>(
                            value: 1.50,
                            child: Text('1.50x'),
                          ),
                          DropdownMenuItem<double>(
                            value: 1.25,
                            child: Text('1.25x'),
                          ),
                          DropdownMenuItem<double>(
                            value: 1.00,
                            child: Text('Normal (1.00x)'),
                          ),
                          DropdownMenuItem<double>(
                            value: 0.75,
                            child: Text('0.75x'),
                          ),
                          DropdownMenuItem<double>(
                            value: 0.50,
                            child: Text('0.50x'),
                          ),
                          DropdownMenuItem<double>(
                            value: 0.25,
                            child: Text('0.25x'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: FeatureButtonsView(
                onUploadComplete: _onUploadComplete,
                moveToNextWord: moveToNextWord,
                level: level.isNotEmpty ? level[next] : 'No data available',
                isLevelEmpty: level.isEmpty,
                userId: widget.userId,
                lesson: widget.lesson,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
