import 'package:acespeak/STUDENT/MAIN%20FEATURE/post-assessment/speech%20reco/score_load.dart';
import 'package:acespeak/STUDENT/MAIN%20FEATURE/post-assessment/speech%20reco/speech_record.dart';
import 'package:acespeak/STUDENT/MAIN%20FEATURE/post-assessment/speech%20reco/speech_score.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:acespeak/STUDENT/speech%20recognition%20feature/score/score.dart';

class SpeechRecoScreen extends StatefulWidget {
  final String userId;
  final String grade;
  final String pre_assessment;
  int length;
  final String lesson;
  final String classroomID;
  SpeechRecoScreen(
      {Key? key,
      required this.length,
      required this.userId,
      required this.grade,
      required this.pre_assessment,
      required this.classroomID,
      required this.lesson,})
      : super(key: key);

  @override
  _SpeechRecoScreenState createState() => _SpeechRecoScreenState();
}

class _SpeechRecoScreenState extends State<SpeechRecoScreen> {
  List<Reference> references = [];
  final FlutterTts flutterTts = FlutterTts();
  double speechRate = 0.50;
  List<String> level = [];
  int next = 0;
  List<String> scores =[];
  var docID;
  String downloadURL = '';
  Speak(text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1);
    await flutterTts.setSpeechRate(speechRate);
    await flutterTts.speak(text);
  }

  void initState() {
    // number();
    lesson();
    _onUploadComplete();
    super.initState();
  }

  String _classCode = '';
  void classCode()async{
      try {
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('classroom')
            .doc(widget.classroomID)
            .get();

        if (!snapshot.exists) {
          print('No documents found for the user ID: ${widget.userId}');
          return;
        }

        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
          setState(() {
            _classCode = data['Class Code'];
          });
          print(_classCode);
      } catch (e) {
        print('Error fetching data: $e');
      }
    }

  Future<void> lesson() async {
    print('post-assessment' + widget.pre_assessment);
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
      print('post-assessment' + widget.pre_assessment);
      if (!data.containsKey('post-assessment' + widget.pre_assessment)) {
        print('No data found for the specified lesson');
        return;
      }

      List<dynamic> levelData = data['post-assessment' + widget.pre_assessment] as List<dynamic>;
      print(levelData);
      if (levelData == null || levelData.isEmpty) {
        print('No data found for the specified lesson level');
        return;
      }

      level = List<String>.from(levelData);
      getImageDownloadURL(level[next]);
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
          .doc(widget.userId+_classCode)
          .get();

      if (!snapshot.exists) {
        print('No documents found for the user ID: ${widget.userId}');
        return;
      }

      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      if (data.containsKey( widget.lesson+' lesson')) {
        setState(() {
          next = List<String>.from(data[widget.lesson+' lesson']).length;
          getImageDownloadURL(level[next]);
          print(next);
          if (next == 10) {
            print('NUMBER... END');
            Navigator.push(context, MaterialPageRoute(builder: (ctx) {
              return Loading_scores(
                  userId: widget.userId,
                  lesson: widget.lesson,
                  grade: widget.grade, 
                  docId: docID,
                  pre_assessment: widget.pre_assessment,
                  classroomID : widget.classroomID
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

   Future<String?> getImageDownloadURL(picture) async {
    print(picture);
    try {
      Reference reference = FirebaseStorage.instance.ref('images/'+picture+'.png');
      downloadURL = await reference.getDownloadURL();
      print(downloadURL);
      setState(() {});
    } catch (e) {
      print('Error getting image download URL: $e');
      return null; 
    }
    return null;
  }

  void moveToNextWord() {
  if (level.isNotEmpty) {
    setState(() {
      next = (next + 1) % level.length;
      getImageDownloadURL(level[next]);
      if (next == 0) {
        print('MOVETONEXT.. END');
        Navigator.push(context, MaterialPageRoute(builder: (ctx) {
          return Loading_scores(
              userId: widget.userId,
              lesson: widget.lesson,
              grade: widget.grade,
              docId: docID,
              pre_assessment: widget.pre_assessment,
              classroomID : widget.classroomID
              );
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
    int n = next +1;
    return Scaffold(
      body: Stack(
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
                      SizedBox(height: 5,),
                      Text(n.toString()+'/10'),
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
                                  child: downloadURL != '' ? Image.network(downloadURL) 
                                  : CircularProgressIndicator()
                                  // Image.asset(
                                  //   'assets/lessons/' + widget.lesson  + ' lesson/' + level[next] + '.png',
                                  // ),
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
                        child: SpeechAssessmentRecord(
                          grade: widget.grade,
                          onUploadComplete: _onUploadComplete,
                          moveToNextWord: moveToNextWord,
                          classroomID : widget.classroomID,
                          level: level.isNotEmpty ? level[next] : 'No data available',
                          isLevelEmpty: level.isEmpty,
                          userId: widget.userId,
                          lesson: widget.lesson,
                          docID: docID,
                          pre_assessment :widget.pre_assessment,
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
    )
  ); 
 } 
}

